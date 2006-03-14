<html>
<head>
<title>Add Game</title>
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

$url=$_POST['url'];
$name=$_POST['name'];
$descry=$_POST['descry'];

mysql_connect($host,$username,$password);
@mysql_select_db($database) or die( "Unable to select database");

$query = "INSERT INTO attempt VALUES ('','$name','$url','$descry','True','0','0','0')";
mysql_query($query);

mysql_close();
?>
Complete! Check out the <a href="../index.php">homepage</a>.
<form action="add.php" method="post">
Name: <input type="text" name="name"><br>
URL: <input type="text" name="url"><br>
Description: <input type="text" name="descry"><br>
<input type="Submit">
</body>
</html>
