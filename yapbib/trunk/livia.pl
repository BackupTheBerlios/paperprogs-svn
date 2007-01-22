use strict;
use warnings;
use POE qw(Component::IRC);

my $good=0;
#my $name="0";
#my $uname="0";
my @owners = ("ultra", "aldre-neo", "Jay");
my @fullowners = ("ultra", "aldre-neo");
my @subscribers = ("ultra", "aldre-neo");
my @fsubscribers = ("aldre-neo", "ultra");
print "Server: ";
chomp (my $opt1 = <>);
print "Port(Usually 6667): ";
chomp (my $opt2 = <>);
print "Channel(Example: #help): ";
chomp (my $opt3 = <>);
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
    nick => 'Livia',
    server => $opt1,
    port => $opt2,
    ircname => 'Livia',
	username => 'Livia',
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

    &log($kernel,$sender,$error."\n");
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
	my ($kernel,$sender,$who,$what) = @_[KERNEL,SENDER,ARG0,ARG2];

	my $nick = ( split /!/, $who )[0];
	# this is what was said in the event
	$what=~s/(.)/{ord($1)<32 ? '' :$1}/ge;

	#print the text
	&log($kernel,$sender,"$nick> $what\n","in");
    undef;
}
  
sub irc_part {
    my ($kernel,$sender,$who,$what) = @_[KERNEL,SENDER,ARG0,ARG2];
    my $nick = ( split /!/, $who )[0];

	#print the text
	&log($kernel,$sender,"$nick has left the channel\n");
    undef;
#	if ($nick eq "Livia") {print "Channel(Example: #help): ";
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
		$kernel->post( $sender => privmsg => $subs => "Livia: $nick says $what" );
	}
	&log($kernel,$sender,"Private: $nick says $what\n","in");

	my $owner;
	my $op;
	foreach $owner (@owners) {

	
		if ($nick eq $owner && $what =~ m/\A9191/) {
			if ( $what =~ m/!say/i )  {
				$what =~ m/!say *(.*)/;
				$kernel->post( $sender => privmsg => $opt3 => "$1");
				&log($kernel,$sender,"Bot client sent message> $1\n");
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
								&log ("Responce $1 was sent to $runame\n");
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
						&log($kernel,$sender,"Bot client changed nick to $1\n");}
						
					if ( $what =~ m/!own/i )  {
						$what =~ m/!own *(.*)/;
						&log($kernel,$sender,"$1 is now an owner\n");
						push(@owners, $1);
					}

					if ( $what =~ m/!op/i )   { 
						$what =~ m/!op *(.*)/;
						&log($kernel,$sender,"$1 is now an op\n");
						push(@fullowners, $1);
					}
					
					if ( $what =~ m/!chop/i )   { 
						$what =~ m/!chop (.*) (.*) (.*)/;
						$irc->yield( 'mode' => $1 => $2 => $3 );
						&log($kernel,$sender,"$1 $2\n");
					}
			}
			#push(@array, "Data");
		}
		if ( $what =~ m/!help/i ) {
			$kernel->post( $sender => privmsg => $nick =>
				"1/2 op Commands: 'say, log, subscribe, and msg' op commands: 'op, own, chop, nick, respond, and die"
			);
			
			$kernel->post( $sender => privmsg => $nick =>
				"Say:  Make the bot say something into the channel.  ( *char WHAT TO SAY )"
			);
			
			$kernel->post( $sender => privmsg => $nick =>
				"Log:  Make the bot log something into the bot's console and log file.  ( *char WHAT TO LOG )"
			);
			
			$kernel->post( $sender => privmsg => $nick =>
				"Subscribe:  Subscribe to recive messages sent to the bot.  NOTE: Ops recieve all log messages."
			);	
			
			$kernel->post( $sender => privmsg => $nick =>
				"Msg:  Make the bot message a user on the server.  ( *char USER *char WHAT TO SAY )"
			);	
		
		}
		
		if ( $what =~ m/!subscribe/i )   {
			$what =~ m/!subscribe *(.*)/;
			&log($kernel,$sender,"$nick is now a subscriber\n");
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



sub log{
	my $kernel = shift;
	my $sender = shift;
	my $log = shift;
	my $check = shift;

	#Full Subscribers
	my $fsubs="";
	foreach $fsubs (@fsubscribers) {
	print $fsubs."\n";
	if($check eq "in") {} else {
			$kernel->post( $sender => privmsg => $fsubs => "Livia: $log" );
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

