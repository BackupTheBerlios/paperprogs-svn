#!/usr/bin/perl -w
use DBI;
use strict;
my $dbh = DBI->connect("dbi:SQLite:rooms.db", "", "",
{RaiseError => 1, AutoCommit => 1});
#$dbh->do("CREATE TABLE rooms (id INTEGER PRIMARY KEY, name, look)");
#$dbh->do("INSERT INTO rooms VALUES (NULL, 'Hell', 'You are standing in a firey pit of hell, there is a small boy named Bill.')");
#$dbh->do("INSERT INTO rooms VALUES (NULL, 'Heaven', 'You are standing in heaven, Tux is here catching butterflys.')");
#my $all = $dbh->selectall_arrayref("SELECT * FROM rooms");
#foreach my $row (@$all) {
#  my ($id, $word, $look) = @$row;
#  print "$word : $look\n";
#}


