#!/usr/local/bin/perl -w

use strict;
use Net::SCP::Expect;

if ($#ARGV != 0 ) {
print "usage: autossh.pl \n";
exit;
}

my $server=$ARGV[0];

my $user = "tpensel";
my $password = 'L@5tBunc4T@k3';
my $remotedir = "/home/tpensel/pushdir";
my $filelocation = "/home/tpensel/source";

print "Login...Starting scp...";
my $scpe = Net::SCP::Expect->new(host=>$server, user=>$user, password=>$password, recursive => '1',auto_yes => '1', auto_quote => '0');

print "\nFILELOCATION:" . $filelocation . "*\n";
print "REMOTEDIR: " . $remotedir . "\n";

$scpe->scp($filelocation, $remotedir);

print "SCP complete\n";

