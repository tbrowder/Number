unit module Number::Knuth;

use Number::Subs;
use Number::Vars;

sub knuth-rebase(
    :$num-i is copy, # to handle fractions and leading signs
    :$base-i where ( 2 <= $base-i <= 91 ),
    :$base-o where ( 2 <= $base-o <= 91 ),
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :lc($LC) is copy,
    :$debug,
    ) is export {

    my UInt $len = $num-i.chars; # includes any radix point or sign

#   # We need the digit sets for the two bases
#   my @db-i = @dec2digit[0..^$base-i];
#   my @db-o = @dec2digit[0..^$base-o];

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # consider any sign and keep it separate for now
    my $sign = "";
    if $num-i ~~ /^ (<[+-]>)? (.+) / {
        $sign  = ~$0 if $0.defined;
        $num-i = ~$1;
    }

    # Allow for fractional parts
    my $frac-i = 0;
    my $frac-o;
    if $num-i.contains: radix-point {
        die "FATAL: real handling not ready yet";
        ($num-i, $frac-i) = $num-i.split: radix-point;
        # illegal to have an ending radix-point
        # a following digit
        unless $frac-i {
            die qq:to/HERE/;
            FATAL: Numbers must have at least one digit
                   following a radix point.
            HERE
        }
        # treat the fractional part separately
        $frac-o = w-frac-rebase :$frac-i, :$base-i, :$base-o;
    }
    # $num-i is now the integral part

    # trim leading zeroes
    $num-i ~~ s:i/^0+/0/;

    # zero takes special handling
    if $num-i == 0 {
        # temporary "fix"
        return 0;
    }

    # trim any remaining leading zeroes
    $num-i ~~ s:i/^0+//;

    # see Wolfram's solution (article Base, see notes above)
    # check validity of chars for the incoming set:
    valid-base-set $num-i, :base($base-i);

    # get the indices for the incoming char set
    my @ci = IntegerDigits $num-i, :base($base-i);

    # need ln_b x = ln x / ln b
    # but it's defined in @r as @r
    # note Raku routine 'log' is math function 'ln' if no optional base
    # arg is entered

    # get place index of first digit
    my $n = @ci.head; # floor $log_b'x;

    # now the algorithm
    # we need @r below to be a fixed array of size $N + 2
    # where $N is the number of chars in the integer
    my $N = $num-i.chars;
    my @r[$N + 2];
    my @a[$N + 1];
    # set the first values by definition
    @r[$N] = $n;
    @a[$N] = floor ($base-o ** $n);

    # work through the $num-i.chars places (positions, indices)
    my @i = (0..$N).reverse;
    # $i..0 [. -1..-NF ]
    for @i[$N-1..0] -> $i { # <= Wolfram text is confusing here
	my $bi = $base-o ** $i;
        @r[$i] = @r[$i+1] - @a[$+1] * $base-o ** $i+1;
	@a[$i] = floor (@r[$i] / $bi);

        say "  i = $i; a = '@a[$i]'; r = '@r[$i]'" if 1 or $debug;
    }

    # @a now contains the indices of the digits of the number in the new base
    my $num-o = '';
    for @a -> $di {
        my $digit = @dec2digit[$di];
        $num-o ~= $digit;
    }

    # trim leading zeroes
    $num-o ~~ s/^ 0+ //;
    #$num-o ~~ s:i/^ 0 (<[0..9a..z]>) /$0/;

    if $frac-o {
        # not so fast! take care of the fractional part
        # reassemble the number's parts
        $num-o ~= '.' ~ $frac-o;
    }

    if $sign {
        $num-o = $sign ~ $num-o;
    }

    $num-o
} # knuth-rebase

#====================================
sub m1a( # Knuth, Method 1a, p. 319
    $num-i,
    :$base-i where ( 2 <= $base-i <= 91 ),
    :$base-p where ( 2 <= $base-i <= 91 ),
    :$debug,
) is export {
    # Division by B using radix-b arithmetic
    =begin comment
    Given an integer u, we can obtain its radix-B repr
    (U2U1U0 as follows:
    U0 = u mod B, U1 = floor (u/B) mod B, U2 = floor ( floor (u/B )/B) mod B...
    ... stopping when last char gives 0 

    Note u 
    =end comment
    my @u = $num-i.comb;
    for @u -> $

} # m1a

sub m1b( # Knuth, Method 1b, p. 319
) is export {
    # Multiplication by b using radix-B arithmetic
} # m1b

sub m2a( # Knuth, Method 2a, p. 319
) is export {
    # Multiplication by B using radix-B arithmetic
} # m2a

sub m2b( # Knuth, Method 2b, p. 320
) is export {
    # Division by b using radix-B arithmetic
} # m2b

