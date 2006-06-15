#!/usr/bin/perl

use CGI;
use DBI;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);

do "db.inc.pl";
my $q = new CGI;
print $q->header( "text/html" );

my $cpass = $q->cookie('taskhash');
my $cuser = $q->cookie('taskname');
if ($q->param(user) ne "") {
$cuser = $q->param(user);
$cpass = $q->param(pass);
}

if ($cuser eq "") { die "Login First!" }
if ($cpass eq "") { die "Login First!" }


$sql = "select * from users WHERE name='$cuser' AND passhash='$cpass'";

$sth = $dbh->prepare($sql);

$sth->execute || die "Horrible Failure on SQL injection :$!";
my $testme = 0;
#output database results
while (@row=$sth->fetchrow_array) {
	$testme++;
}

if ($testme == 0) {die "Not Logged In";}

if ($q->param(timed) ne "") {

my $timte = $q->param(timed);
my $nameo = $q->param(nameo);
my $prio = $q->param(prio);
my $pdesc = $q->param(pdesc);
my $tags = $q->param(tags);

$sql = "INSERT INTO tasks VALUES ('', '$nameo', '$pdesc', '$prio', '$cuser', '$timte', '$tags')";

$sth = $dbh->prepare($sql);

$sth->execute || die "Horrible Failure on SQL injection :$!";
print "Added <meta http-equiv=\"refresh\" content=\"0;url=main.pl\">";

} else {

print <<EOF;

  <link rel="stylesheet" type="text/css" href="aran.css" media="screen" title="studio7designs (screen)" />

  <title></title>
</head>


<body>

<script type="text/javascript" language="javascript">
   var http_request = false;
   function makePOSTRequest(url, parameters) {
      http_request = false;
      if (window.XMLHttpRequest) { // Mozilla, Safari,...
         http_request = new XMLHttpRequest();
         if (http_request.overrideMimeType) {
            http_request.overrideMimeType('text/xml');
         }
      } else if (window.ActiveXObject) { // IE
         try {
            http_request = new ActiveXObject("Msxml2.XMLHTTP");
         } catch (e) {
            try {
               http_request = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e) {}
         }
      }
      if (!http_request) {
         alert('Cannot create XMLHTTP instance');
         return false;
      }
      
      http_request.onreadystatechange = alertContents;
      http_request.open('POST', url, true);
      http_request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      http_request.setRequestHeader("Content-length", parameters.length);
      http_request.setRequestHeader("Connection", "close");
      http_request.send(parameters);
   }

   function alertContents() {
      if (http_request.readyState == 4) {
         if (http_request.status == 200) {
            //alert(http_request.responseText);
            result = http_request.responseText;
            document.getElementById('myspan').innerHTML = result;            
         } else {
            alert('There was a problem with the request.');
         }
      }
   }
   
   function get(obj) {
      var poststr = "nameo=" + encodeURI( document.forms[0].nameo.value ) +
                    "&timed=" + encodeURI( document.forms[0].timed.value ) +
                    "&prio=" + encodeURI( document.forms[0].prio.value ) +
                    "&tags=" + encodeURI( document.forms[0].tags.value ) +
                    "&pdesc=" + encodeURI( document.forms[0].pdesc.value );
      makePOSTRequest('add.pl', poststr);
   }
</script>

<div id="leftsidebar">
<img id="header" src="images/header.jpg" alt="header" height="35" width="760" />


 
<div class="rightnews">
    Welcome To Paperioritizer, Schedule some stuff now.<br />

<br />

  </div>
 
<div id="menu">
<h2 class="hide">Menu:</h2>

<ul>

  <li><a href="main.pl">View Tasks</a></li>

  <li><a href="add.pl">Add Tasks</a></li>

  <li><a href="logout.pl">Logout (when added)</a></li>

  <li><a href="#">Contact</a><span class="style3">&nbsp;</span><br />
  </li>

</ul>

<div class="leftnews">Logged in as $cuser<br />

  <img src="images/Bullet_green.gif" alt="right blue" height="16" width="19" />
</div>

</div>


<div id="content">
  
<h3 class="style7">PAPERIORITIZER: The Paper Progs Prioritizer<br />
</h3>
 
  <span class="style3"><br />
</span>
<form action="javascript:get(document.getElementById('myform'));" name="myform" id="myform">
Task Name: <input name="nameo" type="text"><br>

Time/Date:<input name="timed" type="text"><br>

Priority:<input name="prio" type="text"><br>
Description:<input name="pdesc" type="text"><br>
Tags (space seperated):<input name="tags" type="text">
<br>
<input type="button" name="button" value="Submit" 
   onclick="javascript:get(this.parentNode);">
</form>

<br><br>
Status:
<span name="myspan" id="myspan">Enter something and click Submit</span>
<span class="style3"></span>
<p><br />
      
<br />

    </p>

</div>


<div id="footer">original template by <a href="http://www.studio7designs.com">Aran Down</a>.<br />
Modifyed By ultramancool of paperprogs for Paperioritizer<br />
<span style="font-weight: bold;">Paperioritizer 0.01&nbsp;Alpha Beta</span></div>

<br>
</body>
</html>
EOF
}
