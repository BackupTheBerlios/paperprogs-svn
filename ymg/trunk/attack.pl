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
do "pm.pl";
#End Magic

$sql = "SELECT curfight FROM users WHERE username='$username'";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

while (@row=$sth->fetchrow_array)   {
	our $creature = @row[0];
}

$sql = "SELECT numof FROM creatures WHERE creature='$creature'";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

while (@row=$sth->fetchrow_array)   {
	our $orig = @row[0];
}

$sql = "SELECT points FROM users WHERE username='$username'";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

while (@row=$sth->fetchrow_array)   {
	our $points = @row[0];
}



#### Begin UPGRADE CODE
if ($creature ne "GNU") {
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
  "Guinea Pig" => "3000",
  "Squirrel" => "4500",
  "Mole" => "7000",
  "Flamingo" => "9000",
  "Whale" => "11000",
  "Human" => "13000",
  "GNU" => "20000",
);

my $newfight = $whatupgrade{$creature};
my $newpoints = $whenupgrade{$newfight};

if ($points >= $newpoints) {
print "Next turn you'll be fighting $newfight<br>";

$sql = "UPDATE users SET curfight = '$newfight' WHERE username = '$username' ";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

$sql2 = "UPDATE users SET numclub = 0 WHERE username = '$username' ";
$sth2 = $dbh->prepare($sql2);
$sth2->execute || die "Horrible Failure on SQL injection :$!";
}
}
##### END UPGRADE CODE

$sql = "SELECT numclub,adventures,strength FROM users WHERE username='$username'";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

while (@row=$sth->fetchrow_array)   {
	our $numbclub = @row[0];
	our $adventures = @row[1];
	our $strength = @row[2];
}

if ($adventures != 0) {
if (rand(1000) <= 50) {
print "You gain strength<br>"; 
$strength = $strength + 1;
$sql = "UPDATE users SET strength = $strength WHERE username = '$username' ";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";
}
$usedstren = $strength * 100;
my %enemski = (  # a hash to determin upgrades
  "labrats" => "100",
  "Guinea Pig" => "300",
  "Squirrel" => "500",
  "Mole" => "700",
  "Flamingo" => "900",
  "Whale" => "1000",
  "Human" => "1500",
  "GNU" => "2500",
);
my $enemyski = $enemski{$creature};
if ($orig > 0) {
if (rand($enemyski) <= $usedstren) {
$orig++; 
$points = $points + 50;
$numbclub++;
$adventures--;
my %clonimg = (  # a hash to determin upgrades
  "labrats" => "Ratcloned.PNG",
  "Guinea Pig" => "Gpigcloned.PNG",
  "Squirrel" => "Squirrelcloned.PNG",
  "Mole" => "Molecolned.PNG",
  "Flamingo" => "Flamingocloned.PNG",
  "Whale" => "Whalecloned.PNG",
  "Human" => "Humancloned.PNG",
  "GNU" => "GNUcloned.PNG",
);
#$orig--; 
#$adventures--;
print "<center><img src='images/$clonimg{$creature}'></center>"
print "Cloning Successful! That's one more $creature on the planet! You have made $numbclub clones. There are $orig on the planet now!\n";

$sql = "UPDATE creatures SET numof = $orig WHERE creature = '$creature' ";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

$sql = "UPDATE users SET points = $points WHERE username = '$username' ";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

$sql2 = "UPDATE users SET numclub = $numbclub WHERE username = '$username' ";
$sth2 = $dbh->prepare($sql2);
$sth2->execute || die "Horrible Failure on SQL injection :$!";

$sql2 = "UPDATE users SET adventures = $adventures WHERE username = '$username' ";
$sth2 = $dbh->prepare($sql2);
$sth2->execute || die "Horrible Failure on SQL injection :$!";
} else {
my %clonfailimg = (  # a hash to determin upgrades
  "labrats" => "Ratfailed.PNG",
  "Guinea Pig" => "Gpigfailed.PNG",
  "Squirrel" => "Squirrelfailed.PNG",
  "Mole" => "Molefailed.PNG",
  "Flamingo" => "Flamingofailed.PNG",
  "Whale" => "Whalefailed.PNG",
  "Human" => "Humanfailed.PNG",
  "GNU" => "GNUfailed.PNG",
);
$orig--; 
$adventures--;
print "<center><img src='images/$clonfailimg{$creature}'></center>"
print "Your cloning failed, you accidentally killed an innocent $creature\n";
$sql = "UPDATE creatures SET numof = $orig WHERE creature = '$creature' ";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";
$sql2 = "UPDATE users SET adventures = $adventures WHERE username = '$username' ";
$sth2 = $dbh->prepare($sql2);
$sth2->execute || die "Horrible Failure on SQL injection :$!";
}
} else {print $q->h2("They're all dead, you can't do that!");}
} else {print $q->h2("Out of Adventure, you can try to get more with Random Luck, or by using a credit");}

print <<EOF;


</body>

</html>

EOF

$dbh->disconnect;
