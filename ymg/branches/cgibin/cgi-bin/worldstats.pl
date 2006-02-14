#!/usr/bin/perl

use CGI;
use DBI;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);

do "db.inc.pl";
my $q = new CGI;
print $q->header( "text/html" );

my $cpass = $q->cookie('passhash');
my $cuser = $q->cookie('username');
if ($q->param(user) ne "") {
$cuser = $q->param(user);
$cpass = $q->param(pass);
}

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
if ($testme == 0) { die "Got Login info, but it is incorrect" }
our $username = $cuser;

#Logged in

#Print Magic
$sql = "SELECT adventures,credits,curfight,points,numclub,strength FROM users WHERE username='$username'";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

while (@row=$sth->fetchrow_array)   {
	our $adventures = @row[0];
	our $credits1 = @row[1];
	our $creature = @row[2];
	our $points = @row[3];
	our $numbclub = @row[4];
	our $strength = @row[5];
}

print <<EOF;


<html>

<head>
<link rel="stylesheet" type="text/css" href="main.css">
</head>

<body>
<div id="topcontent"><h1><center> Yes, More GNUs </h1></center> </div>
<div id="leftcontent"> Status:<br>
Currently Cloning: $creature<br>
Cloned: $numbclub<br>
Adventures: $adventures<br>
Credits: $credits1<br>
Points: $points<br>
Strength: $strength<br><br>
<a href="attackcao.pl">Clone</a><br>
<a href="usecred.pl">Use Credit</a><br>
<a href="randomluck.pl">Random Luck Game</a><br>
<a href="worldstats.pl">World Status</a><br>
 </div>

EOF
#End Magic

$sql = "SELECT * FROM creatures ORDER BY id";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

while (@row=$sth->fetchrow_array)   {
	print "@row[1]";
	print "\n<br>";
}
print "</div><div id=\"rightcontent\">";

$sql = "SELECT * FROM creatures ORDER BY id";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

while (@row=$sth->fetchrow_array)   {
	print "@row[2]";
	print "\n<br>";
}
print "</div>";
