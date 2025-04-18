use Test;

use Number :ALL;
use Number::Vars;

plan 81;

# testing single chars only
my $prefix = True;
my $LC     = True;

my $base;
my $last-base = 36;

# special cases
$base = 10;
for 10..36 -> $dec {
    ++$base;
    last if $base > $last-base;

    my $digit-idx = $base - 1; # index into @dec2digit

    my $bo = $base;
    my $bi = 10;

    # use exact definitions of the decimal number in the desired output base
    # use @dec2digit
    my $tnum-in  = $dec;
    my $tnum-out = @dec2digit[$digit-idx];

    die "FATAL: Output number is NOT a single char." if $tnum-out.chars != 1;

    if $bo eq '16' {
        my $out = '0x' ~ $tnum-out;
        is rebase($tnum-in, $bi, $bo, :$prefix), $out;
        $out = '0x' ~ lc $tnum-out;
        is rebase($tnum-in, $bi, $bo, :$prefix, :$LC), $out;
        $out = lc $tnum-out;
        is rebase($tnum-in, $bi, $bo, :$LC), $out;
    }

    if 10 < $bo < 37 {
        # bases 11 through 36 are NOT case sensitive
        my $out = $tnum-out;
        is rebase($tnum-in, $bi, $bo), $out;
        $out .= lc;
        is rebase($tnum-in, $bi, $bo, :$LC), $out;
    }
}

# default
$base = 10;
for 10..36 -> $dec {
    ++$base;
    last if $base > $last-base;

    my $digit-idx = $base - 1; # index into @dec2digit

    my $bo = $base;
    my $bi = 10;

    # use exact definitions of the decimal number in the desired output base
    # use @dec2digit
    my $tnum-in  = $dec;
    my $tnum-out = @dec2digit[$digit-idx];

    die "FATAL: Output number is NOT a single char." if $tnum-out.chars != 1;

    # default case
    is rebase($tnum-in, $bi, $bo), $tnum-out;
}
