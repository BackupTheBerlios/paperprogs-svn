#!/usr/bin/perl
use DBI;
#use strict; not on because we use too many global variables
my $dbh = DBI->connect("dbi:SQLite:all.db", "", "",
{RaiseError => 1, AutoCommit => 1});

# If you screwed up your whole database, delete the file 'all.db' and uncomment initdb, if you only slighly screwed it up, uncomment reinitdb

#reinitdb();
#initdb();

sub reinitdb {
$dbh->do("DROP TABLE rooms");
$dbh->do("CREATE TABLE rooms (id INTEGER PRIMARY KEY, name, look, exits)");
$dbh->do("INSERT INTO rooms VALUES (NULL, 'Hell', 'You are standing in a firey pit of hell, there is a small boy named Bill.', 'u')");
$dbh->do("INSERT INTO rooms VALUES (NULL, 'Heaven', 'You are standing in heaven, Tux is here catching butterflys.', 's')");
$dbh->do("INSERT INTO rooms VALUES (NULL, 'Gates to Heaven', 'Because youre not good enough.', 'nd')");
$dbh->do("INSERT INTO rooms VALUES (NULL, 'Earth', 'You are on earth, even the programer couldnt describe this area.', 'ud')");
$dbh->do("DROP TABLE items");
$dbh->do("CREATE TABLE items (id INTEGER PRIMARY KEY, name, look, has, areaap)");
$dbh->do("INSERT INTO items VALUES (NULL, 'Tux', 'The one and only linux penguin', '0', '2')");
$dbh->do("INSERT INTO items VALUES (NULL, 'Money', 'Cash for buying stuff.', '1', '0')");
$dbh->do("INSERT INTO items VALUES (NULL, 'SQL Needle', 'For SQL Injections', '1', '0')");
foreach my $item (qw(Net Pen Milk Freewill Error Billy God Peter Gate)) {
  $dbh->do("INSERT INTO items VALUES (NULL, '$item','No description', '0', '0')");
}
$dbh->do("DROP TABLE monsters");
$dbh->do("CREATE TABLE monsters (id INTEGER PRIMARY KEY, name, attack, health, areaap)");
$dbh->do("INSERT INTO monsters VALUES (NULL, 'You', '12', '50', '0')");
$dbh->do("INSERT INTO monsters VALUES (NULL, 'Bill', '1', '3', '1')");
#my $all = $dbh->selectall_arrayref("SELECT * FROM items");
#foreach my $row (@$all) {
#  my ($id, $word, $look) = @$row;
#  print "$word : $look\n";
#}
}

sub initdb {
#$dbh->do("DROP TABLE rooms");
$dbh->do("CREATE TABLE rooms (id INTEGER PRIMARY KEY, name, look, exits)");
$dbh->do("INSERT INTO rooms VALUES (NULL, 'Hell', 'You are standing in a firey pit of hell.', 'u')");
$dbh->do("INSERT INTO rooms VALUES (NULL, 'Heaven', 'You are standing in heaven.', 's')");
$dbh->do("INSERT INTO rooms VALUES (NULL, 'Gates to Heaven', 'Because youre not good enough.', 'nd')");
$dbh->do("INSERT INTO rooms VALUES (NULL, 'Earth', 'You are on earth, even the programer couldnt describe this area.', 'ud')");
#$dbh->do("DROP TABLE items");
$dbh->do("CREATE TABLE items (id INTEGER PRIMARY KEY, name, look, has, areaap)");
$dbh->do("INSERT INTO items VALUES (NULL, 'Tux', 'The one and only linux penguin', '0', '2')");
$dbh->do("INSERT INTO items VALUES (NULL, 'Money', 'Cash for buying stuff.', '1', '0')");
$dbh->do("INSERT INTO items VALUES (NULL, 'SQL Needle', 'For SQL Injections', '1', '0')");
foreach my $item (qw(Net Pen Milk Freewill Error Billy God Peter Gate)) {
  $dbh->do("INSERT INTO items VALUES (NULL, '$item','No description', '0', '0')");
}
#$dbh->do("DROP TABLE monsters");
$dbh->do("CREATE TABLE monsters (id INTEGER PRIMARY KEY, name, attack, health, areaap)");
$dbh->do("INSERT INTO monsters VALUES (NULL, 'You', '12', '50', '0')");
$dbh->do("INSERT INTO monsters VALUES (NULL, 'Bill', '1', '3', '1')");
#my $all = $dbh->selectall_arrayref("SELECT * FROM items");
#foreach my $row (@$all) {
#  my ($id, $word, $look) = @$row;
#  print "$word : $look\n";
#}
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
  my $all = $dbh->selectall_arrayref("SELECT * FROM items WHERE areaap = '$area'");
  if ($all) { print "Items here:\n"; }
  foreach my $row (@$all) {
    my ($id, $word, $look) = @$row;
    print "$word \n";
  }
  my $all = $dbh->selectall_arrayref("SELECT * FROM monsters WHERE areaap = '$area'");
  if ($all) { print "Monsters here:\n"; }
  foreach my $row (@$all) {
    my ($id, $word, $look) = @$row;
    print "$word \n";
  }
  return $area;					#return the area so that the other parts of this prog can use it
}
}

