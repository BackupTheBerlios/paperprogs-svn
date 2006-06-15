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

$cid = $q->param(id);
$sql = "select * from tasks WHERE username='$cuser' AND id='$cid'";

$sth = $dbh->prepare($sql);

$sth->execute || die "Horrible Failure on SQL injection :$!";
my $testme = 0;
#output database results

print <<EOF;

  <link rel="stylesheet" type="text/css" href="aran.css" media="screen" title="studio7designs (screen)" />

  <title></title>
</head>


<body>


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
            document.getElementById('mspan').innerHTML = result;            
         } else {
            alert('There was a problem with the request.');
         }
      }
   }
   
   function get2(obj) {
      var poststr = "id=" + encodeURI( document.forms[0].id.value );
      makePOSTRequest('edit.pl', poststr);
   }

   function get(obj) {
      var poststr = "nameo=" + encodeURI( document.forms[1].nameo.value ) +
                    "&timed=" + encodeURI( document.forms[1].timed.value ) +
                    "&id=" + encodeURI( document.forms[1].id.value ) +
                    "&prio=" + encodeURI( document.forms[1].prio.value ) +
                    "&tags=" + encodeURI( document.forms[1].tags.value ) +
                    "&pdesc=" + encodeURI( document.forms[1].pdesc.value );
      makePOSTRequest('edit2.pl', poststr);
   }
</script>
EOF

while (@row=$sth->fetchrow_array) {
#	print @row;
#	my @res = @row[0];
	print <<EOF;
<h2>$row[1]</h2><br>Date/Time:$row[5]<br>Priority: $row[3]</br>Description: $row[2] <br> Tags: $row[6] <br><a href='delete.pl?id=$row[0]'>Delete?</a>
<form action="javascript:get2(document.getElementById('edform'));" name="edform" id="edform">
<input name="id" type="hidden" value="$row[0]">
<input type="button" name="button" value="Edit" 
   onclick="javascript:get2(this.parentNode);">
</form>
<span name="mspan" id="mspan"></span>
EOF
#	print "";
}

print <<EOF;
<span class="style3"></span>
<p><br />
      
<br />

    </p>

</div>


<div id="footer">original template by <a href="http://www.studio7designs.com">Aran Down</a>.<br />
Modifyed By ultramancool of paperprogs for Paperioritizer<br />
<span style="font-weight: bold;">Paperioritizer 0.01&nbsp;Alpha Beta</span></div>


</div>

</body>
</html>
EOF
