#!/usr/bin/perl -w
#
# This program greps the SiteID record for the filetran.pl 
#
# created by Terry Pensel 9/2013
#
# 
#
use strict;

my $siteIDfile = "/home/tpensel/siteIDrec.txt";

my $siteid = $ARGV[0];

#print "SITE ID ", $siteid, "\n\n";

open(FILE, $siteIDfile) or die "Can NOT open $siteIDfile!!!!";
my @recs = <FILE>;
close(FILE);

my @output = grep(/__SiteID\|$siteid/ .. /\*{5,}/, @recs);

print @output;

exit;
