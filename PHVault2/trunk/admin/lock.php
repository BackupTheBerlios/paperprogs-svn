<?php
$uname=strip_tags($_COOKIE["uname"]);
$subpass=strip_tags($_COOKIE["pass"]);
mysql_connect($host,$username,$password);
        @mysql_select_db($database) or die( "Unable to select database");

        $query2="SELECT * FROM phpnub_users WHERE user='$uname' AND passhash='$subpass'";
        $result=mysql_query($query2);
        $num=mysql_numrows($result);
if (!($num > 0)) { echo "incorrent username or password"; exit;}

?>
