#!/usr/bin/perl
use LWP 5.64; # Loads all important LWP classes, and makes
                #  sure your version is reasonably recent.
use HTTP::Cookies;
use bigint;
use warnings;

#############################################################################
#				User Options                                #
#############################################################################
my $gname = '';
my $password = '';

#############################################################################
#				    END                                     #
#############################################################################


my $url; my $response; my $fingy;

if ($gname eq '') { print "Enter Username\n"; $username = <STDIN>; }
if ($password eq '') { print "Enter Password\n"; $password = <STDIN>; }

my $browser = LWP::UserAgent->new;
print "Enter Geocaching.com waypoint ID\n";
my $waypoint = <STDIN>;


# Then later, whenever you need to make a get request:
my @ns_headers = (
 'User-Agent' => 'Mozilla/4.76 [en] (Win98; U)',
 'Accept' => 'image/gif, image/x-xbitmap, image/jpeg, 
      image/pjpeg, image/png, */*',
 'Accept-Charset' => 'iso-8859-1,*,utf-8',
 'Accept-Language' => 'en-US',
);

$browser->cookie_jar( HTTP::Cookies->new(
  'file' => '/home/ultramancool/cookies.lwp',
      # where to read/write cookies
  'autosave' => 1,
      # save it to disk when done
));
$browser->agent('Mozilla/4.76 [en] (Win98; U)');
my $url = 'http://www.geocaching.com/login/Default.aspx';
  
my $response = $browser->get( $url );
die "Can't get $url -- ", $response->status_line
 unless $response->is_success;

die "Hey, I was expecting HTML, not ", $response->content_type
unless $response->content_type eq 'text/html';
# or whatever content-type you're equipped to deal with

  # Otherwise, process the content somehow:

if ($response->content =~ /<input type=\"hidden\" name=\"__VIEWSTATE\" value=\"(.*)\"/) {   # parse out values
$fingy = $1;
}
#print $fingy;

 $response2 = $browser->post( $url,
   [
     '__VIEWSTATE' => $fingy, 
     'myUsername' => $username,
     'myPassword' => $password,
     'cookie' => 'checked', 
     'Button1' => 'Login',
   ],
 );
print "\n";
#print $response2->content;

my $url2 = "http://www.geocaching.com/seek/cache_details.aspx?wp=$waypoint";

  
our $response3 = $browser->get( $url2 );
if ($response3->content =~ /<input type=\"hidden\" name=\"__VIEWSTATE\" value=\"(.*)\"/) {   # parse out values
$fingy2 = $1;
}

sub getLoc {

 our $response4 = $browser->post( $url2,
   [
     '__VIEWSTATE' => $fingy2, 
     'btnLocDL.x' => '15',
     'btnLocDL.y' => '9'
   ],
   'Referer' => "http://www.geocaching.com/seek/cache_details.aspx?wp=$waypoint"
 );
if ($response4->content =~ /<loc version=\"1.0\" src=\"Groundspeak\">/) { print $response4->content; } else { print "Failed :-("; }
print "\n";
}

sub makecomm {


print "Enter Log Type:\n";
print "
\"-1\" - Select One - (Dummy)
\"2\" Found it
\"3\" Didn't find it
\"4\" Write note
\"5\" Archive (show)
\"23\" Enable Listing
\"18\" Post Reviewer Note
";
my $typecom = <STDIN>;

print "Enter the month logged\n";
my $mtl = <STDIN>;
print "Enter the day logged\n";
my $daytl = <STDIN>;
print "Enter the year logged\n";
my $ytl = <STDIN>;

print "Enter your actual comment\n";
my $cmmnt = <STDIN>;

if ($response3->content =~ /<tr><td colspan=\"3\" title=\"log your visit\"><a href=\"http:\/\/www.geocaching.com\/seek\/log.aspx\?(.*)\" onMouseOver='xpe\(\"46p7go\"\);/) {   # 'parse out values
$url3 = "http://www.geocaching.com/seek/log.aspx?$1";
}

our $response6 = $browser->get( $url3 );
if ($response6->content =~ /<input type=\"hidden\" name=\"__VIEWSTATE\" value=\"(.*)\"/) {   # parse out values
$fingy3 = $1;
}

if ($response6->content =~ /<input type=\"Hidden\" name=\"LogBookPanel1.DateTimeLogged\" value=\"(.*)\"\s\/>/) {
print $1;
$dtl = $1;
}
print "DTL:" . $dtl . "\n";

print $url3;

 our $response5 = $browser->post( $url3,
   [
     '__EVENTTARGET' => '',
     '__EVENTARGUMENT' => '',
     '__VIEWSTATE' => $fingy3, 
     'LogBookPanel1:ddLogType' => $typecom,
     'LogBookPanel1:DateTimeLogged' => $dtl,
     'LogBookPanel1:DateTimeLogged_month' => $mtl,
     'LogBookPanel1:DateTimeLogged_day' => $daytl,
     'LogBookPanel1:DateTimeLogged_year' => $ytl,
     'LogBookPanel1:tbLogInfo' => $cmmnt,
     'LogBookPanel1:LogButton' => 'Submit log entry',
   ],
 );
print $response5->content;
#print "\n\nDTL:" . $dtl . "\n";
}

sub cacheinfo {

if ($response3->content =~ /<span id=\"CacheName\">(.*)<\/span><span id=\"LargeMapPrint\">/) {   # parse out values
$name = $1;
}

if ($response3->content =~ /<p><span id=\"ShortDescription\">(.*)<\/span><\/p>/) {   # parse out values
$sdes = $1;
}

if ($response3->content =~ /<p><span id=\"LongDescription\">(.*)<\/span><\/p>/) {   # parse out values
$ldes = $1;
}

print "Name:" . $name . "\n\n";
print "Short Description: " . $sdes . "\n\n";
print "Long Description: " . $ldes . "\n";

}

cacheinfo();
makecomm();

print "\n";



