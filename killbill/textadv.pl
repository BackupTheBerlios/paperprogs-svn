#!/usr/bin/perl
use DBI;
my $dbh = DBI->connect("dbi:SQLite:all.db", "", "",
{RaiseError => 1, AutoCommit => 1});

# If you screwed up your whole database, delete the file 'all.db' and uncomment initdb, if you only slighly screwed it up, uncomment reinitdb

reinitdb();
#initdb();

sub initdb {
#$dbh->do("DROP TABLE rooms");
$dbh->do("CREATE TABLE rooms (id INTEGER PRIMARY KEY, name, look, exits)");
$dbh->do("INSERT INTO rooms VALUES (NULL, 'Hell', 'You are standing in a firey pit of hell, there is a small boy named Bill.', 'u')");
$dbh->do("INSERT INTO rooms VALUES (NULL, 'Heaven', 'You are standing in heaven, Tux is here catching butterflys.', 's')");
$dbh->do("INSERT INTO rooms VALUES (NULL, 'Gates to Heaven', 'Because youre not good enough.', 'nd')");
$dbh->do("INSERT INTO rooms VALUES (NULL, 'Earth', 'You are on earth, even the programer couldnt describe this area.', 'ud')");
#$dbh->do("DROP TABLE items");
$dbh->do("CREATE TABLE items (id INTEGER PRIMARY KEY, name, look, has)");
$dbh->do("INSERT INTO items VALUES (NULL, 'Tux', 'The one and only linux penguin', '0')");
$dbh->do("INSERT INTO items VALUES (NULL, 'Money', 'Cash for buying stuff.', '1')");
$dbh->do("INSERT INTO items VALUES (NULL, 'SQL Needle', 'For SQL Injections', '1')");
foreach my $item (qw(Net Pen Milk Freewill Error Billy God Peter Gate)) {
  $dbh->do("INSERT INTO items VALUES (NULL, '$item','No description', '0')");
}
$dbh->do("CREATE TABLE monsters (id INTEGER PRIMARY KEY, name, attack, health)");
$dbh->do("INSERT INTO monsters VALUES (NULL, 'You', '12', '50')");
$dbh->do("INSERT INTO monsters VALUES (NULL, 'Moron', '1', '3')");
#my $all = $dbh->selectall_arrayref("SELECT * FROM items");
#foreach my $row (@$all) {
#  my ($id, $word, $look) = @$row;
#  print "$word : $look\n";
#}
}

sub reinitdb {
$dbh->do("DROP TABLE rooms");
$dbh->do("CREATE TABLE rooms (id INTEGER PRIMARY KEY, name, look, exits)");
$dbh->do("INSERT INTO rooms VALUES (NULL, 'Hell', 'You are standing in a firey pit of hell, there is a small boy named Bill.', 'u')");
$dbh->do("INSERT INTO rooms VALUES (NULL, 'Heaven', 'You are standing in heaven, Tux is here catching butterflys.', 's')");
$dbh->do("INSERT INTO rooms VALUES (NULL, 'Gates to Heaven', 'Because youre not good enough', 'nd')");
$dbh->do("INSERT INTO rooms VALUES (NULL, 'Earth', 'You are on earth, even the programer couldnt describe this area.', 'ud')");
$dbh->do("DROP TABLE items");
$dbh->do("CREATE TABLE items (id INTEGER PRIMARY KEY, name, look, has)");
$dbh->do("INSERT INTO items VALUES (NULL, 'Tux', 'The one and only linux penguin', '0')");
$dbh->do("INSERT INTO items VALUES (NULL, 'Money', 'Cash for buying stuff.', '1')");
$dbh->do("INSERT INTO items VALUES (NULL, 'SQL Needle', 'For SQL Injections', '1')");
foreach my $item (qw(Net Pen Milk Freewill Error Billy God Peter Gate)) {
  $dbh->do("INSERT INTO items VALUES (NULL, '$item','No description', '0')");
}
$dbh->do("DROP TABLE monsters");
$dbh->do("CREATE TABLE monsters (id INTEGER PRIMARY KEY, name, attack, health)");
$dbh->do("INSERT INTO monsters VALUES (NULL, 'You', '12', '50')");
$dbh->do("INSERT INTO monsters VALUES (NULL, 'Moron', '1', '3')");
}

