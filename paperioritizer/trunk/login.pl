#!/usr/bin/perl

use CGI;
use DBI;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use Digest::MD5 qw(md5 md5_hex);
$q = new CGI;
#print $q->header( "text/html" );
#print $q->start_html("Login to Yes, More Gnus!");
do "db.inc.pl";

my $user = $q->param(username);
my $pass = $q->param(password);
$pass = md5_hex($pass);
$sql = "select * from users WHERE name='$user' AND passhash='$pass'";

$sth = $dbh->prepare($sql);

$sth->execute || die "Horrible Failure on SQL injection :$!";
my $testme = 0;
#output database results
while (@row=$sth->fetchrow_array) {
	$testme++;
	$usercook = $q->cookie(-name=>'taskname',
				 -value=>@row[1],
				 -expires=>'+4h',
				 -path=>'/');

	$passcook = $q->cookie(-name=>'taskhash',
				 -value=>@row[2],
				 -expires=>'+4h',
				 -path=>'/');
	print $q->header(-cookie=>[$usercook,$passcook]);
	$q->start_html("Logging You In...");
	print "You are now logged in <meta http-equiv=\"refresh\" content=\"1;url=main.pl\">";
}

if ($testme == 0) { print $q->header( "text/html" ); die "Failed To Login :-("; }

print $q->end_html;
