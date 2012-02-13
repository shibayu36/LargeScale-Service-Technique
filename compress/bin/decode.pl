use strict;
use warnings;

use Path::Class;
use VBEncode qw(vb_decode);

my $fh = file(__FILE__)->dir->file('../data/encode.txt')->openr;

while (1) {
    $fh->read(my $buff, 8) or last;
    my ($len_t, $len_v) = unpack('N2', $buff);
    $fh->read(my $tagname, $len_t);
    $fh->read(my $v, $len_v);

    my $tagrels = vb_decode($v);
    my $tagrel_count = scalar @$tagrels;
    for my $count (1..$tagrel_count - 1) {
        $tagrels->[$count] += $tagrels->[$count - 1];
    }
    print($tagname, "\t", join(',', @$tagrels), "\n");
}


