use strict;
use warnings;
use POE qw(Component::IRC);
use Net::Google;
use Regexp::Common qw /URI/;
use Data::Dumper;
use Text::Wrapper;
use WWW::Search;
use LWP 5.64;
use warnings;
use strict;
use HTML::Strip;
use DBI;
use constant LOCAL_GOOGLE_KEY => "5jEHB9dQFHLA7jBKTKb9SPvl6sIUO+Q7";
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
our $last_text = "";

my $good=0;
#my $name="0";
#my $uname="0";
my @owners = ("ultra", "aldre-neo", "Jay");
my @fullowners = ("ultra", "aldre-neo");
my @subscribers = ("aldre-neo");
my @fsubscribers = ("aldre-neo",);
our $opt1 = 'irc.stealmy.info';
our $opt2='6667';
our $opt3='#Lobby';
if ($opt3 !~ m/\A#/)
{	
	$opt3="#$opt3";print "Using $opt3\n";

}

print "$opt3\n";
my $input="";

my $runame="";
my $rname="";

my @channels = ( $opt3 );

  # We create a new PoCo-IRC object and component.
my $irc = POE::Component::IRC->spawn( 
    nick => 'yapliv',
    server => $opt1,
    port => $opt2,
    ircname => 'yapliv',
	username => 'yapliv',
) or die "Unable to connect to irc server\n $!\n";

POE::Session->create(
    package_states => [
           'main' => [ qw( _start irc_ctcp_action irc_001 irc_public irc_join irc_part irc_msg irc_error) ],
        ],
    heap => { irc => $irc },
);

$poe_kernel->run();
exit 0;

sub _start {
	my ($kernel,$heap) = @_[KERNEL,HEAP];

    # We get the session ID of the component from the object
    # and register and connect to the specified server.
    my $irc_session = $heap->{irc}->session_id();
    $kernel->post( $irc_session => register => 'all' );
    $kernel->post( $irc_session => connect => { } );
    undef;
}

sub irc_001 {
	my ($kernel,$sender) = @_[KERNEL,SENDER];

    # Get the component's object at any time by accessing the heap of
    # the SENDER
    my $poco_object = $sender->get_heap();
    print "Connected to ", $poco_object->server_name(), "\n";

    # In any irc_* events SENDER will be the PoCo-IRC session
    $kernel->post( $sender => join => $_ ) for @channels;
    undef;
}

sub irc_error {
    my ($kernel,$sender,$error) = @_[KERNEL,SENDER,ARG0];

    &log($kernel,$sender,$error."\n","1");
    undef;
}


sub irc_join {
    my ($kernel,$sender,$who) = @_[KERNEL,SENDER,ARG0];
    my $nick = ( split /!/, $who )[0];

	
	#print the text
	&log($kernel,$sender,"$nick has joined the channel\n","in");
    undef;
}
  
sub irc_public {
	my ($kernel,$sender,$who,$tochan,$what) = @_[KERNEL,SENDER,ARG0,ARG1,ARG2];
		my $nick = ( split /!/, $who )[0];
			$what=~s/(.)/{ord($1)<32 ? '' :$1}/ge;
		if ( $what =~ m/!help/i ) {
			$kernel->post( $sender => privmsg => $nick =>
				"Public commands: 'tell, noslang, react, unreact, blankeact, google,
				explain, mentanote, shownote, urban, 8ball, rnd, help,and tinyurl'
				
				1/2 op Commands: 'say, log, unsubscribe, subscribe, and msg'
				
				op commands: 'op, unop, own, unown, chop, nick, respond, fsubscribe, unfsubscribe, and die"
			);
			
			

			
						$kernel->post( $sender => privmsg => $nick =>
				"Tell:  Tell a user something. ( *char USER *char WHAT )"
			);
						$kernel->post( $sender => privmsg => $nick =>
				"Noslang: Removed slang from any text.  ( *char STRING TO UN-SLANG )"
			);
						$kernel->post( $sender => privmsg => $nick =>
				"React:  Make the bot auto-react to something you say.  ( *char WHAT *char WHAT TO DO )"
			);
						$kernel->post( $sender => privmsg => $nick =>
				"Unreact:  Remove a reaction(See: React) ( *char REACTION WHAT )"
			);
			
			$kernel->post( $sender => privmsg => $nick =>
				"Blankreact:  Clears the react database(See: React)"
			);
						$kernel->post( $sender => privmsg => $nick =>
				"Google:  Make the bot your personal google slave. ( *char GOOGLE QUERY )"
			);
						$kernel->post( $sender => privmsg => $nick =>
				"Explain:  Google Light(Only search litle, see 'Google') ( *char GOOGLE QUERY )"
			);
						$kernel->post( $sender => privmsg => $nick =>
				"mentalnote"
			);
			
						$kernel->post( $sender => privmsg => $nick =>
				"shownote"
			);
						$kernel->post( $sender => privmsg => $nick =>
				"urban"
			);
						$kernel->post( $sender => privmsg => $nick =>
				"8ball"
			);
						$kernel->post( $sender => privmsg => $nick =>
				"rnd"
			);
						$kernel->post( $sender => privmsg => $nick =>
				"help"
			);
						$kernel->post( $sender => privmsg => $nick =>
				"tinyurl"
			);
			
			
			$kernel->post( $sender => privmsg => $nick =>
				"Say:  Make the bot say something into the channel.  ( *char WHAT TO SAY )"
			);
			
			$kernel->post( $sender => privmsg => $nick =>
				"Log:  Make the bot log something into the bot's console and log file.  ( *char WHAT TO LOG )"
			);
			
			$kernel->post( $sender => privmsg => $nick =>
				"Subscribe:  Subscribe to recive messages sent to the bot."
			);	
			
			$kernel->post( $sender => privmsg => $nick =>
				"Unubscribe:  UnSubscribe to recive subscribe(See: Subscribe)"
			);	
			
			$kernel->post( $sender => privmsg => $nick =>
				"Msg:  Make the bot message a user on the server.  ( *char USER *char WHAT TO SAY )"
			);	
			
			#Op commands
			
			$kernel->post( $sender => privmsg => $nick =>
				"Op:  Give a user operator permissions to the bot. ( *char USER )"
			);	
			
			$kernel->post( $sender => privmsg => $nick =>
				"Unop:  Remove operator permissions to the bot (See: Op). ( *char USER )"
			);	

			
			$kernel->post( $sender => privmsg => $nick =>
				"Own:  Give a user 1/2 operator permissions to the bot.  ( *char USER)"
			);	

			
			$kernel->post( $sender => privmsg => $nick =>
				"Unown:  Remove 1/2 operator permissions to the bot for a user.  ( *char USER )"
			);	

			
			$kernel->post( $sender => privmsg => $nick =>
				"Chop:  Switch the mode of a user in IRC.  ( *char CHANNEL *char MODE *char USER )"
			);	

			
			$kernel->post( $sender => privmsg => $nick =>
				"Nick:  Change the nick of the bot.  ( *char NEW NICK )"
			);	

			
			$kernel->post( $sender => privmsg => $nick =>
				"Respond:  Use when a message is sent to the bot(Subsribers recieve these messages),
				this will send a reply to the sender of the last message recieved. ( *char RESONCE )"
			);	

			
			$kernel->post( $sender => privmsg => $nick =>
				"Fsubscribe:  Console subscription for a user to recieve more advanced messages. ( *char USER )"
			);	

			
			$kernel->post( $sender => privmsg => $nick =>
				"Funsubscribe:  Unsubscribe a user to Fsubscribe(See Fubscribe) ( *char USER )"
			);	
			
			
			$kernel->post( $sender => privmsg => $nick =>
				"Die:  Kill the bot ( *char EXIT MESSAGE )"
			);	


			
			
		
		}


	# this is what was said in the event


	#print the text
	&log($kernel,$sender,"$nick> $what\n","in");
	for (@{$tochan}){ parse($kernel, $sender, $_, $what, $nick); }
    undef;
}
  
sub irc_part {
    my ($kernel,$sender,$who,$what) = @_[KERNEL,SENDER,ARG0,ARG2];
    my $nick = ( split /!/, $who )[0];

	#print the text
	&log($kernel,$sender,"$nick has left the channel\n","1");
    undef;
#	if ($nick eq "yapliv") {print "Channel(Example: #help): ";
#chomp (my $opt3 = <>);
#if ($opt3 !~ m/\A#/) {$opt3="#$opt3";print "Using $opt3\n";}
#print "$opt3\n"; $kernel->post($sender=>join=>$opt3);}
}


sub irc_ctcp_action {
	my ($kernel,$sender,$who,$where,$what) = @_[KERNEL,SENDER,ARG0,ARG1,ARG2];
	my $nick = ( split /!/, $who )[0];
	# this is what was said in the event
	$what=~s/(.)/{ord($1)<32 ? '' :$1}/ge;
	#print the text
	&log($kernel,$sender,"***$nick> $what***\n","in");
    undef;
}
sub irc_quit {	
    my ($kernel,$sender,$who,$what) = @_[KERNEL,SENDER,ARG0,ARG2];
    my $nick = ( split /!/, $who )[0];
	
	#print the text
	&log($kernel,$sender,"$nick has left the server '$what'\n","in");
    undef;
}


sub irc_msg {

    my ($kernel,$sender,$who,$where,$what) = @_[KERNEL,SENDER,ARG0,ARG1,ARG2];
    my $nick = ( split /!/, $who )[0];
	my $subs = "";
	foreach $subs (@subscribers) {
		$kernel->post( $sender => privmsg => $subs => "yapliv: $nick says $what" );
	}
	&log($kernel,$sender,"Private: $nick says $what\n","in");
    parse($kernel, $sender, $nick, $what, $nick);
	my $owner;
	my $op;
	foreach $owner (@owners) {

	
		if ($nick eq $owner && $what =~ m/\A9191/) {
			if ( $what =~ m/!say/i )  {
				$what =~ m/!say *(.*)/;
				$kernel->post( $sender => privmsg => $opt3 => "$1");
				&log($kernel,$sender,"Bot client sent message> $1\n","1");
			}
			if ( $what =~ m/!log/i )  {
				$what =~ m/!log *(.*)/;
				&log($kernel,$sender,"Bot Client Log: $1\n");
			}
		
			foreach $op (@fullowners) {
			
				foreach $subs (@subscribers) {
					if ($nick eq $subs) {
						if ($rname eq "1") {
							if ($what =~ m/!respond/i){
								$what =~ m/!respond *(.*)/;
								$kernel->post( $sender => privmsg => $runame => "$1" );	
								&log ($kernel,$sender,"Responce $1 was sent to $runame\n","1");
								$runame="";
								$rname="";
							}
						}
					}
				}
			
				if ($nick eq $op) {
				#REMOVED UNTILL I ADD RE-ENTER CHANNE: >>>>CODE if ( $what =~ m/!bye/i )  { $kernel->post($sender=>part=>$opt3);}<<<<<
					if ( $what =~ m/!die/i )  { 
						$what =~ m/!die *(.*)/;
						$kernel->post($sender=>quit=>$1);
						exit;
					}	
					if ( $what =~ m/!nick/i ) {
						$what =~ m/!nick *(.*)/;
						$kernel->post($sender => nick => "$1"); 
						&log($kernel,$sender,"Bot client changed nick to $1\n","1");}
						
					if ( $what =~ m/!own/i )  {
						$what =~ m/!own *(.*)/;
						&log($kernel,$sender,"$1 is now an owner\n","1");
						push(@owners, $1);
					}

					if ( $what =~ m/!op/i )   { 
						$what =~ m/!op *(.*)/;
						&log($kernel,$sender,"$1 is now an op\n","1");
						push(@fullowners, $1);
					}
					
					if ( $what =~ m/!chop/i )   { 
						$what =~ m/!chop (.*) (.*) (.*)/;
						print "$1\n";
						print "$2\n";
						print "$3\n";
						$irc->yield( 'mode' => $1 => $2 => $3 );
						&log($kernel,$sender,"$1 $2\n","1");
					}
			}
			#push(@array, "Data");
		}
		
		if ( $what =~ m/!subscribe/i )   {
			$what =~ m/!subscribe *(.*)/;
			&log($kernel,$sender,"$nick is now a subscriber\n","1");
			push(@subscribers, $nick);
		}
		if ( $what =~ m/!msg/i )  {
				$what =~ m/!msg (.*) (.*)/;
				$kernel->post( $sender => privmsg => $1 => $2 );
			}
		
		}else {$runame="$nick";
			$rname="1";
		}
	}
	undef;
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
	#if ($inputyt =~ /^\!killself/) { exit; }
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
	if ($inputyt =~ /^\!commands/) {
		$send_text = cmds($1, $nick);
	}	
	if ($inputyt =~ /^\!tinyurl (.+)/) {
	$send_text = turlbot($1, $nick);
	}
	elsif ($inputyt =~ /($RE{URI}{HTTP})/) {
		$send_text = turlbot($1, $nick);
	} 

	
	
	if ($send_text) { sendout($kernel, $sender, $destinat, $tf->parse($send_text) ); }
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
my ($url, $response);
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
#my $google = Net::Google->new(key=>LOCAL_GOOGLE_KEY); 
#my $search = $google->search();
#$search->max_results(1);
#map { return $_->title()." - " . $_->URL . "\n"; } 
#@{$search->results()};
#print "well1\n";
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


sub log{
	my $kernel = shift;
	my $sender = shift;
	my $log = shift;
	my $check = shift;

	#Full Subscribers
	my $fsubs="";
	foreach $fsubs (@fsubscribers) {
	if($check eq "in") {} else {
			$kernel->post( $sender => privmsg => $fsubs => "yapliv: $log" );
		}
	}
	#Append the file
 	open(MYOUTFILE, ">>irc.log"); #open for write, append
		( my $sec, my $min, my $hour, my $day, my $month, my $year ) = ( localtime ) [ 0, 1, 2, 3, 4, 5 ];
		printf MYOUTFILE  "%02d:%02d:%02d %02d %s %04d", $hour, $min, $sec, $day, $month+1, $year+1900 ;
		print MYOUTFILE ": $log";
		printf "%02d:%02d:%02d %02d %s %04d", $hour, $min, $sec, $day, $month+1, $year+1900 ;
		print ": $log";
 	close(MYOUTFILE);
}
#EOF

