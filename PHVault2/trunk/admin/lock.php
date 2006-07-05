<?php
$uname=strip_tags($_COOKIE["uname"]);
#echo $uname . "<br>";
#$cleanpage=mysql_real_escape_string($realpage);
$subpass=strip_tags($_COOKIE["pass"]);
#echo $subpass . "<br>";
#$cleanpage=mysql_real_escape_string($realpage);
mysql_connect($host,$username,$password);
        @mysql_select_db($database) or die( "Unable to select database");

        $query2="SELECT * FROM phpnub_users WHERE user='$uname' AND passhash='$subpass'";
        $result=mysql_query($query2);
        $num=mysql_numrows($result);
#echo $num;
if (!($num > 0)) { echo "incorrent username or password"; exit;}

?>
