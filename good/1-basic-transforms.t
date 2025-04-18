use Test;

use Number :ALL;
use Number::Subs :ALL;

my $debug = 0;

my $LC = True; # lower case

# a random set of decimal inputs
my $nrands = 10; # num loops
my $ntests = 18; # per loop
my $total-tests = $nrands * $ntests;
my @uints = ((rand * 10000).Int) xx $nrands;
for @uints -> $dec {
    my $bin  = $dec.base: 2;
    my $oct  = $dec.base: 8;
    my $hex  = $dec.base: 16; # alpha chars are upper case
    my $hex2 = lc $hex;       # a lower-case version

    # the N tests
    is bin2bin($bin), $bin;
    is bin2oct($bin), $oct;
    is bin2dec($bin), $dec;
    is bin2hex($bin), $hex;
    is bin2hex($bin, :$LC), $hex2;

    is oct2bin($oct), $bin;
    is oct2oct($oct), $oct;
    is oct2dec($oct), $dec;
    is oct2hex($oct), $hex;
    is oct2hex($oct, :$LC), $hex2;

    is dec2bin($dec), $bin;
    is dec2oct($dec), $oct;
    is dec2dec($dec), $dec;
    is dec2hex($dec), $hex;
    is dec2hex($dec, :$LC), $hex2;

    is hex2bin($hex), $bin;
    is hex2oct($hex), $oct;
    is hex2dec($hex), $dec;
    is hex2hex($hex), $hex;
    is hex2hex($hex, :$LC), $hex2;
}

done-testing;
