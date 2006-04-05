<?php
include 'config.php';
$uname=strip_tags($_GET['username']);
#$cleanpage=mysql_real_escape_string($realpage);
#echo $cleanpage;
$subpass=md5(strip_tags($_GET['password']));
#$cleanpage=mysql_real_escape_string($realpage);
#echo $cleanpage;
mysql_connect($host,$username,$password);
	@mysql_select_db($database) or die( "Unable to select database");

	$query2="SELECT * FROM phpnub_users WHERE user='$uname' AND passhash='$subpass'";
	$result=mysql_query($query2);
	$num=mysql_numrows($result);
if ($num > 0) { 
setcookie("uname", $uname, time()+36000); 
setcookie("pass", $subpass, time()+36000);
echo "you are now logged it";
} else { echo "incorrent username or password or SQL fucked up on me"; }
?>
