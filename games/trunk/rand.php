<?
$username="";
$password="";
$database="";
$host="";

mysql_connect($host,$username,$password);
@mysql_select_db($database) or die( "Unable to select database");

$query="SELECT * FROM attempt ORDER BY id DESC LIMIT 1";
$result=mysql_query($query);
$num=mysql_numrows($result);

$i=0;
while ($i < $num) {
 $hid=mysql_result($result,$i,"id");
 $page=rand(1,$hid);

$i++;
}

mysql_close();

mysql_connect($host,$username,$password);
@mysql_select_db($database) or die( "Unable to select database");
$query="SELECT * FROM attempt WHERE id='$page'" or die ( "Invalid ID");
$result=mysql_query($query);
$num=mysql_numrows($result);

$i=0;
while ($i < $num) {
 $url=mysql_result($result,$i,"id") or die ( "Invalid ID");
 header("Location: go.php?id=$url") or die ( "Invalid ID");

$i++;
}

?>
