#!/usr/bin/perl

use 5.010;
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
my @adj_file;            # adj AS JIL file 
my $first_part;          # split values for job name 
my $second_part;         # middle part that has job name 
my $jt_field_val;        # stuff declared but not needed
my $end_of_line;         # stuff declared but not needed
my @all_jn;  # all jobnames from loaded AS JIL file
my $jobname;  # job name
my %as_jil;  # resulting overall hash for sorting jil
my $jn;  # another job name 
my $value;  # JIL for each corresponding job name $jn
my $cnt = 0; # counter of processing indicator

# Start of Main Program

$workingfile_name = shift @ARGV;

open FILE, "$workingfile_name"
  or die "Problem accessing the $workingfile_name, specifically $!\n";
@workingfile = <FILE>;
close(FILE);

 foreach $line (@workingfile) {
	  $line =~ s/^\s*// ; # remove leading spaces    
    if ( $line =~ m/.*?(\/\*).*?(([a-z][a-z]+)).*?(\*\/)(.)/is ) {
        $line = "" ; # removes comment line for easier processing will add back in.
    }
 }
 # extracts range of lines between insert_job: and a blank line 
 @adj_file = grep(/insert_job\:/ .. /^$/, @workingfile) ; 

# builds array of jobnames called @all_jn

print "Building the job name list ... ";

 foreach $line (@adj_file) {
   if ($line =~ /insert_job\:/ ) {
      $cnt++;
      print "\....\n" if ($cnt % 1500 == 0);  # visual processing of load into job name array @all_jn        
      ($first_part, $second_part, $jt_field_val) = split /\:/, $line;
      $second_part =~ s/^\s+// ; # strips leading spaces 
      ($jobname, $end_of_line) = split /\s+/, $second_part; 
      push @all_jn, $jobname; 
   }
 }

# print "ARRAY \@all_jn\n";
#   foreach $line (@all_jn) {
#    print "$line\n";
#  }  


# print "ADJ FILE \n";

# print "@adj_file\n";

# puts AS JIL into a %as_jil hash 


print "Loading into hash ...";

foreach $line (@adj_file) {

  $line =~ s/^\s*// ;  # remove leading space on each line 

  if ( $line =~ /insert_job/) {
      $jn = shift @all_jn; 
      if ($line =~ /$jn/) {
          $cnt++;
          print "\....\n" if ($cnt % 1500 == 0); # visual processing of load into hash
         push @{ $as_jil{$jn} }, $line unless defined $as_jil{$jn} ;
         next;               
      }
  }    
  elsif ($line =~ /\:/ or $line =~ /^$/) {
    die 'No jobname yet' unless defined $jn;
    push @{ $as_jil{$jn} }, $line ;
  }
  else {
    print "LINE $line\n ";
    die "I don't understand: $line ";
  }
}

# print "Print \%as_jil hash \n";

#  while ( ($key, $value) = each %as_jil ) {
     
#      printf "\nJOB NAME\:  %s\n\n", "$key";
#      foreach my $fn (@$value) {
#        print "\t$fn";
#      }  
#  }
 
 # foreach $jobname (keys %as_jil) {
 #        print "\n";
 #    foreach my $key (@{ $jobname }) {
 #        print "$key\n";
 #    } 
 # } 

# Enter in parameters to look for. 

# Variable TABLE:  Search Section

my $input_fn ; 
my @jobs_w_match;
my $search_str;
my @test; 
my @total; 
my $dummy;

NEW_SEARCH:


print "\n\n Enter the field that you want to search on.\n";
print  "      Note: Other than _ \(underscores\), do NOT enter\n"; 
print  "            any special characters\, \: \:\,\%\, etc\.\n";
print  "\n          Example:  owner\n...> ";
$input_fn = <STDIN> ;
chomp $input_fn; 
print "\n\n Enter the search_string for the $input_fn field.\n";
print "       Note: You need to preceed (escape) special characters with\n"; 
print "             a \(backslash\) \\ \n";
print "                  Example for \"\/tmp\/var\/log\" would be entered as\: \n";
print "                       \.\.\.\.\> \\\/tmp\\\/var\\\/log \n .....\> ";
$search_str = <STDIN> ;
chomp $search_str; 

print "\n\nYou are searching for the string \"$search_str\" in the Autosys jil \n";
print "\" $input_fn \" field from the AS jil file. \n\n";



# print Dumper (%as_jil);

foreach $jn (keys %as_jil) {
      @test = grep { /$input_fn/ && /$search_str/ } @{ $as_jil{$jn} } ;
      push @jobs_w_match, $jn if (scalar @test > 0);
      push @total, @test;
}

# print "Enter the output file you will be using\n";
# print Dumper(%as_jil);
print "JOB W MATCH\n";

foreach $jn (@jobs_w_match) {
    print "$jn \n";
} 

# print "FULL LINES THAT MATCHED\n\n @total\n";    
print "\n\nTotal number of jobs that match\: \n\t";
print scalar(@jobs_w_match),  "\n";

MENU_START:
# Menu

say "\n\t\t\tAutosys JIL Extractor ";
say "\n";
say "\tThe SEARCH STRING was \"$search_str\" in the AS field \"$input_fn\".";
say "\nSelect an option below:\n";
say "\ta\) View jobs names selected with search string.";
say "\tb\) View lines that match the search string.";
say "\tc\) Generate JIL file of selected jobs.";
say "\td\) Start over \& enter new search criteria.";
say "\te\) Exit";

print "\n---> "; # prompt

my $option = <STDIN> ;

say "$option";

given ($option) {
  when (/a/) { goto VIEW_LINES ;}
  when (/b/) { goto VIEW_JOBS ;}
  when (/c/) { goto OUTPUT_JIL_FILE_OPTION ;} 
  when (/d/) { goto NEW_SEARCH ;}
  when (/e/) { exit;}
  default { print "You entered an invalid option. Please try again.\n";
            print "\t Hit \<ENTER\> to continue.\n"; 
            $dummy = <STDIN>;
            goto MENU_START ;
          }
}


# option c

OUTPUT_JIL_FILE_OPTION:

system("clear");

say "Creating the custom AS jil file.\n";

say "\tThe SEARCH STRING was \"$search_str\" in the AS field \"$input_fn\".";

print "\nEnter the name of the output file you want the file to be \n";
print "\tPlease use a *.jil extension for your output file.\n";
print "\n\n Enter the file name. \n     --->";

my $output_file = <STDIN>;
chomp $output_file;

if ( -e $output_file ) {
  print "ERROR\: File name is already in use.  Please select another file name for the jil output file.\n";
  print "\n\t Hit \<Enter\> to continue.\n";
  $dummy = <STDIN>;
  goto OUTPUT_JIL_FILE_OPTION ;
}

open(OUT, ">$output_file") or die "File is not able to be created: $!";

foreach $jn (@jobs_w_match) {
  print OUT "\n" unless ($jn eq $jobs_w_match[0]);  
  print OUT "\/\* \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- $jn \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- \*\/\n";
  print OUT "\n";
  foreach $line (@{ $as_jil{$jn} }) {
      print OUT "$line";
  }  
}



exit

