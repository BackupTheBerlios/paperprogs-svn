#!/usr/bin/perl

use CGI;
use DBI;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);

do "db.inc.pl";
my $q = new CGI;
print $q->header( "text/html" );

my $cpass = $q->cookie('taskhash');
my $cuser = $q->cookie('taskname');

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
$sql = "DELETE from tasks WHERE username='$cuser' AND id='$cid'";

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
EOF

print "Deleted";

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
