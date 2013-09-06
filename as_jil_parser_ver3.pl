#!/usr/bin/perl

use 5.014;

#  This program will parse Autosys JIL into indendent JIL jobs
#  Second, it will then allow you to search for a matching string 
# and give you the whole jil that matches that search string.

# Load JIL

# parse JIL

# load into hash

# Variable table

my $workingfile_name;  # working file name containing AS JIL
my @workingfile;  # working file contents containing AS JIL
my $line; # line of AS JIL
my $jobname;  # jobname of AS JIL
my $match_AS_jil_header; # regex for jil header

$workingfile_name = shift @ARGV;

open FILE, "$workingfile_name" or die "Problem accessing the $workingfile_name, specifically $!\n";
@workingfile = <FILE>;
close(FILE);

foreach $line (@workingfile) {
	if ($line =~ m/.*?(\/\*).*?((?:[a-z][a-z]+)).*?(\*\/)(.)/is) {  # finds lines /* --- $jobname --- */ 
	$jobname = $2 ;
	print "$jobname\n"; 

    }
}


