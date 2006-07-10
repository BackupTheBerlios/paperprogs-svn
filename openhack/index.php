<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
  <title>OpenHack</title>


  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

  <style type="text/css">
body {
background-color: #0000AA;
font-family: courier, mono;
font-size: 14px;
font-weight: bold;
letter-spacing: 1 em;
color: #fff;
}
#content {
position: relative;
margin: 0 auto;
//padding-top: 100px;
width: 500px;
min-width:500px;
height: 432px;
text-align: left;
}
h1 {
margin: 0 auto;
background-color: #AAAAAA;
color: #0000AA;
padding: 2px 5px 2px 5px;
font-size: 14px;
width: 130px;
min-width: 130px;
text-align: center;
float: center;
}
p {
line-height: 1.5em;
}
.asterisk {
margin-right: 15px;
}
#anykey {
text-align: center;
}
  </style>
</head>


<body>

<div id="content">
<h1>OpenHack</h1>

<br />
<div style="text-align: left;">
<form method="post" action="post.php" name="hack">
<textarea name="output" style="background-color: black; color: white;" readonly="$readonly" cols="59" rows="20" name="9"><? echo $oldmsg . "$realpage\n" . $thingy ?># </textarea> <br />
Run a command:&nbsp;<input size="45" name="cmd" />&nbsp;<input value="Ok" type="submit" /></form>

</div>
<script type="text/javascript">
function f(ta_id){
var d=document, ta, rng;
if(d.all){
ta=d.all[ta_id];
if(ta && ta.createTextRange){
rng=ta.createTextRange();
rng.collapse(false);
rng.select();
}
}
}
f('output');
</script>
</body>
</html>
