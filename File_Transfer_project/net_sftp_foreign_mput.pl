#!/usr/local/bin/perl -w

use strict;
use Net::SFTP::Foreign;

# works 3:20PM ET 8/20/2013
# created by Terry Pensel

if ($#ARGV != 0 ) {
	print "usage: net_sftp_foreign.pl \n";
exit;
}


my $server=$ARGV[0];

my $hostname = `hostname`;

my $user = "tpensel";
my $password = 'L@5tBunc4T@k3';
my $remotedir = "/home/tpensel/pushdir";
my $filelocation = "/home/tpensel/source";
my $pattern = "*.txt";

print "Login...Starting sftp...";

# debug option
#my $sftp = Net::SFTP::Foreign->new(host=>$server, user=>$user, password=>$password, more=>'-v');

my $sftp = Net::SFTP::Foreign->new(host=>$server, user=>$user, password=>$password);

$sftp->die_on_error("Unable to establish SFTP connection");
 
$sftp->setcwd($remotedir) or die "unable to change cwd: " . $sftp->error;
 
$sftp->mput("$filelocation/$pattern") or die "put failed: files matching the pattern $pattern" . $sftp->error;


print "\nSFTP complete\. \n\nFiles matching the pattern $pattern pushed to $remotedir on $server from $hostname";
print "\nfrom the $filelocation directory.\n\n";
