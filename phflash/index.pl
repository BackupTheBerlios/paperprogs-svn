#!/usr/bin/perl
# ipk - demonstrate integer primary keys
use CGI;
use DBI;
#do "dbconf.pl";
my $dbh = DBI->connect("dbi:SQLite:moo.db", "", "", {RaiseError => 1, AutoCommit => 1});
$cgi = CGI->new;         # ($cgi is now the object)
my $cor = $cgi->param('cor');
my $score = $cgi->param('score');
$score2 = $cor + $score;
print $cgi->header;      # function call: $obj->function
print "<head>";
print <<EndOfHTML;
<style type="text/css">
hr {color: sienna}
p {color: #00FF00; text-align: center;}
h2 {color: #00FF00; text-align: center;}
h1 {color: #00FF00; text-align: center;}
a {color: red;}
body {background-color: black; color: #00FF00; text-align: center; }
#card {background-color: #fff6d1; color: #808080; text-align: center; background-position: center; position: relative; width: 300px; margin: 0 auto;}
#card p{color: #808080; text-align: center;}

</style>

</head>
<script src='prototype.js' type='text/javascript'> </script>
<script src="scriptaculous.js" type="text/javascript"> </script>
<script src='Tooltip.js' type='text/javascript'> </script>
<body>
<h2>Quiz</h2>
EndOfHTML
my $id = 1;
my $id = $cgi->param('id');
if ($id eq "") { $id = 1; }

my $all = $dbh->selectall_arrayref("SELECT id,quest,ans FROM cards WHERE id='$id'");
foreach my $row (@$all) {
  my ($id, $quest, $ans) = @$row;
  print "<div id='card'>";
  print "$quest\n <br>";
  print "<p>Click this to show the answer</p>";
  print "<div class='tooltip'>";
  print "<hr>";
#  sleep 1;
  print "<p>$ans</p>";
  print "</div>";
  print "</div>";
}
my $crap = @$all[0];
my $numbert = @$crap[0];

if ($numbert == 0) {print "End of Quiz :-) <br> Your score is $score2";
my $all = $dbh->selectall_arrayref("SELECT id FROM cards ORDER BY id DESC LIMIT 1");
foreach my $row (@$all) {
  our ($sid) = @$row;
}
print "/ $sid <br> Your percentage is ";
print $score2 / $sid * 100;
print "%";
} else {
$id++;
print "<form action=\"index.pl\" method=\"get\">";
print "<input type=\"hidden\" name=\"id\" value=\"$id\">";
print "<input type=\"hidden\" name=\"cor\" value=\"0\">";
print "<input type=\"hidden\" name=\"score\" value=\"$score2\">";
print "<input type=\"Submit\" value=\"Incorrect\">";
print "</form>";

print "<form action=\"index.pl\" method=\"get\">";
print "<input type=\"hidden\" name=\"id\" value=\"$id\">";
print "<input type=\"hidden\" name=\"cor\" value=\"1\">";
print "<input type=\"hidden\" name=\"score\" value=\"$score2\">";
print "<input type=\"Submit\" value=\"Correct\">";
print "</form>";
#print "</body>";

}
print $cgi->end_html;
