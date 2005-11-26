#!/usr/bin/perl
 use IO::Socket;
 use Net::hostent;              # for OO version of gethostbyaddr

 $PORT = $ARGV[0];                  # pick something not in use

 $server = IO::Socket::INET->new( Proto     => 'tcp',
                                  LocalPort => $PORT,
                                  Listen    => SOMAXCONN,
                                  Reuse     => 1);

 die "can't setup server" unless $server;
 print "[Server $0 accepting clients]\n";
 our $jimmy;
 while ($client = $server->accept()) {
   our $mrh;
   our $curip;
   our $hostinfo;
   open LOG, ">>out.log" or die $!;
   $client->autoflush(1);
   $hostinfo = gethostbyaddr($client->peeraddr);
   die "a name resolution failed!" unless $hostinfo->addr;
   $curip = inet_ntoa($hostinfo->addr);
   if ($mrh ne $curip) { print LOG $curip, "\n"; };
   if ($mrh ne $curip) { $jimmy++; };
   printf "[Connect $jimmy from %s]\n", inet_ntoa($hostinfo->addr);
   print $client "Welcome to Script Kiddie Hell. You're Visiter $jimmy\n";  
   close $client;
   $mrh = inet_ntoa($hostinfo->addr);
 }
