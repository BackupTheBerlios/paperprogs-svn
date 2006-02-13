<html>
<head>
<title>Modify Game</title>
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
<?
$username="paperprogs";
$password="smarty11";
$database="paperprogs";
$host="db.berlios.de";

mysql_connect($host,$username,$password);
@mysql_select_db($database) or die( "Unable to select database");
$query="SELECT * FROM attempt WHERE name='$id'";
$result=mysql_query($query);
$num=mysql_numrows($result); 
mysql_close();

$i=0;
while ($i < $num) {
$first=mysql_result($result,$i,"name");
$last=mysql_result($result,$i,"url");
$phone=mysql_result($result,$i,"fake");

?>

<form action="updated.php">
<input type="hidden" name="ud_id" value="<? echo "$id"; ?>">
Name: <input type="text" name="ud_first" value="<? echo "$first"?>"><br>
URL: <input type="text" name="ud_last" value="<? echo "$last"?>"><br>
Description(255 Chars Max): <input type="text" name="ud_phone" value="<? echo "$phone"?>"><br>
<input type="Submit" value="Update">
</form>

<?
++$i;
} 
?>
</body>
</html>
