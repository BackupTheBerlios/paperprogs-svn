<?
$croyp=strip_tags(addslashes($_GET['id']));

$username="";
$password="";
$database="";
$host="";

mysql_connect($host,$username,$password);
@mysql_select_db($database) or die( "Unable to select database");
$query="SELECT * FROM attempt WHERE id='$croyp'";
$result=mysql_query($query);

$num=mysql_numrows($result);

$i=0;
while ($i < $num) {

$url=mysql_result($result,$i,"url");
$hits=mysql_result($result,$i,"hits");
$hits++;
$look = "hey$croyp";
if (isset($_COOKIE["$look"]))
{
echo "I see you've already been here<br> :D";
} else {
setcookie("hey$croyp", "haha", time()+36000);
echo 'You will be redirected momentarialy. <br>';
$query="UPDATE attempt SET hits='$hits' WHERE id='$croyp'";
mysql_query($query);
}

mysql_close();
echo "You are visitor #";
echo "$hits";
echo "<meta http-equiv=\"refresh\" content=\"0;url=$url\">";

$i++;
}

?>
