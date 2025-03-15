use Test;

use Number :ALL;

plan 91;

# error conditions
dies-ok {
    rebase('Z', 20, 3);
}, "incorrect base number for input";

#for 1..61 -> $i {
for 1..90 -> $i {
    my $bi = 10;
    my $bo = $i+1;

    # use exact definitions of the decimal number in the desired output base
    # use @dec2digit
    my $tnum-in  = $i;
    my $tnum-out = @dec2digit[$i];

    die "FATAL: Output number is NOT a single char." if $tnum-out.chars != 1;

    my $res = rebase $tnum-in, $bi, $bo;
    is $res, $tnum-out;
}
