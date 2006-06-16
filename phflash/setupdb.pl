#!/usr/bin/perl
# ipk - demonstrate integer primary keys
use CGI;        
use DBI;
#do "dbconf.pl";
my $dbh = DBI->connect("dbi:SQLite:moo.db", "", "",{RaiseError => 1, AutoCommit => 1});
$cgi = CGI->new;         # ($cgi is now the object)
print $cgi->header;      # function call: $obj->function
eval {
  local $dbh->{PrintError} = 0;
  $dbh->do("DROP TABLE cards");
};
# (re)create it
$dbh->do("CREATE TABLE cards (id INTEGER PRIMARY KEY, quest, ans)");

$dbh->do("INSERT INTO cards VALUES (NULL, 'Hi?', 'Yes')");
