use Test;

use Number :ALL;

my $debug = 0;

# Tests code described in the docs

#=============================================
# conversion using Raku core routines:
=begin code
use Number :ALL;
my $bin = '-1100.1011';   # do not enter any prefix
my $dec = $bin.parse-base: 2;
say $dec; # OUTPUT:
my $hex = $dec.base: 16;
say $hex; # OUTPUT: '-C.B'
=end code

{
use Number :ALL;
my $bin = '-1100.1011';   # do not enter any prefix
my $dec = $bin.parse-base: 2;
say $dec; # OUTPUT:
my $hex = $dec.base: 16;
say $hex; # OUTPUT: '-C.B'
is $hex, '-C.B';
}

#=============================================
# conversion using this module's core routines:
=begin code
my $bin = '-1100.1011';
my $hex = bin2hex $bin;
say $hex; # OUTPUT '-C.B'
=end code

{
my $bin = '-1100.1011';
my $hex = bin2hex $bin;
say $hex; # OUTPUT '-C.B'
is $hex, '-C.B';
}

done-testing;

