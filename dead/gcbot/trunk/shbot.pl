#!/usr/bin/perl
use LWP 5.64; # Loads all important LWP classes, and makes
                #  sure your version is reasonably recent.
use HTTP::Cookies;
use warnings;
my $url; my $response; my $fingy;
my $browser = LWP::UserAgent->new;
$browser->cookie_jar( {} );
$browser->agent('MSIE :D');
$url = 'http://www.slavehack.com/login.php';
$browser->get( $url );
 $response = $browser->post( $url,
   [
     'login' => 'ultramancool',
     'loginpas' => 'exalisswag',
   ],
 );
#print $response->content;
my $url2 = 'http://www.slavehack.com/index2.php?page=internet&gow=246.185.15.208&action=log';
 my $responsey = $browser->post( $url2,
   [
     'loginpass' => 'xn4hxjde',
   ],
 );
my $response3 = $browser->get( $url2 );
parseit();
#print $response3->content;
our $testythingy;
our @new;
our %usedhash;
sub parseit {
    my $crip = $response3->content;
    my @all = $crip =~ m{(\d*\.\d*\.\d*\.\d*)}g;
    for (@all) {
        $testythingy = $_;
        if ($usedhash{$_}) {
        } else {
            push(@new, $testythingy);
            $usedhash{$testythingy} = 1;
        }
    }
    for (@new) {
        print $_ . "\n ATTACKING!";
        attack($_);
        }
}
print "\n";

sub attack {
    my $crackattack = $browser->get( "http://www.slavehack.com/index2.php?page=internet&gow= $_[1] &action=crack" );
    if ($crackattack->content =~ /parseInt\(i\)\/(.*)\)\*100\)+/) {print $1}
}