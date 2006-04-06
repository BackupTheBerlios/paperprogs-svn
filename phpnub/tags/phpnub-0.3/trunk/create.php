<?php
	include 'config.php';
	$realpage=strip_tags($_POST['command']);
	$urltogot=strip_tags($_POST['url']);

	mysql_connect($host,$username,$password);
	@mysql_select_db($database) or die( "Unable to select database");

	$query2="SELECT * FROM phpnub WHERE command='$realpage'";
	$result=mysql_query($query2);
	$num=mysql_numrows($result);
	$i=0;
	$textout = "Creation Successful";
	while ($i < $num) {
	$textout = "Creation Failed";
	$i++;
	}
	$query="INSERT INTO phpnub VALUES ('', '$realpage', '$urltogot', 0)";
	mysql_query($query);
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
					echo $textout;
				?>

			</div>


			<div style="text-align: center;" id="footer">
			<hr style="margin-left: auto; margin-right: auto;" />
			Copyleft Paperprogs &copy; 2004&ndash;06, Template by John
			Zaitseff.<span class="notprinted"></span> <br />

		</div>

	</body>
</html>
