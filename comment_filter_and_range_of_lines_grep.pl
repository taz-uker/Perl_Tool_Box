#!/usr/bin/perl

use 5.014;
use strict;
use warnings;
use Data::Dumper;

#  This program will parse Autosys JIL into indendent JIL jobs
#  Second, it will then allow you to search for a matching string
# and give you the whole jil that matches that search string.
#
# written by Terry Pensel  04/2013

# Load JIL

# parse JIL

# load into hash

# Variable table

my $workingfile_name;    # working file name containing AS JIL
my @workingfile;         # working file contents containing AS JIL
my $line;                # line of AS JIL
my @adj_file; 


# Start of Main Program

$workingfile_name = shift @ARGV;

open FILE, "$workingfile_name"
  or die "Problem accessing the $workingfile_name, specifically $!\n";
@workingfile = <FILE>;
close(FILE);

 foreach $line (@workingfile) {
	      
    if ( $line =~ m/.*?(\/\*).*?(([a-z][a-z]+)).*?(\*\/)(.)/is ) {
        $line = "" ; # removes comment line for easier processing will add back in.
    }
 }
 # extracts range of lines between insert_job: and a blank line 
 @adj_file = grep(/insert_job\:/ .. /^$/, @workingfile) ; 

print "@adj_file\n";
exit

