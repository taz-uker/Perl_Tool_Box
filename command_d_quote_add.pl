#!/usr/bin/perl
#
# This program will take the application field and clean it up.  
# in autosys 4.5 jil
#
open(FILE, "BLHC.jil.txt") or die "File can not be opened $!";
@asjilfile = <FILE>;
close (FILE);

for $line (@asjilfile) {
	if ($line =~ /command\:/) {
	  ($line_tag, $desc_data) = split(/\:/, $line);
	   unless ($desc_data =~ /\"$/) {
	   	chomp ($desc_data);
	  	$mod_desc_data =  $desc_data . "\"" ; # adds double quote to command line jil 
        $line =~ s/(command\:)(.*)/$1$mod_desc_data/ ;
	   }
	}
}

print @asjilfile;