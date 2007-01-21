  use strict;
  use warnings;
  use POE qw(Component::IRC);
my $good=0;
my $name="0";
my $uname="0";
my @owners = ("ultra", "aldre-neo", "Jay");
my @fullowners = ("ultra", "aldre-neo");
my @subscribers = ("aldre-neo", "ultra");
print "Server: ";
chomp (my $opt1 = <>);
print "Port(Usually 6667): ";
chomp (my $opt2 = <>);
print "Channel(Example: #help): ";
chomp (my $opt3 = <>);
if ($opt3 !~ m/\A#/) {$opt3="#$opt3";print "Using $opt3\n";}
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
                'main' => [ qw( _start irc_001 irc_public irc_join irc_part irc_msg irc_error) ],
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

    &log($error."\n");
    undef;
  }

  
    sub irc_join {
    my ($kernel,$sender,$who) = @_[KERNEL,SENDER,ARG0];
    my $nick = ( split /!/, $who )[0];
	
	#print the text
	&log("$nick has joined the channel\n");
    undef;

  }
  
  sub irc_public {
   my ($kernel,$sender,$who,$what) = @_[KERNEL,SENDER,ARG0,ARG2];
	if ($what eq "!livia_debug") {$kernel->post( $sender => privmsg => $opt3 => "opt1 is $opt1|opt2 is $opt2|nopt3 is $opt3 |msg_uname is $uname|msg_name is $name");&log("Bot client sent debug to channel\n");}
    my $nick = ( split /!/, $who )[0];
	# this is what was said in the event
   $what=~s/(.)/{ord($1)<32 ? '' :$1}/ge;
	
	#print the text
	&log("$nick> $what\n");
    undef;
  }
  
  sub irc_part {
	
    my ($kernel,$sender,$who,$what) = @_[KERNEL,SENDER,ARG0,ARG2];
    my $nick = ( split /!/, $who )[0];

	#print the text
	&log("$nick has left the channel\n");
    undef;
#	if ($nick eq "Livia") {print "Channel(Example: #help): ";
#chomp (my $opt3 = <>);
#if ($opt3 !~ m/\A#/) {$opt3="#$opt3";print "Using $opt3\n";}
#print "$opt3\n"; $kernel->post($sender=>join=>$opt3);}
}

  sub irc_quit {
	
    my ($kernel,$sender,$who,$what) = @_[KERNEL,SENDER,ARG0,ARG2];
    my $nick = ( split /!/, $who )[0];
	
	#print the text
	&log("$nick has left the server '$what'\n");
    undef;
}


sub irc_msg {

    my ($kernel,$sender,$who,$where,$what) = @_[KERNEL,SENDER,ARG0,ARG1,ARG2];
    my $nick = ( split /!/, $who )[0];
	my $subs = "";
	foreach $subs (@subscribers) {
    $kernel->post( $sender => privmsg => $subs => "Livia: $nick> $what" );
	}
		&log("Private: $nick says $what\n");
			if ($nick eq 'aldre-neo') {
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
	my $owner;
	my $op;
	foreach $owner (@owners) {
	if ($nick eq $owner && $what =~ m/\A9191/) {
		if ( $what =~ m/!say/i )  { $what =~ m/!say *(.*)/;  $kernel->post( $sender => privmsg => $opt3 => "$1");&log("Bot client sent message> $1\n");}
		if ( $what =~ m/!log/i )  { $what =~ m/!log *(.*)/;&log("Bot Client Log: $1\n");}
		
		foreach $op (@fullowners) {
			if ($nick eq $op) {
				#REMOVED UNTILL I ADD RE-ENTER CHANNE: >>>>CODE if ( $what =~ m/!bye/i )  { $kernel->post($sender=>part=>$opt3);}<<<<<
				if ( $what =~ m/!die/i )  { 
				$what =~ m/!die *(.*)/;
				$kernel->post($sender=>quit=>$1);
				exit;
				}	
				if ( $what =~ m/!nick/i ) { $what =~ m/!nick *(.*)/;
				$kernel->post($sender => nick => "$1"); 
				&log("Bot client changed nick to $1\n");}
				if ( $what =~ m/!own/i )  {
				$what =~ m/!own *(.*)/;
				&log("$1 is now an owner\n");
				push(@owners, $1);
				}

				if ( $what =~ m/!op/i )   { 
				$what =~ m/!op *(.*)/;
				&log("$1 is now an op\n");
				push(@fullowners, $1);
				}
				if ( $what =~ m/!mode/i )   { 
				$what =~ m/!mode (.*) (.*) (.*)/;
				$irc->yield( 'mode' => $1 => $2 => $3 );
				&log("$1 $2\n");
				}

				if ( $what =~ m/!op/i )   { 
				$what =~ m/!op *(.*)/;
				&log("$1 is now an op\n");
				push(@fullowners, $1);

				}
				if ( $what =~ m/!chop/i )   { 
				$what =~ m/!chop (.*) (.*) (.*)/;
				$irc->yield( 'mode' => $1 => $2 => $3 );
				&log("$1 $2\n");
				}
			}
			#push(@array, "Data");
		}
		if ( $what =~ m/!help/i ) { $kernel->post( $sender => privmsg => $nick => "1/2 op Commands: 'say, log, and msg' op commands: 'op, own, nick, and die" ); }
		if ( $what =~ m/!subscribe/i )   { $what =~ m/!subscribe *(.*)/;&log("$nick is now a subscriber\n");push(@subscribers, $nick);}
		if ( $what =~ m/!msg/i )  { $what =~ m/!msg *(.*)/;
		if ($name eq "0") {
		$uname=$1;
		$name="1";
		} else { $kernel->post( $sender => privmsg => $uname => "$1" );$name="0";}
		
		}
	}else {$runame="$nick";
		    $rname="1";
			}
			}


    undef;
	
}



  sub log{
my ($log) = @_;
#Append the file

 	    open(MYOUTFILE, ">>irc.log"); #open for write, append
 
( my $sec, my $min, my $hour, my $day, my $month, my $year ) = ( localtime ) [ 0, 1, 2, 3, 4, 5 ];
	printf MYOUTFILE  "%02d:%02d:%02d %02d %s %04d", $hour, $min, $sec, $day, $month, $year+1900 ;
	print MYOUTFILE ": $log";
    printf "%02d:%02d:%02d %02d %s %04d", $hour, $min, $sec, $day, $month, $year+1900 ;
	print ": $log";
 	close(MYOUTFILE);

}