#Code To Load an Area
sub startarea {
print "You are in ";
my $all = $dbh->selectall_arrayref("SELECT * FROM rooms WHERE id = '$_[0]' LIMIT 1");	# Run SQLite Query
foreach my $row (@$all) {			#parse results
  my ($area, $word, $look, $exits) = @$row;	#define
  print "$word\n$look\nExits are:";	#print results
  if ($exits =~ /u/) { print "up " };
  if ($exits =~ /d/) { print "down " };
  if ($exits =~ /n/) { print "north " };
  if ($exits =~ /s/) { print "south " };
  if ($exits =~ /e/) { print "east " };
  if ($exits =~ /w/) { print "west " };
  print "\n";
  return $area;					#return the area so that the other parts of this prog can use it
}
}

sub giveitem {
$dbh->do("UPDATE items SET has='1' WHERE id = '$_[0]'");	#Mark has to 1
print "You got";
my $all = $dbh->selectall_arrayref("SELECT * FROM items WHERE id = '$_[0]'");	# Run SQLite Query
foreach my $row (@$all) {			#parse results
  my ($id, $name, $attrib, $has) = @$row;	#define
  print "$name\n";	                        #print results
  return $area;					#return the area so that the other parts of this prog can use it
}
}

sub listinvo {
my $all = $dbh->selectall_arrayref("SELECT * FROM items WHERE has = '1'");
foreach my $row (@$all) {
  my ($id, $word, $look) = @$row;
  print "$word : $look\n";
}
}

sub checkitem {
my $all = $dbh->selectall_arrayref("SELECT * FROM items WHERE has = '1' AND id = '$_[0]'");
foreach my $row (@$all) {
  return 1;
}
}

sub inject {
print "Enter SQLite Query To Inject\n";
my $query = <STDIN>;
print "Injecting\n";
$dbh->do("$query");
print "Injected\n";
}

sub initattack {
my $all = $dbh->selectall_arrayref("SELECT * FROM monsters WHERE id = '$_[0]'");
foreach my $row (@$all) {
  our ($id, $word, $attack, $health) = @$row;
  print "Attacking a $word\n";
}
my $all = $dbh->selectall_arrayref("SELECT * FROM monsters WHERE id = '1'");
foreach my $row (@$all) {
  our ($idu, $wordu, $attacku, $healthu) = @$row;
  print "You are a $wordu\n";
}
while ( ($healthu != 0) && ($health != 0) ) {
print "Starting New Attack Round\n";
my $newattack = int( rand(12)) + $attack;
my $newattacku = int( rand(12)) + $attacku;
if ($newattack > $newattacku) {print "You lost the round $newattack vs $newattacku \n"; $healthu--;} elsif ($newattacku > $newattack) {print "You won the round $newattacku vs $newattack\n"; $health--; } else { print "Tie $newattacku vs $newattack\n "; }
}
if ($health == 0) {print "You Won!\n";}
if ($healthu == 0) {print "You Lost!\n";}
$dbh->do("UPDATE monster SET health = '$healthu' WHERE id = '1'");
}

#Initialiaze, Load First Area
my $win = 0;
my $quit = 0;
print "Welome to the unnamed text adventure\n";
our $barea = startarea(1);

while ( ($win != 1) && ($quit != 1) ) {			# Main Loop
print '$ ';						# Don't dis the shell :D
our $command = <STDIN>;					# Take input
if ( ($barea == 1) && ($command =~ /up/) ) { $barea = startarea(4); } 
elsif ( ($barea == 4) && ($command =~ /up/) ) { $barea = startarea(3); } 
elsif ( ($barea == 4) && ($command =~ /down/) ) { $barea = startarea(1); }
elsif ( ($barea == 3) && ($command =~ /north/) ) { $barea = startarea(2); }
elsif ( ($barea == 3) && ($command =~ /down/) ) { $barea = startarea(4); }
elsif ( ($barea == 2) && ($command =~ /south/) ) { $barea = startarea(3); } 
elsif ( ($barea == 1) && ($command =~ /kill bill/) ) { initattack(2); }
elsif ( ($barea == 2) && ($command =~ /get tux/) ) { giveitem(1); }
elsif ( ( checkitem(3) ) && ($command =~ /inject/) ) { inject(); } 
elsif ($command =~ /quit/) { $quit = 1 }
elsif ($command =~ /exit/) { $quit = 1 } # Exit
elsif ($command =~ /inventory/) { listinvo(); }
else { print "Freak Error"; }
}
