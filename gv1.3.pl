#!/usr/bin/perl
#
# This program will find alll the global variables used in the HR, HC and cs jobs.
#

use 5.010;
use strict;
use warnings;
use List::MoreUtils qw(uniq);
use Data::Dumper;

# Variable Table

my $workingfile_name;
my @workingfile =[];
my $line;
my @adj_file;
my $first_part;
my $second_part;
my $jt_field_val;
my @all_jn;
my $jobname;
my $jn;
my $end_of_line;
my $conditions;
my @all_conditions;
my $cond_line;
my $cond; 
my %all_gv;
my @all_gv_items;
my @list_gv;
my %list_gv2job;
my %as_gv;
my $gvs;
my $one;
my $cnt;

 $workingfile_name = shift @ARGV;


open FILE, "$workingfile_name" or die "Problem accessing the $workingfile_name, specifically $!\n";
@workingfile = <FILE>;
close(FILE);

# build hash of global variables by jobname keys


foreach $line (@workingfile) {    
      if ($line =~ /insert_job\:/) {
            ( $first_part, $second_part, $jt_field_val ) = split /\:/, $line;
             $second_part =~ s/^\s+//;    # strips leading spaces
            ( $jn, $end_of_line ) = split /\s+/, $second_part;       
        }
        if ($line =~ /condition\:/) {  # updates command line and echo's out command 
            
           ($first_part, $conditions) = split(/\:/, $line);

           $conditions =~ s/^\s*// ;  # strips leading spaces 
            
           @all_conditions = undef if (scalar @all_conditions > 0); 

           @all_conditions = split(/\&/, $conditions);
           # print "Job Name $jn\n"; 
           # print "ALL CONDITONS\n";
           # print "@all_conditions\n";

           my @all_gv_items = undef if (scalar @all_gv_items > 0);

           @all_gv_items = grep { /\bv\(/ } @all_conditions; 
           # print "Job Name \n $jn\n";
           # print "ALL_GV_ITEMS @all_gv_items\n";
           $gvs = join (" ", @all_gv_items) if (scalar @all_gv_items > 0);
           $all_gv{$jn} = $gvs if defined $gvs;
         }     
}              
     

open OUT, ">gv1.3.tmp" or die "File was not able to be created: $!";

print OUT Dumper (%all_gv);

close(OUT);

# Translate routine from key/value pairs ($jobname/@all_gv_line) in %all_gv hash 
#  to a global variable/job name ($gv/@jobs) into the hash %list_gv2job  


@list_gv = values %all_gv;


my @total_gv ;

foreach $line (@list_gv) {
  @all_gv_items = split /\s+/, $line;
  push @total_gv, @all_gv_items; 
}

print "\n\nTotal GV\n\n";
print scalar @total_gv, " \n\n";

my $dummy = <STDIN>; 

my @uniq_gv = uniq(sort(@total_gv));

print "UNIQ GV\n";
foreach (@uniq_gv) {
  print "$_\n" ;
} 

# foreach $one (@list_gv) {
#   print "$one\n";
# }

exit;

# foreach $jn (keys %all_gv ){
#     my @tmp_gv = []; 
#     foreach $gv (@{ $all_gv{$jn} })
#          $list_gv2job{$gv} = $jn;
         
     
