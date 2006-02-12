#!/usr/bin/perl

use CGI;
use DBI;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
$q = new CGI;
print $q->header( "text/html" );

$dbh = DBI->connect('dbi:mysql:mydb','myuserid','mypassword');

my $user = $q->param(user)
my $pass = $q->param(pass)
$sql = "select * from users WHERE username='$user' AND passhash='$pass'";

$sth = $dbh->prepare($sql);

$sth->execute || die "Horrible Failure on SQL injection :$!";

#output database results
while (@row=$sth->fetchrow_array)
   { print "@row\n" }
