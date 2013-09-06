#!/usr/bin/perl
#
# This program greets with the last person greeted.
# This program uses state to create the variable $last person without defining it.
#

use 5.014;


sub greet {
    state $last_person; 
    my $name = shift;
    $name = ucfirst($name); # capitalizes the $name 

       if (defined $last_person) {
    	print "Hello, $name!  $last_person just came in before you! \n";
     } else {
     	print "Hello, $name! You are the first person here!\n";
     }	
    $last_person = $name;
}

greet('fred');
greet('tom');
greet('george');