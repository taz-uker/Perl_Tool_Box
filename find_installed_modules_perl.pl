#!//usr/local/ActivePerl-5.16/bin/perl

# This program show a list of installed modules in perl

use 5.014;
use Module::Corelist;


my %modules = %{ $Module::CoreList::version{5.014} };

foreach my $key ( sort keys %modules) {
	print "$key => $modules{$key} \n";
}