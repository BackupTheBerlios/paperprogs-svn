<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
   		<?php include 'includeskin.php';?> 
		<?php include 'config.php';?> 

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

<!-- ======== Left Sidebar ======== -->
				<div id="sidebar"><br />

				</div>

<!-- ======== Main Content ======== -->
				<div style="text-align: center;" id="main">
					<form method="post" action="create.php" name="add"><big><big><big>Submit
						a command</big></big></big><br />

  						<small>Use&nbsp;REPLACE
						as the place where the command goes</small><br />

 					 	<small>Example: http://www.google.com/search?q=REPLACE</small><br />

 					 	<hr style="width: 100%; height: 2px; margin-left: auto; margin-right: auto;" /><small><small>URL</small></small><br />

  						<input size="99" name="url" /><br />

  						<small><small>Command</small></small><br />

 						 <input size="99" name="command" /><br />

 						 <br />

  						<input type="submit" /> &nbsp;<input type="reset" /></form>

				</div>

				<div style="text-align: center;"><!-- ======== Footer ======== -->
				</div>

				<div style="text-align: center;" id="footer">
					<hr style="margin-left: auto; margin-right: auto;" />Copyleft
					Paperprogs &copy; 2004&ndash;06, Template by John
					Zaitseff.<span class="notprinted"></span> <br />

				</div>

		</body>
</html>
