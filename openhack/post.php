<?php

	include 'config.php';

	$realpage=strip_tags($_POST['command']);
	list($one, $two) = split($sep, $realpage);
	$regexen = '/($one)/i';
	$otherone = "$one ";
	$two = ereg_replace ($otherone, '', $command);
	mysql_connect($host,$username,$password);
	@mysql_select_db($database) or die( "Unable to select database");
	$query="SELECT * FROM phpnub WHERE command='$one'";
	$result=mysql_query($query);
	$run=mysql_result($result,$i,"exec");
	$num=mysql_numrows($result);
	$i=0;
	while ($i < $num) {
	$url=mysql_result($result,$i,"url");
	$i++;
	}
	if ($run=='') {$run="0";}
	
	if ($run == '0') {$url2 = ereg_replace ('REPLACE', $two, $url);}

	header("Location: $url2");
?>