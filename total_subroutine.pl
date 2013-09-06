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
my @fred = qw{ 1 3 5 7 9 };
print "@fred\n";
my $fred_total = &total(@fred);
print "The total of \@fred is $fred_total.\n";
print "Enter some numbers on separate lines: ";
my $user_total = &total(<STDIN>);
print "The total of those numbers is $user_total.\n";