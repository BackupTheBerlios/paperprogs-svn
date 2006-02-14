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

#Print Magic
$sql = "SELECT adventures,credits,curfight,points,numclub,strength FROM users WHERE username='$username'";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

while (@row=$sth->fetchrow_array)   {
	our $adventures1 = @row[0];
	our $credits1 = @row[1];
	our $curfight1 = @row[2];
	our $points1 = @row[3];
	our $numclub1 = @row[4];
	our $strength1 = @row[5];
}

print <<EOF;


<html>

<head>
<link rel="stylesheet" type="text/css" href="main.css">
</head>

<body>
<div id="topcontent"><h1><center> Yes, More GNUs </h1></center> </div>
<div id="leftcontent"> Status:<br>
Currently Cloning: $curfight1<br>
Cloned: $numclub1<br>
Adventures: $adventures1<br>
Credits: $credits1<br>
Points: $points1<br>
Strength: $strength1<br><br>
<a href="attackcao.pl">Clone</a><br>
<a href="usecred.pl">Use Credit</a><br>
<a href="randomluck.pl">Random Luck Game</a><br>
<a href="worldstats.pl">World Status</a><br>
 </div>

EOF
#End Magic

$sql = "SELECT adventures,credits FROM users WHERE username='$username'";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

while (@row=$sth->fetchrow_array)   {
	our $adventures = @row[0];
	our $credits = @row[1];
}

if ($credits > 0) {
print "Using a poor innocent credit :-(\n";
	$adventures = $adventures + 50;
	print "You got 50 adventures<br>\n"; 
	$sql2 = "UPDATE users SET adventures = $adventures WHERE username = '$username' ";
	$sth2 = $dbh->prepare($sql2);
	$sth2->execute || die "Horrible Failure on SQL injection :$!";
	$credits--;
	$sql2 = "UPDATE users SET credits = $credits WHERE username = '$username' ";
	$sth2 = $dbh->prepare($sql2);
	$sth2->execute || die "Horrible Failure on SQL injection :$!";
} else {print "Out Of Credits";}

print <<EOF;


</body>

</html>

EOF

$dbh->disconnect;
