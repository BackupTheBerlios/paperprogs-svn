#!/usr/bin/perl

use CGI;
use DBI;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);

do "db.inc.pl";
my $q = new CGI;
print $q->header( "text/html" );

my $cpass = $q->cookie('taskhash');
my $cuser = $q->cookie('taskname');

if ($cuser eq "") { die "Login First!" }
if ($cpass eq "") { die "Login First!" }


$sql = "select * from users WHERE name='$cuser' AND passhash='$cpass'";

$sth = $dbh->prepare($sql);

$sth->execute || die "Horrible Failure on SQL injection :$!";
my $testme = 0;
#output database results
while (@row=$sth->fetchrow_array) {
	$testme++;
}

if ($testme == 0) {die "Not Logged In";}


$cid = $q->param(id);
$sql = "SELECT * from tasks WHERE username='$cuser' AND id='$cid'";

$sth = $dbh->prepare($sql);

$sth->execute || die "Horrible Failure on SQL injection :$!";
my $testme = 0;
#output database results

print <<EOF;

<body>

EOF

while (@row=$sth->fetchrow_array) {
#	print @row;
#	my @res = @row[0];
#	print "<h2>$row[1]</h2><br>Date/Time:$row[5]<br>Priority: $row[3]</br>Description: $row[2] <br> <a href='delete.pl?id=$row[0]'>Delete?</a> <a href='delete.pl?id=$row[0]'>Edit?</a>";
	print <<EOF;
<form action="javascript:get(document.getElementById('myform'));" name="myform" id="myform">
<input name="id" type="hidden" value="$row[0]">
Name: <input name="nameo" type="text" value="$row[1]"><br>

Time/Date:<input name="timed" type="text" value="$row[5]"><br>

Priority:<input name="prio" type="text" value="$row[3]"><br>
Description:<input name="pdesc" type="text" value="$row[2]"><br>
Tags:<input name="tags" type="text" value="$row[6]"><br>

<input type="button" name="button" value="Submit" 
   onclick="javascript:get(this.parentNode);">
</form>

<span name="myspan" id="myspan">Enter something and click Submit</span>
EOF
#	print "";
}

print <<EOF;

</body>
</html>
EOF
