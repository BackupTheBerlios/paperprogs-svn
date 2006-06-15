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
<?xml version="1.0"?>
<rss version="2.0">
  <channel>
    <title>Paperioritizer Tasks in RSS</title>
    <link>http://paperprogs.berlios.de/paperioritizer</link>
    <description>Your RSS</description>
    <language>en-us</language>
EOF

while (@row=$sth->fetchrow_array) {
#	print @row;
#	my @res = @row[0];
print <<EOF;

    <item>
      <title>$row[1]</title>
      <link>http://localhost/paperioritizer/view.pl?id=$row[0]</link>
      <description> $row[3] 
Date/Time: $row[5] </description>
      <guid>http://localhost/paperioritizer/view.pl?id=$row[0]</guid>
    </item>

EOF
}

print <<EOF;
  </channel>
</rss>
EOF
