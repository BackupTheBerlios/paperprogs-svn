#!/usr/bin/perl

use CGI;
use DBI;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use Digest::MD5 qw(md5 md5_hex);
$q = new CGI;

	$usercook = $q->cookie(-name=>'taskname',
				 -value=>'dead',
				 -path=>'/');

	$passcook = $q->cookie(-name=>'taskhash',
				 -value=>'dead',
				 -path=>'/');
	print $q->header(-cookie=>[$usercook,$passcook]);
	$q->start_html("Logging You In...");
	print "You are now logged out <meta http-equiv=\"refresh\" content=\"1;url=index.html\">";
print $q->end_html;
