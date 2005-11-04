#!/usr/bin/perl
open FILE, "questions" or die $!;
open ANSW, "answers" or die $!;
my $right;
my $wrong;
my @quest = <FILE>;
my @answ = <ANSW>;
my @array = 0...9;
our $rep = 'rep';
dictate();
sub dictate {
foreach $i (@array) {
	system('clear');
	our $string = "@quest[$i]?";
	say();
	sub say {print $string;}
	ask();
	sub ask {our $speller = <STDIN>;}
	if ($speller eq @answ[$i]) {
		print "Correct\n";
		$right++;
	} 
	if (@answ[$i] ne $speller)  {
		print "Wrong\n";
		$wrong++;
		print "Corrent answer is:", @answ[$i];
	};
	sleep 2;
};
};
print $right/10*100, "Percent\n";
print "Right: $right\n";
print "wrong: $wrong\n";
