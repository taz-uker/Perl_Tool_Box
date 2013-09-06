#!/usr/local/ActivePerl-5.16/bin/perl
#
# This program will display the %ENV hash.
#
use 5.014;
use strict;
use warnings;

my $longest = 0;
foreach my $key ( keys %ENV ) {
my $key_length = length( $key );
$longest = $key_length if $key_length > $longest;
}
foreach my $key ( sort keys %ENV ) {
printf "%-${longest}s %s\n", $key, $ENV{$key};
}