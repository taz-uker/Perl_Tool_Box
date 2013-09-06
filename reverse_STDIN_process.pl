#!/usr/bin/perl
#
# This program will print a bunch of word in reverse order. 
#
use 5.014;
use strict;


my $line;

print "This will take a bunch of words and print them in reverse order. \n";
print "\n Hit Control-D to end input.\n";

my @lines = split(/\s+/, <STDIN>);
my @rev_lines = reverse(@lines);

print "\nWords printed in reverse order.\n";
for $line (@rev_lines) {
  print "$line\n";
}







# print reverse<STDIN>;



#print "@input_words";
#@rev_words = reverse(@input_words);
#print @rev_words ;
