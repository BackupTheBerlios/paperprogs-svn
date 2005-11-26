 #!/usr/bin/perl -w
 use IO::Socket;
 use Net::hostent;              # for OO version of gethostbyaddr

 $PORT = 135;                  # pick something not in use

 $server = IO::Socket::INET->new( Proto     => 'tcp',
                                  LocalPort => $PORT,
                                  Listen    => SOMAXCONN,
                                  Reuse     => 1);

 die "can't setup server" unless $server;
 print "[Server $0 accepting clients]\n";
 our $jimmy=0;
 while ($client = $server->accept()) {
   $client->autoflush(1);
   $jimmy++;
   $hostinfo = gethostbyaddr($client->peeraddr);
   printf "[Connect $jimmy from %s]\n", $hostinfo->name || $client->peerhost;
   print $client "Welcome to Script Kiddie Hell. You're Visiter $jimmy\n";
   while($line = <$client>) {
   print $client "Operation Complete, now please, GET OFF MY 1337 b0xen!\n
   ";
   }   
   close $client;
 }
