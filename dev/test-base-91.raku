#!/usr/bin/env raku

use lib <../lib>;

use Number :dec2digit, :base, :digit2dec; # :ALL;

{
my $n = '12345';
my $o = str2num($n, 10);
say "in: $n";
say "out: $o";
exit;
}

my $debug = 0;
my $DEBUG = 0;

say "======================================";
my $hex = "ffffffffffffffffffffffffffffffff";
my $n1 = $hex.chars;
my $dec = str2num($hex, 16);
say "dec = $dec";

my $res = num2str($dec, 91);
my $n2 = $res.chars;
say "  input:  '$hex' (base: 16); num chars = $n1";
say "  output: '$res' (base: 91); num chars = $n2";

# try to round trip
$dec = str2num($res, 91);
say "  input:  '$res' (base: 91); num chars = $n2";

$res = num2str $dec, 16;
$n2 = $res.chars;
say "  output: '$res' (base: 16); num chars = $n2";

# basic test from Wolfram:

my @ans = <1010 101 22 20 14 13 12 11 10 A>;
my $deci = 10;
my @bas = 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 91;
for @bas -> $b {
    my $ans = num2str $deci, $b;
    say "10 in base $b : $ans";
}

#my @ans = <1010 101 22 20 14 13 12 11 10 A>;
#my $deci = 10;
@bas = 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 91;
for @bas -> $b {
    my $int  = floor $b;
    my $frac = 0.1;

    my ($ans1, $ans2) = num2str $deci, $b, $frac;
    say "10.1 in base $b : '$ans1'.'$ans2'";
}

$deci = 14; #14.3;
my ($ans1, $ans2) = num2str $deci, 3, 0.3;
say "14.3 in base 3 : '$ans1'.'$ans2'";

exit;

# below is a series of conversion tests just to exercise
# the base conversion range

# a test set of numbers and bases
my $nums    = 101; # nums to choose
my $ndigits = 91;   # num digits per number

my @b = 2..91; # 91 # set of allowable bases
my @p = @b; # need an array to pick from since @b is used in a loop
for 1..$nums -> $i {
    # pick digits at random
    my @d = pick $ndigits, @dec2digit;
    my $num-i = join '', @d;
    say "== number $i: $num-i";

    # pick each valid base
    for @b -> UInt $base-i {
       next if $num-i !~~ @base[$base-i];
       # pick an output base
       my $base-o = @p.pick.UInt;
       while $base-o == $base-i {
           $base-o = @p.pick.UInt;
       }

       note "  base-i: $base-i; base-o: $base-o" if $debug;

       # need decimal intermediary
       my $dec = str2num($num-i, $base-i);
       #note "dec = $dec";
       my $res = num2str($dec, $base-o);

       if 1 || $debug {
           note "DEBUG:  input:  '$num-i' (base: $base-i)";
           note "        output: '$res'   (base: $base-o)";
       }
    }
}

#===============================================================================
# SUBROUTINES
#===============================================================================

# was _to-dec-from-b37-b91
# Extends routine 'parse-base' to base 91 for unsigned integers.
# Converts a string with a base (radix) of $base to its Numeric
# (decimal) equivalent.
sub str2num(Str:D $num is copy,
            UInt $base where 2..91
            --> Numeric) is export(:str2num) {

    # adjust for Raku's convention
    if $base < 37 {
        $num .= uc;
    }

    my @num'r = $num.comb;
    my $place = $num.chars - 1;

    my UInt $dec = 0;
    for @num'r -> $digit {
	# need to convert the digit to dec first
	die "FATAL: \$place is negative!" if $place < 0;
	my $digit-val = %digit2dec{$digit};
	my $val = $digit-val * $base ** $place;
	$dec += $val;
	--$place; # first place is num chars - 1
    }

    if $DEBUG {
        note qq:to/HERE/;
        DEBUG: sub _to_dec_from_baseN
               input \$num      = '{$num}'
               input \$base     = '$base';
               calculated \$dec = '$dec';
        HERE
    }
    $dec;
} # str2num

# this version looks excellent for the integer part!
multi sub num2str(UInt:D $dec, UInt:D $base --> Str) {
    my $int = '';
    my $rem = $dec;
    loop {
        my $di  = $rem mod $base; # $di is an index into the base's alphabet
        $rem = $rem div $base;
        $int = @dec2digit[$di] ~ $int;
        last if !$rem;
    }
    $int;
}

multi sub num2str(Numeric:D $dec where {$_ >= 0},
                  UInt:D $base where 2..90, # we use the '.' as the radix point
                  :$ndigits = 10, #= number of desired fractional digits
                  --> Str) {
    # separate into integer and fractional parts

    # convert integer part

    # convert fractional part

    # combine parts
}

# looking good! modify to take positive real number or unsigned int
# then look at negative numbers
multi sub num2str(UInt:D $dec,
                  UInt:D $base,
                  Numeric:D $Frac where {0 < $_ < 1},
                  :$ndigits = 10, #= number of desired fractional digits
                  --> List) {
    my $di; #= digit index
    my $int  = num2str $dec, $base;

    my $m'n  = $Frac;
    my $frac = '';
    my $n = $ndigits;
    loop {
        $m'n *= $base;
        my $m = floor $m'n;
        --$n;
        $frac ~= @dec2digit[$m];
        last if !$m'n;
        last if !$n;

        $m'n -= $m;
    }
    ($int, $frac);
}
