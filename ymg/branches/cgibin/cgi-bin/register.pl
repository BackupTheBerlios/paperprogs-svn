#!/usr/bin/perl

use CGI;
use DBI;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use Digest::MD5 qw(md5 md5_hex);
$q = new CGI;
print $q->header( "text/html" );
print $q->start_html("Login to Yes, More Gnus!");
do "db.inc.pl";

my $user = $q->param(user);
my $pass = $q->param(pass);
if ($user eq "") { die "Enter A Username!" }
if ($pass eq "") { die "Enter A Password!" }
$pass = md5_hex($pass);

$sql = "INSERT INTO users VALUES('', '$user', '$pass', 0, 'labrats', 0, 100, 2, 1, 0, 'main.css')";
$sth = $dbh->prepare($sql);

$sth->execute || die "Horrible Failure on SQL injection :$!";
print "Registered, proceeding to login <meta http-equiv=\"refresh\" content=\"1;url=login.htm\">";
print $q->end_html;
