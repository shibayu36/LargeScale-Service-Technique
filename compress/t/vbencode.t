package t::VBEncode;
use strict;
use warnings;

use VBEncode qw(vb_encode vb_decode);

use parent qw(Test::Class);
use Test::More;

sub _vb_encode : Test(3) {
    my $bytes;

    $bytes = vb_encode(1);
    is unpack("B*", $bytes), "10000001";

    $bytes = vb_encode(128);
    is unpack("B*", $bytes), "00000001" . "10000000";

    $bytes = vb_encode(255);
    is unpack("B*", $bytes), "00000001" . "11111111";
}

sub _vb_decode : Test(6) {
    is vb_decode(vb_encode(1))->[0], 1;
    is vb_decode(vb_encode(10))->[0], 10;
    is vb_decode(vb_encode(128))->[0], 128;
    is vb_decode(vb_encode(255))->[0], 255;

    my $nums = vb_encode(10) . vb_encode(255);
    my $decodes = vb_decode($nums);
    is $decodes->[0], 10;
    is $decodes->[1], 255;
}

__PACKAGE__->runtests;

1;
