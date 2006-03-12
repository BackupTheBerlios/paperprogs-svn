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
        

do "pm.pl";
my $css = $q->param(csssheet);
if ($css eq "") { 
$sql = "select css from users WHERE username='$username'";
$sth = $dbh->prepare($sql);
$sth->execute || die "Horrible Failure on SQL injection :$!";
#output database results
while (@row=$sth->fetchrow_array) {
	our $oldcss = @row[0]
}
print "<form name=\"the_form\" action=\"csssheet.pl\" value=\"$oldcss\" method=\"post\" >\n";
print "<input name=\"csssheet\" type=\"text\">";
print "</form></div></body>";
exit;
}

$sql = "UPDATE users SET css='$css' WHERE username='$username'";
$sth = $dbh->prepare($sql);

$sth->execute || die "Horrible Failure on SQL injection :$!";
print "Done <meta http-equiv=\"refresh\" content=\"1;url=login2.pl\">";
print $q->end_html;
