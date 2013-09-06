Comparing values in perl

This page shows different ways to compare scalar values in perl. String comparison and numeric comparison are done separately, with one operator for strings and another for numbers.
Comparing numbers

To compare numbers for equality in Perl, use the == operator:

    #!/usr/bin/perl
    use strict;
    use warnings;

    my $num1 = 3;
    my $num2 = 5;

    if ($num1 == $num2) {
        print "Equal\n";
    } else {
        print "Not equal\n";
    }

This example, of course, results in:

    Not equal

This numeric not-equal != operator allows you to test for inequality:

    #!/usr/bin/perl
    use strict;
    use warnings;

    my $num1 = 3;
    my $num2 = 5;

    if ($num1 != $num2) {
        print "Not Equal\n";
    } else {
        print "Equal\n";
    }

If you try to compare strings using ==, and you have included the use warnings pragma, you will get a warning, as in the example below. However, perl will still attempt to convert the string into a number. If the string starts with numbers, perl will use these, otherwise the string equates to 0.

    #!/usr/bin/perl
    use strict;
    use warnings;

    my $string1 = 'three';
    my $string2 = 'five';

    if ($string1 == $string2) {
        print "Equal\n";
    } else {
        print "Not equal\n";
    }

From the above example, you would get warning messages and both strings would evaluate to zero:

    Argument "five" isn't numeric in numeric eq (==) at ./test.pl line 8.
    Argument "three" isn't numeric in numeric eq (==) at ./test.pl line 8.
    Equal

Whereas, in the following example the string would equate to 12, although you'd still get a warning:

    #!/usr/bin/perl
    use strict;
    use warnings;

    my $string1 = '12aa';
    my $num2 = 12;

    if ($string1 == $num2) {
        print "Equal\n";
    } else {
        print "Not equal\n";
    }

Output:

    Argument "12aa" isn't numeric in numeric eq (==) at ./test.pl line 8.
    Equal

It is not recommended that you rely on perl evaluating a string containing numbers and letters as a number.

If you want to check if a number is less than or greater than another number, use the less/greater than (< and >) operators, or the less/greater than equals operators (<= and =>). The following example compares $num1 to different numbers using different operators:

    #!/usr/bin/perl
    use strict;
    use warnings;

    my $num1 = 4;

    if ($num1 < 1) {
        print "Less than one!\n";
    } elsif ($num1 <= 2) {
        print "Less than or equal to two!\n";
    } elsif ($num1 == 3) {
        print "Equals three\n";
    } elsif ($num1 > 5) {
        print "Greater than five!\n";
    } elsif ($num1 >= 4) {
        print "Greater than or equal to four!\n";
    }

    exit 0;

Comparing Strings

To compare two strings use the eq and ne operators. These work much the same as the == and != operators, but they expect the variables to be strings. Here is an example of the eq operator:

    #!/usr/bin/perl
    use strict;
    use warnings;

    my $string1 = 'three';
    my $string2 = 'five';

    if ($string1 eq $string2) {
        print "Equal\n";
    } else {
        print "Not equal\n";
    }

This would, of course, print:

    Not equal

A similar example but this time using the ne operator:

    #!/usr/bin/perl
    use strict;
    use warnings;

    my $string1 = 'three';
    my $string2 = 'five';

    if ($string1 ne $string2) {
        print "Not equal\n";
    } else {
        print "Equal\n";
    }

If you try to compare numbers with eq, they will be converted to strings:

    #!/usr/bin/perl
    use strict;
    use warnings;

    my $num = 4;
    my $num2 = 12;

    if ($num eq $num2) {
        print "Equal\n";
    } else {
        print "Not equal\n";
    }

The output of this program would be:

    Not equal

If you want to compare strings to determine which comes first alphabetically, you can use the lt and gt operators, or the le and ge operators for less/greater than equals comparisons. These will compare the strings alphabetically or 'stringwise'. The following example compares $string1 to different strings using the different methods:

    #!/usr/bin/perl
    use strict;
    use warnings;

    my $string1 = 'mouse';

    if ($string1 lt 'cat') {
        print "Before cat\n";
    } elsif ($string1 le 'dog') {
        print "Before or level with dog\n";
    } elsif ($string1 eq 'fish') {
        print "Level with fish!\n";
    } elsif ($string1 gt 'zebra') {
        print "Greater than zebra\n";
    } elsif ($string1 ge 'llama') {
        print "Greater than or level with llama\n";
    }

    exit 0;

Regular expressions

Much more powerful comparisons are possible using Perl's Regular Expressions, which allow you to compare some input with a pattern. For example, you may want to know if a string contains a number, or if it starts with a certain word.

Regular expressions are covered in great detail in perldoc perlre and perldoc perlretut, and also on this site at Regular Expressions. However, the following examples should give you a basic idea.

The first example checks that a string does not contain any numbers:

    #!/usr/bin/perl
    use strict;
    use warnings;

    my $string1 = 'Jimmy has 17 dollars and 20 cents saved up';

    if ($string1 !~ m/\d/) {
        print "Doesn't contain numbers\n";
    } else {
        print "Does contain numbers\n";
    }

    exit 0;

And the next example shows how to check if a string contains a phrase like: '4 dollars and 25 cents':

    #!/usr/bin/perl
    use strict;
    use warnings;

    my $string1 = 'Jimmy has 17 dollars and 20 cents saved up';

    if ($string1 =~
        m/                  # Match
        \d+                 # 1 or more digits
        \sdollars\sand\s    # ' dollars and '
        \d+                 # 1 or more digits
        \scents             # ' cents'
        /ix                 # i = Ignore case
                            # x = allow the regexp to go over multiple lines
        ) {
        print "Contains dollars and cents!\n";
    }

    exit 0;

Sorting comparisons

When defining your own sort function, you will need to use the comparison operators. There are two of these: cmp for strings and the spaceship operator <=> for numbers. See the sorting howto and the sorting tutorial.
See also

    perldoc perlop
    perldoc perlretut
    perldoc perlre
