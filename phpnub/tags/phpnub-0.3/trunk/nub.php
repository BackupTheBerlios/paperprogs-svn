<?php include 'config.php';?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<?php include 'includeskin.php';?>  
	<body>


<!-- For non-visual or non-stylesheet-capable user agents -->
		<div id="mainlink"><a href="#main">Skip to main content.</a></div>



<!-- ======== Header ======== -->

		<div id="header">
  
		<div class="left">

    
			<p><a href="nub.php">PHP<span class="alt">Nub</span></a></p>

  		</div>


  
		<div class="right">
    			<span class="hidden">Useful links:</span>&nbsp;<a href="index.html"></a>

 		 </div>


  
		<div style="text-align: center;" class="subheader">
    			<span class="hidden">Navigation</span><a class="highlight" href="index.html"></a> Version <? echo $version ?></div>

		</div>


<div id="sidebar">
<a href="add.php">Add a Command</a>
<br />
<a href="login.php">Admin</a>
<br />			

</div>

<!-- ======== Main Content ======== -->

		<div id="main">

			<div id="navhead">

  
		<hr />
  				<span class="hidden">Path to this page:</span>
				<form Method="POST" Action="phpnub.php" Name="Nub">Command: &nbsp;<input size="99" name="command" /><br />
  				<input type="submit" /><input type="reset" /></form>
Commands should be in format: google<? echo $sep ?>phpnub<br>
			</div>

		</div>
<p style="font-size:8pt;width:100;font-weight:normal;border:1px dashed black;padding:5px;">			
			<u><b>The Latest News:</b></u><br/>
				<? 
   					$fd = fopen("admin/news", "r");
   					if ($fd) {
      					$str = "";
      					while(!feof($fd)) {
         				$str .= fread($fd, 4096);
      					}
     					fclose($fd);
   					} else {
     					$str = "";
  					}	
   					echo nl2br($str);
   					if (isset($demo_message)) echo $demo_message;
					?>
				</p>


		<div style="text-align: center;" id="footer">
  
			<hr style="margin-left: auto; margin-right: auto;" />
  			Copyleft Paperprogs &copy; 2004&ndash;06, Template by John Zaitseff.<span class="notprinted"></span>
 			<br />

			

		</div>


	</body>
</html>
