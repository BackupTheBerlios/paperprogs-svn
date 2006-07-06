<?php
include 'main.php';
$uname=strip_tags($_POST['username']);
$subpass=md5(strip_tags($_POST['password']));
mysql_connect($host,$username,$password);
	@mysql_select_db($database) or die( "$die");
        $query2="SELECT * FROM '$table' WHERE user='$uname' AND passhash='$subpass'";
	$result=mysql_query($query2);
	$num=mysql_numrows($result);
if ($num > 0) { 
$session=time();
$cookie=md5("$uname;$session");
$ip=@$REMOTE_ADDR;
setcookie("vault_uname", $uname, time()+3600,'/'); 
setcookie("vault_pass", $subpass, time()+3600,'/');
setcookie("vult_session", $cookie, time()+3600,'/');
header('Location: loginform.php');

} else { header('Location: loginform.php'); }
?>
