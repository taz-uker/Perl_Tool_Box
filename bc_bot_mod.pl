#!/usr/bin/perl
#
# This program will take the description field info and populate the application: field 
# in autosys 4.5 jil
#
open(FILE, "/home/tpensel/hc_bot2.txt.txt") or die "File can not be opened $!";
@asjilfile = <FILE>;
close (FILE);

for $line (@asjilfile) {
	if ($line =~ /description\:/) {
	  ($line_tag, $descrip_data) = split(/\:/, $line);
	}
    if ($line =~ /application\:/ ) {
      $mod_desc_data = substr($descrip_data, 0, 32);
	  $line =~ s/(application\:)(.*)/$1 $mod_desc_data/ ;
	}
}

print @asjilfile;