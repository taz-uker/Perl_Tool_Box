#!/usr/local/bin/perl -w 

#
# This program gets SiteID record from another machine.
# created by Terry Pensel 08/2013
#
use strict;
use Net::OpenSSH;
use Data::Dumper;

my $siteID = "sts_tlp";
my $siteIDfile = "siteIDrec.txt";

print siteidrec($siteID);

sub siteidrec {
	my $user = 'tpensel';
    my $host = 'workdevae.it.ohio-state.edu';
  
    my $cmd ="rem_getsiteID.pl $siteID";

    my $ssh = Net::OpenSSH->new("$user\@$host");
    $ssh->error and die "Couldn't establish SSH connection: ". $ssh->error;
    
    #my @output = $ssh->capture("ls /");
      
    my @output = $ssh->system("/home/tpensel/$cmd");
    $ssh->error and die "Operation did NOT complete successfully ". $ssh->error;
    print @output;
}
