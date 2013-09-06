#!/usr/bin/perl

# This program used subroutines to calculate a total of a list of numbers.
#
use 5.014;


sub total {
	my $number;
	my $sum;
	foreach $number (@_) {
		$sum += $number; 
	}
  return $sum;	
}

my @one2thousand = (1..1000);
my $addedup = &total(@one2thousand);
print "The sum of numbers from one to 1000 is $addedup\n";

# or

print "\nThe sum of numbers from one to 1000 is " , total(1..1000), ".\n";
