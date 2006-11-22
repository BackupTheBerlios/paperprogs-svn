#!/usr/bin/perl -w

# Licensed under the OpenBSD license.
#/*
# * Copyright (c) 2006 bacirriu <ultramancool@gmail.com>
# *
# * Permission to use, copy, modify, and distribute this software for any
# * purpose with or without fee is hereby granted, provided that the above
# * copyright notice and this permission notice appear in all copies.
# *
# * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
# */

use Regexp::Common qw /URI/;
use Data::Dumper;
use Text::Wrapper;
use WWW::Search;
use LWP 5.64;
use warnings;
use POE qw(Component::IRC);
use strict;
use HTML::Strip;
use DBI;

my $dbh = DBI->connect("dbi:SQLite:op.db", "", "", {RaiseError => 1, AutoCommit => 1});
my $ver="SVN";
# Shove some globals here
our @opinions;
our $tf = HTML::Strip->new();
our $key = "5jEHB9dQFHLA7jBKTKb9SPvl6sIUO+Q7";
our $udkey = "9bdb4a65fea022ffd0e27a775c75364b";
our $browser = LWP::UserAgent->new;
our $browser2 = LWP::UserAgent->new;
our $wrapper = new Text::Wrapper(columns => 400);
our $botnick = "yapbib";
our $last_text = "";

  my $irc = POE::Component::IRC->spawn( 
  
  	server 		=> 'irc.anoxs.net',
	port		=> '6667',
	nick		=> $botnick,
	ircname	=> '!slang term',
	username	=> 'yapbib2',
   ) or die "Unable to connect to irc server\n $!\n";
POE::Session->create(
        package_states => [
                'main' => [ qw( _start irc_001 irc_public irc_join irc_part irc_msg irc_error parse) ],
        ],
        heap => { irc => $irc },
);
$poe_kernel->run();
  
sub _start {
    my ($kernel,$heap) = @_[KERNEL,HEAP];
    my $irc_session = $heap->{irc}->session_id();
    $kernel->post( $irc_session => register => 'all' );
    $kernel->post( $irc_session => connect => { } );
    undef;
}

sub irc_001 {
    my ($kernel,$sender) = @_[KERNEL,SENDER];
    my $poco_object = $sender->get_heap();
    print "Connected to ", $poco_object->server_name(), "\n";
    my @channels=["\#paperprogs"];
    $kernel->post( $sender => join => '#paperprogs' ) for @channels || die $!;
	sendout($kernel, $sender, '#paperprogs', $tf->parse('Hi everybody')); #"Fix" for the ad spamming block
    undef;
}

sub irc_error {
    my ($kernel,$sender,$error) = @_[KERNEL,SENDER,ARG0];
    undef;
}

  
sub irc_join {
    my ($kernel,$sender,$who) = @_[KERNEL,SENDER,ARG0];
    my $nick = ( split /!/, $who )[0];
    undef;
  }
  
sub irc_public {
   my ($kernel,$sender,$who, $tochan,$what) = @_[KERNEL,SENDER,ARG0,ARG1,ARG2];
    my $nick = ( split /!/, $who )[0];

    for (@{$tochan}){ parse($kernel, $sender, $_, $what, $nick); }
    undef;

}
  
