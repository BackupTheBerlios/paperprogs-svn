<?php
include 'main.php';
$uname=strip_tags($_POST['username']);
$subpass=md5(strip_tags($_POST['password']));
mysql_connect($host,$username,$password);
	@mysql_select_db($database) or die( "$die");
        $query2="SELECT * FROM openhack_users WHERE uname='$uname' AND passhash='$subpass'";
	$result=mysql_query($query2);
	$num=mysql_numrows($result);
if ($num > 0) { 
$session=time();
$ip=@$REMOTE_ADDR;
$cookie=md5($uname . $session . $ip);
setcookie("vault_uname", $uname, time()+3600,'/'); 
setcookie("vault_pass", $subpass, time()+3600,'/');
setcookie("vult_session", $cookie, time()+3600,'/');
header('Location: loginform.php');

} else { header('Location: loginform.php'); }
?>