sub giveitem {
$dbh->do("UPDATE items SET has='1' WHERE name = '$_[0]' AND areaap= '$barea'");	#Mark has to 1
my $all = $dbh->selectall_arrayref("SELECT * FROM items WHERE name = '$_[0]' AND areaap= '$barea' ");	# Run SQLite Query
if ($all) {
foreach my $row (@$all) {			#parse results
  my ($id, $name, $attrib, $has) = @$row;	#define
  print "You got $name\n";	                        #print results
  return $area;					#return the area so that the other parts of this prog can use it
}
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
my $all = $dbh->selectall_arrayref("SELECT * FROM monsters WHERE name = '$_[0]' AND areaap = '$barea'");
foreach my $row (@$all) {
  our ($id, $word, $attack, $health) = @$row;
  print "Attacking a $word\n";
}
if ($word) {
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
$dbh->do("UPDATE monsters SET health = '$healthu' WHERE id = '1'");
} else { print "Monster not in area"; return 0; }
} 

#Initialiaze, Load First Area
my $win = 0;
my $quit = 0;
print "Welcome to killbill\n";
print "God: Bill Gates has stolen freewill, you should get it back from him immediately";
print "You: No";
print "God: <ZAP>";
print "You: Ok, Ok";
our $barea = startarea(4);

while ( ($win != 1) && ($quit != 1) ) {			# Main Loop
print 'c:> ';						# Don't dis the shell :D
our $command = <STDIN>;					# Take input
if (defined $command) { 
# alias commands
if ($command eq "n") { $command = "north"; }
if ($command eq "s") { $command = "south"; }
if ($command eq "e") { $command = "east"; }
if ($command eq "w") { $command = "west"; }
if ($command eq "u") { $command = "up"; }
if ($command eq "d") { $command = "down"; }
my @commandword = split(" ", $command);
if ( ($barea == 1) && ($command =~ /up/) ) { $barea = startarea(4); } 
elsif ( ($barea == 4) && ($command =~ /up/) ) { $barea = startarea(3); } 
elsif ( ($barea == 4) && ($command =~ /down/) ) { $barea = startarea(1); }
elsif ( ($barea == 3) && ($command =~ /north/) ) { $barea = startarea(2); }
elsif ( ($barea == 3) && ($command =~ /down/) ) { $barea = startarea(4); }
elsif ( ($barea == 2) && ($command =~ /south/) ) { $barea = startarea(3); } 
elsif ( $commandword[0] eq "kill" ) { initattack($commandword[1]); }
elsif ( $commandword[0] eq "get" ) { giveitem($commandword[1]); }
elsif ( ( checkitem(3) ) && ($command =~ /inject/) ) { inject(); } 
elsif ($command =~ /quit/) { $quit = 1 }
elsif ($command =~ /exit/) { $quit = 1 } # Exit
elsif ($command =~ /inventory/) { listinvo(); }
else { print "What was that?\n"; }
} else { print "Please type something intelligent\n"; }
}
