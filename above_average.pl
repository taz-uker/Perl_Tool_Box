#!/usr/bin/perl
#
# This program calculates the above average for a list of numbers
#
sub total {
	my $number;
	my $sum;
	foreach $number (@_) {
		$sum += $number; 
	}
  return $sum;	
}

sub above_average {
	my $count = scalar (@_);
    my $avg = (&total(@_) / $count); 
    my @above_mean;
    foreach $number (@_) {
    	if ($number > $avg) {
    		push(@above_mean, $number);
    	}
    }
    return @above_mean;
}

my @fred = above_average(1..10);
print "\@fred is @fred\n";
print "(Should be 6 7 8 9 10)\n";
my @barney = above_average(100, 1..10);
print "\@barney is @barney\n";
print "(Should be just 100)\n";
