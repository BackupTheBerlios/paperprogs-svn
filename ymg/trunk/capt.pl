#!/usr/bin/perl

use CGI;
use DBI;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use Digest::MD5 qw(md5 md5_hex);
$q = new CGI;
print $q->header( "text/html" );
print $q->start_html("Login to Yes, More Gnus!");
$dbh = DBI->connect('dbi:mysql:ymg','ultramancool','some_pass');


if ($q->param(capt) == 0) {
my $randid = int(rand(300));
print "<img src='/captcha/$randid.jpg'>\n <form action=\"capt.pl\" method=\"post\">\n <input name=\"capt\" type=\"text\"><br>";
$sql = "UPDATE users SET captcha=$randid WHERE username='ultramancool'";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";
} else {

$sql = "SELECT captcha FROM users WHERE username='ultramancool'";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

while (@row=$sth->fetchrow_array)   {
	our $randidy = @row[0];
}


$sql = "SELECT captcha FROM captcha WHERE id='$randidy'";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";

while (@row=$sth->fetchrow_array)   {
	our $captrea = @row[0];
}
my $mycap = $q->param(capt);
$sql = "UPDATE users SET captcha=0 WHERE username='ultramancool'";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";
print "$captrea and $mycap\n<br>";
if ($q->param(capt) != $captrea) { print "Incorrect Captcha :-("; exit; }

}
