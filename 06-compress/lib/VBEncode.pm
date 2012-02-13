package VBEncode;
use strict;
use warnings;

use Readonly;
Readonly my $CALCUNIT => 128;

use Exporter::Lite;
our @EXPORT_OK = qw(vb_encode vb_decode);

sub vb_encode {
    my ($n) = @_;
    my $bytes = [];

    while (1) {
        unshift @$bytes, $n % $CALCUNIT;
        last if $n < $CALCUNIT;
        $n = int($n / $CALCUNIT);
    }

    $bytes->[-1] += $CALCUNIT;

    return pack("C*", @$bytes);
}

sub vb_decode {
    my ($binary) = @_;
    my @bytes = unpack("C*", $binary);

    my @nums;
    my $n = 0;
    for my $byte (@bytes) {
        $n = $CALCUNIT * $n + $byte;
        if ($byte >= $CALCUNIT) {
            $n -= $CALCUNIT;
            push @nums, $n;
            $n = 0;
        }
    }

    return wantarray ? @nums : \@nums;
}

1;
