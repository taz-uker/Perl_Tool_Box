#!/usr/bin/perl
#
# This program greps the SiteID record for the filetran.pl 
#
# created by Terry Pensel 9/2013
#
# 
#
my $siteIDfile = "/home/tpensel/siteIDrec.txt";

my $siteid = $ARGV[0];

open(FILE, $siteIDfile) or die "Can NOT open $siteIDfile!!!!";
my @recs = <FILE>;
close(FILE);

my @output = grep(/__SiteID\|$siteid/ .. /\*{5,}/, @recs);

print @output;

exit;