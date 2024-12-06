# Assisted by watsonx Code Assistant 
# watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
 

sub bubblesort {
    my @array = @_;
    my $length = @array;
    for (my $i = 0; $i < $length; $i++) {
        for (my $j = 0; $j < $length - $i - 1; $j++) {
            if ($array[$j] > $array[$j + 1]) {
                my $temp = $array[$j];
                $array[$j] = $array[$j + 1];
                $array[$j + 1] = $temp;
            }
        }
    }
    return @array;
}

print "Enter the array elements: ";
my @array = <STDIN>;
chomp(@array);

@array = bubblesort(@array);

print "Sorted array: ";
print "@array\n";