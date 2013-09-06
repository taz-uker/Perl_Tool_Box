#!/usr/bin/perl
#
# This program will take the application field info and clean it up.  
# in autosys 4.5 jil

use 5.014; 

# Define Variables
#
my $workingfile;  # working file from first argument 
my $line;  # working line 
my @asjilfile = [];  # storage array
my $first_part;  # first part of line untouched 
my $job_type; # job type to be changed 
my $owner_name; # name of owner
my $machine_name; # name of machine
my $command_insr; # command line instruction
my $std_err; # standard error
my $std_out; # standard out 

$workingfile = shift @ARGV; # loads file name from first ARGV list 
open(FILE, "/home/pensel\.3/$workingfile") or die "$workingfile can not be opened, specifically $!";
@asjilfile = <FILE>;
close (FILE);

foreach $line (@asjilfile) {
   if ($line =~ /(job_type\: b)(\s*)$/) {    # changes b to box in job_type field
   
      ($first_part, $job_type) = split(/job_type\:/, $line); 
   
       $line = "$first_part " . "job_type\: box\n" ;
   } 
   if ($line =~ /(job_type\: c)(\s*)$/) {    # changes c to cmd in job_type field
   
      ($first_part, $job_type) = split(/job_type\:/, $line); 
   
       $line = "$first_part " . "job_type\: cmd\n" ;
   } 
   if ($line =~ /(\W*)(\#owner\: )(\w+)/) { # updates owner to autosys and adds group: CS

      ($first_part, $owner_name) = split(/\#owner/, $line); 

      $line = "$first_part" . "owner\: autosys\n" . "$first_part" . "group\: CS\n" ;
   }
   if ($line =~ /machine\:/) {  # updates machine to stsqltst01.it.ohio-state.edu

      ($first_part, $machine_name) = split(/machine\:/, $line);

      $line = "$first_part". "machine\: stsqltst01.it.ohio-state.edu\n";
   }
    if ($line =~ /command\:/) {  # updates command line and echo's out command 

      ($first_part, $command_insr) = split(/\:/, $line);

      $command_insr =~ s/^\s*// ;  # strips leading spaces 

      chomp($command_insr); # removes the newline

      $line = "$first_part" . "\: echo \"" . "$command_insr" . "\"\n";
   }
   if ($line =~ /std_out_file\:/) {  # updates std_out_file to /tmp/$AUTO_JOB_NAME.out.$$TDTE

      ($first_part, $std_out) = split(/\:/, $line);

      $line = "$first_part". "\: \/tmp\/\$AUTO_JOB_NAME.out.\$\$TDTE\n";
   }
   if ($line =~ /std_err_file\:/) {  # updates std_err_file to /tmp/$AUTO_JOB_NAME.err.$$TDTE

      ($first_part, $std_err) = split(/\:/, $line);

      $line = "$first_part". "\: \/tmp\/\$AUTO_JOB_NAME.err.\$\$TDTE\n";
   }
   if ($line =~ /profile\:/) { # removes profile line 
       $line = "";
   }

}
  
  # if ($line =~ /profile\:/ ) {
  # 	  $line =~ s/(profile\:)(.*)//;  # remove profile line 
  # }	  
   
  # if ($line =~ /application\:/ ) {
  # 	    ($line_tag, $app_data) = split (/\:/, $line);
  #   	$app_data =~ s/\"//g ; # removes double quotes 
  #   	$app_data =~ s/^\s*// ;  # strips leading spaces
  #   	$app_data =~ s/\s*$// ;  # string trailing spaces
  #   	$app_data =~ s/\s/_/g ; # replace spaces with underscores
  #   	$line =~ s/(application\:)(.*)/$1/ ;
  # }	


print @asjilfile;