<html>
<head>
<title>Completed Modification of Game</title>
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
$query="UPDATE attempt SET name='$ud_first', url='$ud_last', fake='$ud_phone' WHERE name='$ud_id'";
@mysql_select_db($database) or die( "Unable to select database");
mysql_query($query);
echo "Record Updated";
mysql_close();
?>
</body>
</html>
