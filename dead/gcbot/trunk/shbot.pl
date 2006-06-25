#!/usr/bin/perl
use LWP 5.64; # Loads all important LWP classes, and makes
                #  sure your version is reasonably recent.
use HTTP::Cookies;
use warnings;
my $url; my $response; my $fingy;
our $browser = LWP::UserAgent->new;
our $testythingy;
our @new;
our %usedhash;
our %attackedhash;
our $i;
$browser->cookie_jar( {} );
$browser->agent('Mozilla/5.0 (compatible; googlebot/3.14195; +http://www.1337w4R3Z53RVER.com/bot.html)');
$url = 'http://www.slavehack.com/login.php';
$browser->get( $url );
 $response = $browser->post( $url,
   [
     'login' => 'ultramancool',
     'loginpas' => 'exalisswag',
   ],
 );
#print $response->content;.
checklog('http://www.slavehack.com/index2.php?page=logs', '');
sub checklog {
my $url2 = $_[0];
 my $responsey = $browser->get( $url2,
   [
     'loginpass' => $_[1],
   ],
 );
our $response3 = $browser->get( $url2 );
parseit( $response3->content );
#print $response3->content;

}
print "\n";

sub attack {
    my $crackattack = $browser->get( "http://www.slavehack.com/index2.php?page=internet&gow=$_[0]&action=crack" );
    if ($crackattack->content =~ /parseInt\(i\)\/(.*)\)\*100\)+/) {
        print "Time to crack " . $1/2 . "s\n";
        #if ($1/2 <= 60) {sleep $1/2} else {print "skipping"};
        sleep $1/2;
        my $responses = $browser->post( "http://www.slavehack.com/index2.php?page=internet&gow=$_[0]&action=crack",
   [
     'bits' => 1,
     'up' => 1,
   ],
    );
        if ($responses->content =~ /The password for .* is <B>(.*)<\/B> \.\.\.make/) {print $1 . "\n"; our $creep = $1} else {print "failed to get password\n"}
                my $response9 = $browser->post( "http://www.slavehack.com/index2.php?page=internet&gow=$_[0]&action=login",
   [
     'loginpass' => $creep,
   ],
    );
        my $response8 = $browser->post( "http://www.slavehack.com/index2.php?page=internet&gow=$_[0]&action=logs" );
        #our @new = ();
        parseit( $response8->content );
        #$i = 0;
    } else {print "failed to get time\n"}
}
our @all;
sub parseit {
    @all = $_[0] =~ m{(\d*\.\d*\.\d*\.\d*)}g;
    for (@all) {
        $testythingy = $_;
        if ($usedhash{$testythingy}) {
        } else {
            push(@new, $testythingy);
            $usedhash{$testythingy} = 1;
        }
    }
    for (@new) {
        our $leet = $_;
        if (!($attackedhash{$leet})) {print "IP: $leet \n"; attack($leet); $attackedhash{$leet} = 1;}# else {print "done already\n"}
        }
}