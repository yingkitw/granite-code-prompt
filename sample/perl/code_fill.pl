#!/usr/bin/perl
use strict;
use warnings;

# Define basic math functions
sub add {
    my ($a, $b) = @_;
    return $a + $b; 
}

sub subtract {
    my ($a, $b) = @_;
    return $a - $b;
}

sub multiply {
    
}

sub divide {
    my ($a, $b) = @_;
    if ($b == 0) {
        die "Error: Division by zero is not allowed.\n";
    }
    return $a / $b;
}

# Test the math functions
print "Addition (5 + 3): ", add(5, 3), "\n";
print "Subtraction (5 - 3): ", subtract(5, 3), "\n";
print "Multiplication (5 * 3): ", multiply(5, 3), "\n";
print "Division (5 / 3): ", divide(5, 3), "\n";
