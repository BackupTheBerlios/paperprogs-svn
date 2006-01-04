#!/usr/bin/perl
use LWP 5.64; # Loads all important LWP classes, and makes
                #  sure your version is reasonably recent.
use HTTP::Cookies

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

 $response2 = $browser->post( $url, @ns_headers
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

print "\n";



