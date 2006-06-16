#!/usr/bin/perl
use CGI;
use DBI;
#do "dbconf.pl";
my $dbh = DBI->connect("dbi:SQLite:moo.db", "", "", {RaiseError => 1, AutoCommit => 1});
$cgi = CGI->new;         # ($cgi is now the object)
print $cgi->header;      # function call: $obj->function

my $id = $cgi->param('id');

if ($id eq "") { 
print "<form action=\"delete.pl\" method=\"get\">";
print "ID:<input type=\"text\" name=\"id\"><br>";
print "<input type=\"Submit\">";
print "</body>";
print $cgi->end_html;
die "Enter Something";
}

$dbh->do("DELETE FROM cards WHERE id='$id'");
print "Deleted";
