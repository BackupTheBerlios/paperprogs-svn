<?php

include 'config.php';
include 'lock.php';

$file = "news";
$fp = fopen ("$file", "wb");

$content = $_POST['content'];
fwrite($fp, $content);
fclose($fp);

header("Location: /nub/admin/admin.php");

?> 
