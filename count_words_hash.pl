#!//usr/local/ActivePerl-5.16/bin/perl
#
# This program will count the number of words you entered.
#
use 5.014;
use strict;
use warnings;


my(@words, %count, $word); # (optionally) declare our variables
chomp(@words = <STDIN>);
foreach $word (@words) {
$count{$word} += 1; # or $count{$word} = $count{$word} + 1;
}
foreach $word (keys %count) { # or sort keys %count
print "$word was seen $count{$word} times.\n";
}