#!/usr/bin/perl -w
# ipk - demonstrate integer primary keys
#use DBI;
our $dbh = DBI->connect("dbi:SQLite:main.db", "", "",
{RaiseError => 1, AutoCommit => 1});
