<html>
<head>
<title>Search For Games</title>
<style type="text/css">
hr {color: sienna}
p {color: #00FF00; margin-left: 20px}
h2 {color: #00FF00; margin-left: 20px}
h1 {color: #00FF00; margin-left: 20px}
a {color: red;}
body {background-color: black; color: #00FF00; text-align: center; }
</style>
</head>
</body>
<?
$croyp=strip_tags(addslashes($_GET['id']));
$rayte=strip_tags(addslashes($_GET['vote']));
if ($rayte == '') {
die( "Enter something between 1 and 5 you moron!");
}

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

$rates=mysql_result($result,$i,"numrat");
$totvot=mysql_result($result,$i,"totvot");
$newvot = $totvot + $rayte;
$rates++;
if ($rayte > 5) {
die( "Nice try");
}
if ($rayte < 0) {
die( "Nice try");
}
if (isset($_COOKIE["$croyp"]))
{
echo "I see you've already been here<br>";
} else {
setcookie("$croyp", "rated", time()+36000);
echo 'Thanks for voting!. <br>';
$query="UPDATE attempt SET totvot='$newvot', numrat='$rates' WHERE id='$croyp'";
mysql_query($query);
}
echo "Current Rating: ";
echo $newvot / $rates;
echo "<br>$rates ratings";
mysql_close();
$i++;
}

?>
