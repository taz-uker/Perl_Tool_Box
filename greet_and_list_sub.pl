#!/usr/bin/perl
#
# This program greets with the last person greeted.
# This program uses state to create the variable $last person without defining it.
#

use 5.014;


sub greet {
    state @names; 
       # print "\@names @names\n";
       # print "LENGTH of NAMES ARRAY ", length(@name), "\n";  # works for strings only 
       # print "Length of NAMES minus one ", $#names, "\n"; # add one for length of array 
       # IMPORTANT in PERL use scalar to determine the length of an array. IMPORTANT
    my $name = shift;
    $name = ucfirst($name); # capitalizes the $name 
        if ( scalar(@names) == 0 ) {
           print "\nHello, $name! You are the first person here!\n\n";
        } elsif ( scalar(@names) == 1 ) {    
         print "Hello, $name!  Come on in! Glad to you made it $name! \n @names is already here!   \n";
         print "And he wants to meet you!!!\n\n";
        } else {
           print "Hello, $name!  Come on in! Glad to you made it $name! \n @names are already here!   \n";
         print "And they want to meet you!!!\n\n";
        }   

        # if ($#names == -1) {
        #    print "\nHello, $name! You are the first person here!\n\n";
        # } elsif ( $#names == 0) {    
    	   # print "Hello, $name!  Come on in! Glad to you made it $name! \n @names is already here!   \n";
    	   # print "And he wants to meet you!!!\n\n";
        # } else {
       	#    print "Hello, $name!  Come on in! Glad to you made it $name! \n @names are already here!   \n";
    	   # print "And they want to meet you!!!\n\n";
        # }     	
    push(@names, $name);
}

greet('fred');
greet('tom');
greet('george');
greet('rosie');
greet('sal');
greet('tara');