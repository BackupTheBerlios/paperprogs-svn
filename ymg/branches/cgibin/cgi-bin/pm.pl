$sql = "SELECT adventures,credits,curfight,points,numclub,strength,css FROM users WHERE username='$username'";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

while (@row=$sth->fetchrow_array)   {
	our $adventures1 = @row[0];
	our $credits1 = @row[1];
	our $curfight1 = @row[2];
	our $points1 = @row[3];
	our $numclub1 = @row[4];
	our $strength1 = @row[5];
	our $css1 = @row[6];
        our $adventures = @row[0];
        our $creature = @row[2];
        our $points = @row[3];
        our $numbclub = @row[4];
        our $strength = @row[5];
}

print <<EOF;


<html>

<head>
<link rel="stylesheet" type="text/css" href="$css1">
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
