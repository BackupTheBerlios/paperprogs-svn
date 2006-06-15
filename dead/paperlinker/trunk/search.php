<html>
  <head>
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
    <title>Game Links</title>
<style type="text/css">
hr {color: sienna}
p {color: #00FF00; margin-left: 20px}
h2 {color: #00FF00; margin-left: 20px}
h1 {color: #00FF00; margin-left: 20px}
a {color: red;}
body {background-color: black; color: #00FF00; text-align: center; }
</style>
  </head>
<body>
<?
$username="";
$password="";
$database="";
$host="";

mysql_connect($host,$username,$password);
@mysql_select_db($database) or die( "Unable to select database");
$realsearch=strip_tags($_GET['q']);
$cleansearch=mysql_real_escape_string($realsearch);
$query="SELECT * FROM attempt WHERE name RLIKE '$cleansearch' ORDER BY hits DESC";
$result=mysql_query($query);

$num=mysql_numrows($result);

echo "<h2><b><center>Game Links</center></b></h2>";
echo "Search results for $cleansearch";
echo "<h3>Name Matches</h3><br>";
$i=0;
while ($i < $num) {

$url=mysql_result($result,$i,"id");
$name=mysql_result($result,$i,"name");
$desc=mysql_result($result,$i,"fake");
$hits=mysql_result($result,$i,"hits");
if ($hits == 1)
echo "<a href=\"go.php?id=$url\"><b>$name</b></a><br><i>$desc  </i><br /><b>$hits hit</b><br />\n<br />\n";
else
echo "<a href=\"go.php?id=$url\"><b>$name</b></a><br><i>$desc  </i><br /><b>$hits hits</b><br />\n<br />\n";


$i++;
}

echo "<h3>Description Matches</h3><br><br>";
$query="SELECT * FROM attempt WHERE fake RLIKE '$cleansearch' ORDER BY hits DESC";
$result=mysql_query($query);

$num=mysql_numrows($result);

$i=0;
while ($i < $num) {

$url=mysql_result($result,$i,"id");
$name=mysql_result($result,$i,"name");
$desc=mysql_result($result,$i,"fake");
$hits=mysql_result($result,$i,"hits");
if ($hits == 1)
echo "<a href=\"go.php?id=$url\"><b>$name</b></a><br><i>$desc  </i><br /><b>$hits hit</b><br />\n<br />\n";
else
echo "<a href=\"go.php?id=$url\"><b>$name</b></a><br><i>$desc  </i><br /><b>$hits hits</b><br />\n<br />\n";


$i++;
}

echo "<h3>URL Matches</h3><br><br>";
$query="SELECT * FROM attempt WHERE url RLIKE '$cleansearch' ORDER BY hits DESC";
$result=mysql_query($query);

$num=mysql_numrows($result);

$i=0;
while ($i < $num) {

$url=mysql_result($result,$i,"id");
$name=mysql_result($result,$i,"name");
$desc=mysql_result($result,$i,"fake");
$hits=mysql_result($result,$i,"hits");
if ($hits == 1)
echo "<a href=\"go.php?id=$url\"><b>$name</b></a><br><i>$desc  </i><br /><b>$hits hit</b><br />\n<br />\n";
else
echo "<a href=\"go.php?id=$url\"><b>$name</b></a><br><i>$desc  </i><br /><b>$hits hits</b><br />\n<br />\n";


$i++;
}

mysql_close();

?>
</body>
</html>
