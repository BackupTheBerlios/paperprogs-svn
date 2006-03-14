<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
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
<center><h2><b>Game Links</b></h2></center><br />
<?
$username="paperprogs";
$password="smarty11";
$database="paperprogs";
$host="db.berlios.de";

mysql_connect($host,$username,$password);
@mysql_select_db($database) or die( "Unable to select database");
$query="SELECT * FROM attempt WHERE Enabled='True' ORDER BY hits DESC, id DESC";
$result=mysql_query($query);

$num=mysql_numrows($result);

mysql_close();
?>
<?
$i=0;
while ($i < $num) {

$url=mysql_result($result,$i,"id");
$name=mysql_result($result,$i,"name");
$desc=mysql_result($result,$i,"hits");

echo "<a href=\"../go.php?id=$url\"><b>$name</b></a><br><i>$desc hits</i><br />\n<br />\n";

$i++;
}

?>
</body></html>
