#!/usr/bin/perl -w
print "Welcome to the BlobZone Pack Manager";
print "Powered by 7zip";
print "------------------------------------";
print "Enter name of file to extract";
my $extractme = <STDIN>;
system("7z x -y $extractme");
print "Hope that worked :-)";

