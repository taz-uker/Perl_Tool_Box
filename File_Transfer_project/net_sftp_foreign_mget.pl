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
my $remotedir = "/home/tpensel/pulldir";
my $filelocation = "/home/tpensel/source";
my $pattern = "*.stf";

print "Login...Starting sftp...";

# debug option
#my $sftp = Net::SFTP::Foreign->new(host=>$server, user=>$user, password=>$password, more=>'-v');

my $sftp = Net::SFTP::Foreign->new(host=>$server, user=>$user, password=>$password);

$sftp->die_on_error("Unable to establish SFTP connection");
 
$sftp->setcwd($remotedir) or die "unable to change cwd: " . $sftp->error;
 
$sftp->mget("$remotedir/$pattern", "$filelocation") or die "pull failed: files matching the pattern $pattern" . $sftp->error;


print "\nSFTP complete\. \n\nFiles matching the pattern $pattern pulled from $remotedir on $server to $hostname";
print "\nto the $filelocation directory.\n\n";
