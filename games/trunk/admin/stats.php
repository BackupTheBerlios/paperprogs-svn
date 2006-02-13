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
$username="paperprogs";
$password="smarty11";
$database="paperprogs";
$host="db.berlios.de";

mysql_connect($host,$username,$password);
@mysql_select_db($database) or die( "Unable to select database");
$query="SELECT * FROM attempt WHERE Enabled='True' ORDER BY hits DESC LIMIT 1";
$result=mysql_query($query);
$name=mysql_result($result,$i,"name");
echo "<h1>Statistics</h1><br>";
echo "Most Popular Game: $name<br>";

$query="SELECT * FROM attempt WHERE Enabled='True' ORDER BY totvot DESC LIMIT 1";
$result=mysql_query($query);
$name=mysql_result($result,$i,"name");
echo "Top Rated Game: $name<br>";

$query="SELECT * FROM attempt WHERE Enabled='True' ORDER BY totvot LIMIT 1";
$result=mysql_query($query);
$name=mysql_result($result,$i,"name");
echo "Worst Rated Game: $name<br>";

$query="SELECT * FROM attempt WHERE Enabled='True' ORDER BY hits LIMIT 1";
$result=mysql_query($query);
$name=mysql_result($result,$i,"name");
echo "Least Popular Game: $name<br>";


$query="SELECT * FROM attempt WHERE Enabled='True'";
$result=mysql_query($query);
$num=mysql_numrows($result);
$i=0;
$hips=0;
while ($i < $num) {

$hits=mysql_result($result,$i,"hits");
$hips=$hips + $hits;


$i++;
}

$query="SELECT * FROM attempt ORDER BY id DESC LIMIT 1";
$result=mysql_query($query);
$num=mysql_numrows($result);

$i=0;
while ($i < $num) {
 $hid=mysql_result($result,$i,"id");
 $page=rand(1,$hid);

$i++;
}

echo "Total Hits: $hips<br>";
echo "Average Hits:";
echo $hips / $hid;
echo "<br>";

$query="SELECT * FROM attempt ORDER BY totvot DESC";
$result=mysql_query($query);
$num=mysql_numrows($result);

$i=0;
while ($i < $num) {
 $totvot=mysql_result($result,$i,"totvot");
 $allvot= $allvot + $totvot;
 $numrat=mysql_result($result,$i,"numrat");
 $allrat= $allrat + $numrat;
$i++;
}

echo "Average Rating:";
echo $allvot / $allrat;

mysql_close();
?>