sub irc_part {
    my ($kernel,$sender,$who,$what) = @_[KERNEL,SENDER,ARG0,ARG2];
    my $nick = ( split /!/, $who )[0];
    if ($what eq "") {$what=" ";}
    undef;
    if ($nick eq "yabbib") {print "Channel(Example: #help): ";
    chomp (my $opt3 = <>);
    if ($opt3 !~ m/\A#/) {$opt3="$opt3";print "Using $opt3\n";}
    print "$opt3\n"; $kernel->post($sender=>join=>$opt3);}
}

sub irc_quit {
    my ($kernel,$sender,$who,$what) = @_[KERNEL,SENDER,ARG0,ARG2];
    my $nick = ( split /!/, $who )[0];
    undef;
}


sub irc_msg {
my ($kernel,$sender,$who,$where,$what) = @_[KERNEL,SENDER,ARG0,ARG1,ARG2];
my $nick = ( split /!/, $who )[0];
parse($kernel, $sender, $nick, $what, $nick);
}

sub parse {
my $kernel = shift;
my $sender = shift;
our $destinat = shift; 
our $inputyt = shift;
my $nick = shift;
my $send_text;
#if ($destinat eq $botnick) { our $destinat=$nick }
if ($inputyt =~ /^\!tell (.*) !/) { $destinat = $1; $inputyt =~ s/^\!tell (.*) !//; $inputyt = "!" . $inputyt;}
#if ($destinat eq '') { $destinat = $crip }
	if ($inputyt =~ /^\!killself/) { exit; }
	if ($inputyt =~ /^\!noslang (.+)/) {
		$send_text = slkill($1, $nick);
	}
	if ($inputyt =~ /^\!react (.+)/) {
		$send_text = opinionset($1, $nick);
	}
	if ($inputyt =~ /^\!unreact (.+)/) {
		$send_text = blank($1, $nick);
	}
	if ($inputyt =~ /^\!blankreact (.+)/) {
		$send_text = blankall($1, $nick);
	}
	if (getreplyfromdb($inputyt)) { $send_text = getreplyfromdb($inputyt, $nick); }
	if ($inputyt =~ /^\!google (.+)/) {
		$send_text = googlebot($1, $nick, 0);
	}
	if ($inputyt =~ /^\!explain (.+)/) {
		$send_text = googlebot($1, $nick, 1);
	}
	if ($inputyt =~ /^\!mentalnote (.+)/) {
		takenote($1, $nick);
	}
	if ($inputyt =~ /^\!shownote/) {
		$send_text = shownote($1, $nick);
	}
	if ($inputyt =~ /^\!urban (.+)/) {
		$send_text = urbanbot($1, $nick);
	}
	if ($inputyt =~ /^\!8ball (.+)/) {
		$send_text = ball($1, $nick);
	}
	if ($inputyt =~ /^\!rnd (.+)/) {
		$send_text = rnmbr($1, $nick);
	}
	if ($inputyt =~ /^\!help/) {
		$send_text = help($1, $nick);
	}
	if ($inputyt =~ /^\!commands/) {
		$send_text = cmds($1, $nick);
	}	
	if ($inputyt =~ /^\!tinyurl (.+)/) {
	$send_text = turlbot($1, $nick);
	}
	elsif ($inputyt =~ /($RE{URI}{HTTP})/) {
		$send_text = turlbot($1, $nick);
	} 

	
	
	if ($send_text) { sendout($kernel, $sender, $destinat, $tf->parse($send_text)); }
	$tf->eof;
	$send_text = "";
}

sub sendout {
my $kernel = $_[0];
my $sender = $_[1];
our $user = $_[2];
my @messages = split ('\n', $_[3]);
for (@messages) {
#if ($_[3] ne $last_text)  {
	$kernel->post( $sender => privmsg => $user => $_ );
#	$last_text=$_[3];
}
#}
}


sub takenote {
my $input = shift;
my $nick = shift;
$dbh->do("INSERT INTO notes VALUES ('$nick', '$input')");
}

sub shownote {
my $tehshit;
my $input = $dbh->quote(shift);
my $nick = shift;
my $all = $dbh->selectall_arrayref("SELECT msg FROM notes WHERE user='$nick'");
foreach my $row (@$all) {
  $tehshit = @$row[0] . "\n" . $tehshit;
}
return $tehshit;
}

sub opinionset {
my $input = shift;
my $nick = shift;
my @toadd = split(/-/,$input);
$dbh->do("INSERT INTO opinions VALUES ('$toadd[0]', '$toadd[1]', '$nick')");
}

sub blank {
my $input = shift;
my $nick = shift;
$dbh->do("DELETE FROM opinions WHERE word='$input'");
}

sub blankall {
my $input = shift;
my $nick = shift;
$dbh->do("DELETE FROM opinions");
}

sub getreplyfromdb {
my $tehshit;
my $input = $dbh->quote(shift);
print $input . "\n";
my $all = $dbh->selectall_arrayref("SELECT phrase FROM opinions WHERE word=$input");
foreach my $row (@$all) {
  $tehshit = @$row[0];
}
return $tehshit;
}

sub slkill {

	my $input = shift;
	my $nick = shift;
my ($url, $browser, $response);
$browser->agent('Mozilla/5.0 (compatible; googlebot/3.14195; +http://www.1337w4R3Z53RVER.com/bot.html)');
$url = 'http://www.noslang.com/index.php';
$browser->get( $url );
 $response = $browser->post( $url,
   [
     'action' => 'translate',
     'p' => $input,
     'noswear' => 1, #Keeps the bot clean.
     'nol33t' => 1, #Kills leet. A bonus. :D Actually, I think you need JS on the page to do this, but heh, we'll use it anyways.
     'Submit' => 'Translate Slang'
   ],
 );
if ($response->content =~ /font-family: arial; font-size:12px;\">(.*)<\/span><\/div><br>/) {return $1;} else {return "Uh oh, $nick my regex is messed";}
}

sub turlbot {
my ($url2, $response2);
	my $input = shift;
	my $nick = shift;
$browser2->agent('Mozilla/5.0 (compatible; googlebot/3.14195; +http://www.1337w4R3Z53RVER.com/bot.html)');
$url2 = 'http://tinyurl.com/create.php';
 $response2 = $browser2->post( $url2,
   [
     'url' => $input,
   ],
 );
#print $response2->content;
if ($response2->content =~ /<blockquote><b>(.*)<\/b><br><small>/) {return $1;} else {return "Uh oh $nick! Something went terribly wrong with the TinyURL creation :-(.";}
}
	
sub googlebot {
 my $input = shift;
 my $nick = shift;
 my $explain = shift;
 my $search = WWW::Search->new('Google', key => $key);
 $search->native_query($input);
if ($explain == 1) {
  while (my $result = $search->next_result()) {
    return $result->title;
  }
} else {
  while (my $result = $search->next_result()) {
    return $result->title . " - " . $result->url
  }
}
}

sub urbanbot {
 my $input = shift;
 my $nick = shift;
 my $search = WWW::Search->new('UrbanDictionary', key => $udkey);
 $search->native_query($input);
  while (my $result = $search->next_result()) {
    return $result->{'word'} . " - " . $result->{'definition'}
  }
}

sub ball {
 my $input = shift;
 my $user = shift;
my @answers = ("$user: You don't deserve the answer.", "$user: Google will tell you.", "$user: your IRC client is not sufficiently AJAX-y to view this answer", "$user: of course!", "$user: NEVAH!", "$user: Why the hell are you asking me?!?", "$user: 42", "$user: Please Insert Coin");
my $length = $#answers + 1;
$length = rand($length);
$length = int $length;
return $answers[$length]; 
}

sub rnmbr {
my $input = shift;
my $user = shift;
my $rnd="Must be a Number Value";
if ($input + 0 eq $input)
{
$rnd = int(rand($input))+1;
}
return $rnd;
}

sub help {
my $input = shift;
my $user = shift;
my $msg="*YabBib Version $ver*     Run \'!commands\' to recieve a list of commands.";
return $msg;
}

sub cmds {
my $input = shift;
my $user = shift;
my $output="killself tell noslang react unreact blankeact google explain mentanote shownote urban 8ball rnd help commands tinyurl";
return $output;
}
