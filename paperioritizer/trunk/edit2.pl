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

my $coolid = $q->param(id);
my $timte = $q->param(timed);
my $nameo = $q->param(nameo);
my $prio = $q->param(prio);
my $pdesc = $q->param(pdesc);
my $tags = $q->param(tags);

$sql = "UPDATE tasks SET dtad='$timte', name='$nameo', priority='$prio', description='$pdesc', tags='$tags' WHERE username='$cuser' AND id='$coolid'";

$sth = $dbh->prepare($sql);

$sth->execute || die "Horrible Failure on SQL injection :$!";
print "Edit Successful";

} else {

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
<table style="text-align: left; width: 469px; height: 60px;" border="1" cellpadding="2" cellspacing="2">
<form action="add.pl" method="post">
Name: <input name="nameo" type="text"><br>

Time/Date:<input name="timed" type="text"><br>

Priority:<input name="prio" type="text"><br>
Description:<input name="pdesc" type="text"><br>

        <input value="Send" type="submit"><br>
</form>

<span class="style3"></span>
<p><br />
      
<br />

    </p>

</div>

<br>
</body>
</html>
EOF
}
