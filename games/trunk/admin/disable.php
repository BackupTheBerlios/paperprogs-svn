<<html>
<head>
<title>Delete Game</title>
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

$name=$_POST['id'];
$query="UPDATE attempt SET Enabled='False', url='rand.php' WHERE name='$name'";
mysql_query($query);
echo "Disabled $name";
mysql_close();
?>
</body>
</html>
