#!/usr/bin/perl

use CGI;
use DBI;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);

do "db.inc.pl";
my $q = new CGI;
print $q->header( "text/xml" );

my $cpass = $q->cookie('taskhash');
my $cuser = $q->cookie('taskname');
if ($q->param(user) ne "") {
$cuser = $q->param(user);
$cpass = $q->param(pass);
}

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

$sql = "select * from tasks WHERE username='$cuser' ORDER BY priority DESC";

$sth = $dbh->prepare($sql);

$sth->execute || die "Horrible Failure on SQL injection :$!";
my $testme = 0;
#output database results

print <<EOF;
<?xml version="1.0" encoding="ISO-8859-1"?>
EOF

while (@row=$sth->fetchrow_array) {
#	print @row;
#	my @res = @row[0];
	print <<EOF;
<task>
	<id>$row[0]</id>
	<name>$row[1]</name>
	<dtad>$row[5]</dtad>
	<description>$row[3]</description>
</task>
EOF
#	print "";
}
