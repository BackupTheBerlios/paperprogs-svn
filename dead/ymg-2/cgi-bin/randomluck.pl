#!/usr/bin/perl

use CGI;
use DBI;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);

do "db.inc.pl";
my $q = new CGI;
print $q->header( "text/html" );

my $cpass = $q->cookie('passhash');
my $cuser = $q->cookie('username');

if ($cuser eq "") { die "Login First!" }
if ($cpass eq "") { die "Login First!" }


$sql = "select * from users WHERE username='$cuser' AND passhash='$cpass'";

$sth = $dbh->prepare($sql);

$sth->execute || die "Horrible Failure on SQL injection :$!";
my $testme = 0;
#output database results
while (@row=$sth->fetchrow_array) {
	$testme++;
}
if ($testme == 0) { die "Got Login info, but it is incorrect. Be nice, don't pwn me :D" }
our $username = $cuser;

#end login

#CAPTCHA

if ($q->param(capt) eq "") {
my $randid = int(rand(300));

do "pm.pl";
print "Type what you seen in the picture below into the text box, then press enter.<br>";
print "<img src='/captcha/$randid.jpg'>\n <form action=\"randomluck.pl\" method=\"post\">\n <input name=\"capt\" type=\"text\"><br>";
$sql = "UPDATE users SET captcha=$randid WHERE username='$username'";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";
print <<EOF;


</body>

</html>

EOF
exit;
} else {

$sql = "SELECT captcha FROM users WHERE username='$username'";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

while (@row=$sth->fetchrow_array)   {
	our $randidy = @row[0];
}


$sql = "SELECT captcha FROM captcha WHERE id='$randidy'";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

while (@row=$sth->fetchrow_array)   {
	our $captrea = @row[0];
}
my $mycap = $q->param(capt);
$sql = "UPDATE users SET captcha=0 WHERE username='$username'";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";
#print "$captrea and $mycap\n<br>";
if ($q->param(capt) ne $captrea) { print "Incorrect Captcha, learn to type."; exit; }

}

#END


#Print Magic
do "pm.pl";
#End Magic

$sql = "SELECT adventures,credits FROM users WHERE username='$username'";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

while (@row=$sth->fetchrow_array)   {
	our $adventures = @row[0];
	our $credits = @row[1];
}

print "Testing your luck...\n<br> You won:<br>";
if (rand(1000) >= 800) { 
	$adventures = $adventures + 2;
	print "2 adventures<br>\n"; 
	$sql2 = "UPDATE users SET adventures = $adventures WHERE username = '$username' ";
	$sth2 = $dbh->prepare($sql2);
	$sth2->execute || die "Horrible Failure on SQL injection :$!";
} else {print "No adventures<br>";}

@win1 = ("A man walks by and then gives you 1 credit.", "You walk and see a cow.  You Milk it and get 1 credit.", "You find 1 credit on the floor.", "You find 1 credit on the ground.");
$rando = int(rand(@win1));
if (rand(100) <= 10) { 
	$credits++;
	print "@win1[$rando]<br>\n"; 
	$sql2 = "UPDATE users SET credits = $credits WHERE username = '$username' ";
	$sth2 = $dbh->prepare($sql2);
	$sth2->execute || die "Horrible Failure on SQL injection :$!";
} else {print "No credits<br>";}

if ($credits1 >= 1) {
@lose = ("Somebody walks by and takes 1 credit.", "You drop 1 credit.", "You go for a swim and somebody takes 1 credits.", "You buy a ticket to a lotto for 1 credit but you don't win.", "A credit monster stole a credit!");
$rando = int(rand(@lose));
if (rand(100) <= 5) { 
	$credits--;
	print "SPECIAL: @lose[$rando]<br>\n"; 
	$sql2 = "UPDATE users SET credits = $credits WHERE username = '$username' ";
	$sth2 = $dbh->prepare($sql2);
	$sth2->execute || die "Horrible Failure on SQL injection :$!";
}
}

if (rand(100) <= 1) { 
	$adventures = $adventures + 100;
	print "SPECIAL: You won 100 adventures by making a credit monster barf, unfortunately the credits got melted by the stomach acid, but you managed to recover some adventures!<br>\n"; 
	$sql2 = "UPDATE users SET adventures = $adventures WHERE username = '$username' ";
	$sth2 = $dbh->prepare($sql2);
	$sth2->execute || die "Horrible Failure on SQL injection :$!";
}

@super = ("Bill Gates walks by and you take 100 Credits.", "And then there was a light from the sky.  And you hear a voice.  I am the god of GNU take these 100 credits.", "You buy a ticket to a lotto for 0 credits you win 100 credits.");
$rando = int(rand(@super));
if (rand(1000) <= 1) { 
	$credits = $credits + 100;
	print "SPECIAL: @super[$rando]<br>\n"; 
	$sql2 = "UPDATE users SET credits = $credits WHERE username = '$username' ";
	$sth2 = $dbh->prepare($sql2);
	$sth2->execute || die "Horrible Failure on SQL injection :$!";
}

my $randid = int(rand(300));
print "<br>Type what you seen in the picture below into the text box, then press enter.<br>";
print "<img src='/captcha/$randid.jpg'>\n <form action=\"randomluck.pl\" method=\"post\">\n <input name=\"capt\" type=\"text\"><br>";
$sql = "UPDATE users SET captcha=$randid WHERE username='$username'";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

print <<EOF;

</center>
</body>

</html>

EOF

$dbh->disconnect;
