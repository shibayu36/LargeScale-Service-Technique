use strict;
use warnings;

use Path::Class;
use VBEncode qw(vb_encode);

my $fh  = file(__FILE__)->dir->file('../data/plain.txt')->openr;
my $fhw = file(__FILE__)->dir->file('../data/encode.txt')->openw;

while (my $line = <$fh>) {
    my ($name, $tagline) = split("\t", $line);
    my @tagrels = split(",", $tagline);

    my $encoded = "";
    my $prev = 0;
    for my $tagrel (@tagrels) {
        my $gap = $tagrel - $prev;
        $encoded .= vb_encode($gap);
        $prev = $tagrel
    }

    print $fhw pack('N2', length $name, length $encoded), $name, $encoded;
}


