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


$sql = "select * from tasks WHERE username='$cuser' ORDER BY priority DESC";

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
<table style="text-align: left; width: 469px; height: 60px;" border="1" cellpadding="2" cellspacing="2">
  <tbody>
    <tr>
      <td>Task Name</td>
      <td>Time/Date</td>
      <td>Priority</td>
    </tr>
EOF

while (@row=$sth->fetchrow_array) {
#	print @row;
#	my @res = @row[0];
	print "<tr><td><a href='view.pl?id=$row[0]'>$row[1]</a></td><td>$row[5]</td><td>$row[3]</td></tr>";
#	print "";
}

print <<EOF;
  </tbody>
</table>
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
