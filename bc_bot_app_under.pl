#!/usr/bin/perl
#
# This program will take the application field info and clean it up.  
# in autosys 4.5 jil
#
open(FILE, "/home/tpensel/r11.HC.jil.txt") or die "File can not be opened $!";
@asjilfile = <FILE>;
close (FILE);

foreach $line (@asjilfile) {
  if ($line =~ /application\:/ ) {
  	    ($line_tag, $app_data) = split (/\:/, $line);
    	$app_data =~ s/\"//g ; # removes double quotes 
    	$app_data =~ s/^\s*// ;  # strips leading spaces
    	$app_data =~ s/\s*$// ;  # string trailing spaces
    	$app_data =~ s/\s/_/g ; # replace spaces with underscores
    	$line =~ s/(application\:)(.*)/$1 $app_data/ ;
    }
}

print @asjilfile;