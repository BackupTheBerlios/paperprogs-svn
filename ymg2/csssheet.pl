#!/usr/bin/perl

use CGI;
use DBI;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use Digest::MD5 qw(md5 md5_hex);
$q = new CGI;
print $q->header( "text/html" );
print $q->start_html("Login to Yes, More Gnus!");
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

my $css = $q->param(csssheet);
if ($user eq "") { 
do "pm.pl";  
print "<form name=\"the_form\" action=\"csssheet.pl.pl\" method=\"post\">\n";
print "<input name=\"csssheet\" type=\"text\">";
}
$pass = md5_hex($pass);

$sql = "INSERT INTO users VALUES('', '$user', '$pass', 0, 'labrats', 0, 100, 2, 1, 0, 'main.css')";
$sth = $dbh->prepare($sql);

$sth->execute || die "Horrible Failure on SQL injection :$!";
print "Registered, proceeding to login <meta http-equiv=\"refresh\" content=\"1;url=login.htm\">";
print $q->end_html;
