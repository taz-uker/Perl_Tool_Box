#!//usr/local/ActivePerl-5.16/bin/perl

# This program shows how to use the DateTime module for Perl off of CPAN.

# The date of origin is entered as command ling arguements
#  as YYYY MM DD
# Example
# Apr 4 1987 would be entered as 
# ./caluculate_date_time_from_date.pl 1987 04 18

use 5.014;
use DateTime;
use strict;
use warnings;


my @dt = split( /\s+/ , `date "+%Y %m %d"`);
print "DT value @dt";

my $now = DateTime->new(
year => $dt[0],
month => $dt[1],
day => $dt[2],
);
print "Answer: "; 

my $then = DateTime->new(
year => $ARGV[0],
month => $ARGV[1],
day => $ARGV[2],
);
my $duration = $now - $then;
my @units = $duration->in_units( qw(years months days) );
printf "%d years, %d months, and %d days\n", @units;