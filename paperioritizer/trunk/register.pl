#!/usr/bin/perl

use CGI;
use DBI;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use Digest::MD5 qw(md5 md5_hex);
$q = new CGI;
print $q->header( "text/html" );
print $q->start_html("Login to Yes, More Gnus!");
do "db.inc.pl";

my $user = $q->param(username);
my $pass = $q->param(password);
if ($user eq "") { die "Enter A Username!" }
if ($pass eq "") { die "Enter A Password!" }
$pass = md5_hex($pass);

$sql = "INSERT INTO users VALUES('', '$user', '$pass')";
$sth = $dbh->prepare($sql);

$sth->execute || die "Horrible Failure on SQL injection :$!";
print "Registered, proceeding to login <meta http-equiv=\"refresh\" content=\"1;url=index.html\">";
print $q->end_html;
