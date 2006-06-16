#!/usr/bin/perl
use CGI;
use DBI;
#do "dbconf.pl";
my $dbh = DBI->connect("dbi:SQLite:moo.db", "", "", {RaiseError => 1, AutoCommit => 1});
$cgi = CGI->new;         # ($cgi is now the object)
print $cgi->header;      # function call: $obj->function

my $answ = $cgi->param('answer');
my $questi = $cgi->param('question');

if ($answ eq "") { 
print "<form action=\"add.pl\" method=\"get\">";
print "Question:<input type=\"text\" name=\"question\"><br>";
print "Answer:<input type=\"text\" name=\"answer\"><br>";
print "<input type=\"Submit\">";
print "</body>";
print $cgi->end_html;
die "Enter Something";
}

if ($questi eq "") { 
print "<form action=\"add.pl\" method=\"get\">";
print "Question:<input type=\"text\" name=\"question\"><br>";
print "Answer:<input type=\"text\" name=\"answer\"><br>";
print "<input type=\"Submit\">";
print "</body>";
print $cgi->end_html;
die "Enter Something";
}
$questi = $dbh->quote($questi);
$answ = $dbh->quote($answ);
$dbh->do("INSERT INTO cards VALUES (NULL, $questi, $answ, '0')");
print "Added";
print "<form action=\"add.pl\" method=\"get\">";
print "Question:<input type=\"text\" name=\"question\"><br>";
print "Answer:<input type=\"text\" name=\"answer\"><br>";
print "<input type=\"Submit\">";
print "</body>";
print $cgi->end_html;

