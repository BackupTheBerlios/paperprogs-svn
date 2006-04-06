
<?php
include '../config.php';
include 'lock.php';
$command=strip_tags($_GET['command']);
#$cleanpage=mysql_real_escape_string($realpage);
#echo $cleanpage;

mysql_connect($host,$username,$password);
@mysql_select_db($database) or die( "Unable to select database");
$query="DELETE FROM phpnub WHERE command = '$command'";
mysql_query($query);
header("Location: admin.php");
?>
