#!/usr/bin/perl
#
# This program will find alll the global variables used in the HR, HC and cs jobs.
#

use 5.010;
use warnings;
use Data::Dumper

# Variable Table

my $workingfile_name;
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
my $cond;
my %all_gv;
my @all_gv_line;
my %list_gv2job;
my %as_gv;

 $workingfile_name = shift @ARGV;


open FILE, "$workingfile_name"
  or die "Problem accessing the $workingfile_name, specifically $!\n";
@workingfile = <FILE>;
close(FILE);

# Create a list of job names of AS jil

foreach $line (@workingfile) {
    if ( $line =~ /insert_job\:/ ) {
        $cnt++;
        print "\....\n" if ( $cnt % 500 == 0 ); # visual processing of load into job name array @all_jn
        ( $first_part, $second_part, $jt_field_val ) = split /\:/, $line;
        $second_part =~ s/^\s+//;    # strips leading spaces
        ( $jobname, $end_of_line ) = split /\s+/, $second_part;
        push @all_jn, $jobname;
    }
}

# build hash of global variables by jobname keys

foreach $line (@workingfile) {
    foreach $jn (@all_jn){
        if ($line =~ /insert_job\:/ && /$jn/) {
            $jobname = $jn; 
        }
        if ($line =~ /condition\:/) {  # updates command line and echo's out command 

           ($first_part, $conditions) = split(/\:/, $line);

           $conditions =~ s/^\s*// ;  # strips leading spaces 

           @all_conditions = split(/\&/, $conditions);
            
           @all_gv_line = [];

           foreach $cond (@all_conditions) {
                  $cond =~ s/^\s*//; # strips leading spaces 
                  push @all_gv_line, $cond if ($cond =~ /v\(/ or /value\(/); 
           }   
           $all_gv{$jobname} = \@all_gv_line;  
        } 
    }
}

# Translate routine from key/value pairs ($jobname/@all_gv_line) in %all_gv hash 
#  to a global variable/job name ($gv/@jobs) into the hash %list_gv2job  

foreach $jn (keys %all_gv ){
    my @tmp_gv = []; 
    foreach $gv (@{ $all_gv{$jn} })
         $list_gv2job{$gv} = $jn;
         

        


}


