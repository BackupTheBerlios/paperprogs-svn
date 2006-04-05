<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>

<?php include 'config.php';?><?php include 'includeskin.php';?>
</head>



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
Version <?php echo $version;?></div>

</div>

<!-- ======== Main Content ======== -->
<div id="main">
<div id="navhead">
<hr /> <span class="hidden">Path to this page:</span>
PHVault version .1<br>
<form method="post" action="loggingin.php" name="Nub">
Username: <input size="25" name="username" /><br />

Password: <input size="25" name="password" /><br />

  <input type="submit" /><input type="reset" /></form>

</div>

</div>

<div style="text-align: center;" id="footer">
<hr style="margin-left: auto; margin-right: auto;" />
Copyleft Paperprogs &copy; 2004&ndash;06, Template by John
Zaitseff.<span class="notprinted"></span> <br />

</div>

</body>
</html>
