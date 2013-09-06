#!//usr/local/ActivePerl-5.16/bin/perl
#
# This program will ask for a first name and return the last name or family name
#
use 5.014;
use strict;
use warnings;

my $name;


my %family = qw{
	fred flintstone 
	barney rubble
	wilma flintstone
	terry pensel
};


do {
	
	system("clear");
	print "Enter the first name of the person you would like to know about. Hit \<Enter\> complete entry. \n";
	
	print "\n Hit Ctrl-C to end program.\n";

	$name = <STDIN>;
	chomp $name;

	if (exists $family{$name}) {
		print "\n$name belongs to the $family{$name} family.\n\n";
	}
	else {
		print "\n This name\, $name\, is not listed in our database. Sorry. \n\n";
	}
	print "Hit \<Enter\> to continue.\n";
	my $dummy = <STDIN>;
} until ( $name eq 1);