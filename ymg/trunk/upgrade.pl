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
if ($testme == 0) { die "Got Login info, but it is incorrect, be nice, don't pwn me :D" }
our $username = $cuser;

my %whatupgrade = (  # a hash to determin upgrades
  "labrats" => "Guinea Pig",
  "Guinea Pig" => "Squirrel",
  "Squirrel" => "Mole",
  "Mole" => "Flamingo",
  "Flamingo" => "Whale",
  "Whale" => "Human",
  "Human" => "GNU",
);

my %whenupgrade = (  # a hash to determin upgrade scores
  "labrats" => "1000",
  "Guinea Pig" => "2000",
  "Squirrel" => "3000",
  "Mole" => "4000",
  "Flamingo" => "5000",
  "Whale" => "6000",
  "Human" => "7000",
  "GNU" => "8000",
);



$sql = "SELECT curfight,points FROM users WHERE username='$username'";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

while (@row=$sth->fetchrow_array)   {
	our $curfight = @row[0];
	our $points = @row[1];
}


my $newfight = $whatupgrade{$curfight};
my $newpoints = $whenupgrade{$newfight};

if ($points >= $newpoints) {
print "Upgraded from $curfight to $newfight";

$sql = "UPDATE users SET curfight = '$newfight' WHERE username = '$username' ";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

$sql2 = "UPDATE users SET numclub = 0 WHERE username = '$username' ";
$sth2 = $dbh->prepare($sql2);
$sth2->execute || die "Horrible Failure on SQL injection :$!";
} else { print "You need more points to upgrade :-("; }
