<?php
include "main.php";
$uname=strip_tags($_COOKIE["vault_uname"]);
$subpass=strip_tags($_COOKIE["vault_pass"]);
mysql_connect($host,$username,$password);
        @mysql_select_db($database) or die( "$die");
        $query2="SELECT * FROM openhack_users WHERE uname='$uname' AND passhash='$subpass'";
        $result=mysql_query($query2);
        $num=mysql_numrows($result);

if (!($num > 0)) { 

echo '<form method="post" action="loggingin.php" name="nub">';
echo "$usertext";
echo '<input size="25" name="username" /><br />';
echo "$passtext";
echo '<input size="25" type="password" name="password" /><br /><input type="submit" /><input type="reset" /></form>';
} else { echo "$loggedin"; }
?>
