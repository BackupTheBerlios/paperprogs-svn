<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
    <title>Game Links</title>
<style type="text/css">
hr {color: sienna}
p {color: #00FF00; text-align: center;}
h2 {color: #00FF00; text-align: center;}
h1 {color: #00FF00; text-align: center;}
a {color: red;}
body {background-color: black; color: #00FF00; text-align: center; }
</style>
  </head>
<body>
<center><h2><b>Game Links</b></h2></center><br />
<hr>
<a href='rand.php'><b>Random Game</b></a><br><i> Takes you to a random game... Anywhere!</i>
<br />
<br />
<a href='search.html'><b>Search</b></a><br><i> Trying to remember that perfect game?</i>
<br />
<br />
<hr>

<script src='prototype.js' type='text/javascript'> </script>
<script src="scriptaculous.js" type="text/javascript"> </script>
<script src='Tooltip.js' type='text/javascript'> </script>

<?
$username="";
$password="";
$database="";
$host="";

mysql_connect($host,$username,$password);
@mysql_select_db($database) or die( "Unable to select database");
$query="SELECT * FROM attempt WHERE Enabled='True' ORDER BY totvot DESC, hits DESC, id DESC";
$result=mysql_query($query);

$num=mysql_numrows($result);

mysql_close();
?>
<?
$i=0;
while ($i < $num) {

$url=mysql_result($result,$i,"id");
$name=mysql_result($result,$i,"name");
$desc=mysql_result($result,$i,"fake");
$hits=mysql_result($result,$i,"hits");
$totvot=mysql_result($result,$i,"totvot");
$numrat=mysql_result($result,$i,"numrat");
echo "<a href=\"go.php?id=$url\"><b>$name</b></a>";
echo "<p>Click for more</p>";
echo "<div class='tooltip'>";

if ($hits == 1)
echo "<i>$desc  </i><br /><b>$hits hit	</b><br />\n";
else
echo "<i>$desc  </i><br /><b>$hits hits	</b><br />";

echo "Rating:";
if ($totvot == 0)
{
echo "Not Rated";
}
else {
echo $totvot / $numrat;
}


echo "<form action=\"rate.php\" method=\"get\">";
echo "<input type=\"hidden\" name=\"id\" value=\"$url\">";
echo "Rate it (1-5): <input type=\"text\" name=\"vote\" size='2'>";
echo "<input type=\"Submit\" value=\"Rate\"></form><br /><br />";
echo "</div>";
$i++;
}

?>
  <p>
    <a href="http://validator.w3.org/check?uri=referer"><img
        src="http://www.w3.org/Icons/valid-html401"
        alt="Valid HTML 4.01 Transitional" height="31" width="88"></a>
  </p>
</body></html>
