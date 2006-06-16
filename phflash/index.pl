#!/usr/bin/perl
# ipk - demonstrate integer primary keys
use CGI;
use DBI;
#do "dbconf.pl";
my $dbh = DBI->connect("dbi:SQLite:moo.db", "", "", {RaiseError => 1, AutoCommit => 1});
$cgi = CGI->new;         # ($cgi is now the object)
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
</style>

</head>
<script src='prototype.js' type='text/javascript'> </script>
<script src="scriptaculous.js" type="text/javascript"> </script>
<script src='Tooltip.js' type='text/javascript'> </script>
<body>
<p>test?</p>
<div class='tooltip'>
    <h1>Header</h1>
    <p>Contents</p>
</div>
EndOfHTML
my $id = 1;
my $id = $cgi->param('id');
if ($id eq "") { $id = 1; }

my $all = $dbh->selectall_arrayref("SELECT id,quest,ans FROM cards WHERE id='$id'");
foreach my $row (@$all) {
  my ($id, $quest, $ans) = @$row;
  print "$quest\n <br>";
  print "<p>Click this to show the answer</p>";
  print "<div class='tooltip'>";
  print "<p>$ans</p>";
  print "</div>";
}
$id++;
print "<form action=\"index.pl\" method=\"get\">";
print "Name: <input type=\"hidden\" name=\"id\" value=\"$id\"><br>";
print "<input type=\"Submit\">";
print "</body>";
print $cgi->end_html;
