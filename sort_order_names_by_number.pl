#!/usr/bin/perl
#
# This program will print a order of names given a list of number.
#
use 5.012; 
use strict;

my $number;
my @numbers;
my @unsorted_names;
my @sorted_names;
my $dummy; 
my @good_numbers;

system("clear"); 
my @names = qw/ Zak Roy Amy Jim Cory Fred JimmyD/;
print "\n This is a list of names.\n\n";
print "@names\n\n";
print "Select the names from 1 to 7 that you want to see printed and sorted.\n";
print " 1 for Zak, 2 for Roy, etc. \n\n";
print "\n Example: \n";
print "\t3 7 <Enter>\n";
print "\t yields Amy JimmyD\n\n";

@numbers = split(/\s+/, <STDIN>);

for $number (@numbers) {
    if ($number =~ /[a-zA-Z]+/) {
    	print "\" $number \" is not a number. This will be ignored.\n";
        print "Hit <Enter> to continue\n";
    	read(STDIN, $dummy, 1);
        next;
     }   
    if ($number > 7 or $number < 0 ) {
    	print "Your number was $number This number will be ignored.\n";
    	print "Number must between 0 and 8\n";
    	print "Hit <Enter> to continue\n";
    	read(STDIN, $dummy, 1);
    	next;  
    }
    push(@good_numbers, $number);
}    
 

foreach (@good_numbers) {
	push(@unsorted_names, @names[$_ - 1]);
}
@sorted_names = sort @unsorted_names;
print "@sorted_names\n";

