package Calculator;

sub new {
    my $class = shift;
    my $self = {
        value => 0,
    };
    bless $self, $class;
    return $self;
}

sub add {
    my ($self, $num) = @_;
    $self->{value} += $num;
}

sub subtract {
    my ($self, $num) = @_;
    $self->{value} -= $num;
}

sub get_value {
    my $self = shift;
    return $self->{value};
}

1; 

use strict;
use warnings;

my $calc = Calculator->new();

$calc->add(10);
$calc->subtract(4);

print "Final value: ", $calc->get_value(), "\n";
