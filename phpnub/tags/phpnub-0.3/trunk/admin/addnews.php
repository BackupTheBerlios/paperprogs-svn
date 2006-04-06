<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<?php
include '../config.php';
include 'lock.php';
include 'includeskin.php';
?>
</head>


	<body>

<!-- For non-visual or non-stylesheet-capable user agents -->
<div id="mainlink"><a href="#main">Skip to
main content.</a></div>

<!-- ======== Header ======== -->
<div id="header">
<div class="left">
<p><a href="../nub.php">PHP<span class="alt">Nub</span></a></p>

</div>

<div class="right"> <span class="hidden">Useful
links:</span>&nbsp; </div>

<div style="text-align: center;" class="subheader">
<span class="hidden">Navigation</span> Version <?php echo "$version";?></div>

</div>

<!-- ======== Left Sidebar ======== -->
<div id="sidebar">
<a href="admin.php">Administration Home</a><br />
<a href="addnews.php">News Administration</a><br />
<a href="cmd.php">Command Administration</a>
<br />			

</div>


<!-- ======== Main Content ======== -->
<div style="text-align: center;" id="main">
<form method="post" action="create.php" name="add"><big><big><big>Edit
News</big></big></big><br />

  <hr style="width: 100%; height: 2px; margin-left: auto; margin-right: auto;" /><textarea cols="50" rows="15" name="content"></textarea><br />

  <br />

  <input type="submit" /> &nbsp;<input type="reset" /></form>

</div>

<div style="text-align: center;"><!-- ======== Footer ======== -->
</div>

<div style="text-align: center;" id="footer">
<hr style="margin-left: auto; margin-right: auto;" />Copyleft
Paperprogs &copy; 2004&ndash;06, Template by John Zaitseff.<span class="notprinted"></span> <br />

</div>

</body>
</html>
