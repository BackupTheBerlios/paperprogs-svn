<?php

	include 'config.php';

	$realpage=strip_tags($_POST['command']);
	#$cleanpage=mysql_real_escape_string($realpage);
	#echo $cleanpage;
	list($one, $two) = split($sep, $realpage);

	$two = ereg_replace ($one, '', $command);
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
  		<?php include 'includeskin.php';?> 

		<body>

<!-- For non-visual or non-stylesheet-capable user agents -->
<div id="mainlink"><a href="#main">Skip to
		main content.</a></div>

<!-- ======== Header ======== -->
		<div id="header">
		<div class="left">
			<p><a href="nub.php">PHP<span class="alt">Nub</span></a></p>

		</div>

		<div class="right"> <span class="hidden">Useful
			links:</span>&nbsp;
		</div>

		<div style="text-align: center;" class="subheader">
			<span class="hidden">Navigation</span>
			Version <? echo $version ?></div>

		</div>


<!-- ======== Main Content ======== -->
		<div id="main">
<?php
if ($one=='ls') {$run="1";
mysql_connect($host,$username,$password);
	@mysql_select_db($database) or die( "Unable to select database");

	$query2="SELECT * FROM phpnub";
	$result=mysql_query($query2);
	$num=mysql_numrows($result);
$i=0;
echo "<table border=1>";
echo "<tr><td>URL</td><td>Command</td></tr>";
while ($i < $num) {
echo "<tr><td>";
$url=mysql_result($result,$i,"url");
echo $url;
echo "</td><td>";
$command=mysql_result($result,$i,"command");
echo $command;
echo "</td>";

$i++;

}
echo "</table>";

}
?>
			<?php
				if ($run == '0') {echo "Command not found..";}
			?>


		</div>


		<div style="text-align: center;" id="footer">
			<hr style="margin-left: auto; margin-right: auto;" />
			Copyleft Paperprogs &copy; 2004&ndash;06, Template by John
			Zaitseff.<span class="notprinted"></span> <br />

		</div>

	</body>
</html>
