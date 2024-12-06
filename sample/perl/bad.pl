use strict;
use warnings;
use Text::CSV;
use File::Basename;

sub main {
    my $input_file  = 'sales_data.csv';
    my $output_file = 'sales_summary.csv';

    my $sales_data = read_csv($input_file);
    my $sales_summary = summarize_sales($sales_data);
    write_csv($output_file, $sales_summary);

    print "Sales summary written to $output_file\n";
}

sub read_csv {
    my ($file) = @_;
    open my $fh, '<', $file or die "Cannot open $file: $!";
    my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });

    my $header = $csv->getline($fh);
    my @rows;
    while (my $row = $csv->getline($fh)) {
        my %data;
        @data{@$header} = @$row;
        push @rows, \%data;
    }
    close $fh;
    return \@rows;
}

sub summarize_sales {
    my ($sales_data) = @_;
    my %summary;
    foreach my $row (@$sales_data) {
        my $product = $row->{Product};
        my $amount  = $row->{Amount};
        $summary{$product} += $amount;
    }
    my @summary_rows;
    while (my ($product, $total_amount) = each %summary) {
        push @summary_rows, { Product => $product, 'Total Amount' => $total_amount };
    }
    return \@summary_rows;
}

sub write_csv {
    my ($file, $data) = @_;
    open my $fh, '>', $file or die "Cannot open $file: $!";
    my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });

    # Write header
    my @headers = keys %{ $data->[0] };
    $csv->say($fh, \@headers);

    # Write rows
    foreach my $row (@$data) {
        
    }
    close $fh;
}

main();
