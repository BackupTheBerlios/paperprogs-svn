<?php
	include 'login/lock.php';
	$oldmsg = $_POST['output'];
	include 'config.php';

	$realpage=strip_tags($_POST['cmd']);
	list($one, $two) = split($sep, $realpage);
	$regexen = '/($one)/i';
	$otherone = "$one ";
	mysql_connect($host,$username,$password);
	@mysql_select_db($database) or die( "Unable to select database");
if ($one == '') { $thingy = "\n"; include 'index.php'; exit; }
$query="SELECT soft FROM openhack_users WHERE uname='$uname' AND soft rlike ' $one '";
$result=mysql_query($query);

$num=mysql_numrows($result);

$i=0;

if ($num == 0) { $thingy = "$one: command not found\n"; include 'index.php'; exit; }

	$query="SELECT * FROM openhack_commands WHERE command='$one'";
	$result=mysql_query($query);
	$run=mysql_result($result,$i,"exec");
	$num=mysql_numrows($result);
	$i=0;
	while ($i < $num) {
	$exec=mysql_result($result,$i,"exec");
	eval ($exec);
	$i++;
	}
include 'index.php';
?>
