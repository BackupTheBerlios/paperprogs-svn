<?php
include "main.php";
$uname=strip_tags($_COOKIE["vault_uname"]);
$subpass=strip_tags($_COOKIE["vault_pass"]);
mysql_connect($host,$username,$password);
        @mysql_select_db($database) or die( "$die");
        $query2="SELECT * FROM phpnub_users WHERE user='$uname' AND passhash='$subpass'";
        $result=mysql_query($query2);
        $num=mysql_numrows($result);
if (!($num > 0)) { 
echo "$table$nologin<meta http-equiv=\"refresh\" content=\"2;url=$home\">"; exit;}
?>