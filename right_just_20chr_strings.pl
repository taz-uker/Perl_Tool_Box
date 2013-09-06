#!/usr/bin/perl
#
print "This program right justifies strings that are entered.\n";
print " The strings can not be longer than 20 characters.\n";
print "  Enter Cntl-D to stop entering input. \n\n";
#
# Variables used in this program
#
#
my @input_lines;
my $ruler; # ruller line

chomp(@input_lines = <STDIN>);

$ruler = "1234567890" x 7  ;
print $ruler, "\n\n";

printf "".("%21s\n" x @input_lines), @input_lines;  # prints the 20th column right justified.

print "This is right justifed at the 20th column\n\n";

print $ruler, "\n";

printf "".("\t\t\t%-5s\n" x @input_lines), @input_lines; # prints at the 25 column left justified.

print "This is left justified at the 25th column using tabs and an offset. \n";
