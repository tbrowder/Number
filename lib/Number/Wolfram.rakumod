unit module Number::Wolfram;

use Number::Vars :ALL;

=begin comment

General method of converting a real number x to base b where b
is an integer != 0. (But we shall use bases >= 2 and <= 90
for real numbers and >= 2 and <= 91 for integers.)

(from Wolfram, see http://mathworld.wolfram.com/Base.html)

The base b representation of a number x is

 (a_n a_n-1 ... a_0 . a_-1 ...)_b

(e.g, 123.456_10).

The index of the leading digit needed to represent the number x in
base b is:

  n = floor (log_b x) [see computing log_b below]

then recursively compute the successive digits:

  a_i = floor r_i / b_i )

where r_n = x and

  r_(i-1) = r_i - a_i * b^i

for i = n, n - 1, ..., 1, 0, .... This gives the base b representation
of x. Note that if x is an integer, then i need only run through 0,
and that if x has a fractional part, then the expansion may or may not
terminate. For example, the hexadecimal representation of 0.1 (which
terminates in decimal notation) is the infinite expression 0.19999..._h.

The base of a logarithm is a number b used to define the number system
in which the logarithm is computed. In general, the logarithm of a
number x in base b is written log_b x. The symbol log x is an
abbeviation regrettably used both for the common logarithm log_10 x
(by engineers and physicists and indicated on pocket calcutators)
and for the natural logarithn log_e x(by mathematicians).
ln x denotes the natural logarithm log_e x (as used by engineers and
physicists and indicated on pocket calculators), and lg x denotes log_2 x.
In this work, the notations log x = log_10 x and ln x = log_e x are
used.

To convert between logarithms in different bases, the formula

  log_b x = ln x / ln b                                 (20)

can be used.

=end comment

# rewrite of sub 'from-dec-to-b37-b62' to cover all rebases
# needs two subs
sub w-frac-rebase(
    :$frac-i is copy,
    :$base-i where ( 2 <= $base-i <= 91 ),
    :$base-o where ( 2 <= $base-o <= 91 ),
    :$debug,
    ) is export(:w-frac-rebase) {

    # The caller is sub w-rebase. Here we respect the case as
    # is. Final length handling will be done in the caller, but here
    # we nust have some limit on repeating digits (TBA).  We also can
    # add proper rounding here or in the caller.  (Need rounding
    # rules.)

    =begin comment
    # see Wolfram's solution (article Base, see notes above)
    # need ln_b x = ln x / ln b
    # note Raku routine 'log' is math function 'ln' if no optional base
    # arg is entered
    my $log_b'x = log $num-i.Numeric / log $base-o;
    # get place index of first digit
    my $n = floor $log_b'x;
    # now the algorithm
    # we need @r below to be a fixed array of size $n + 2
    my @r[$n + 2];
    my @a[$n + 1];
    @r[$n] = $num-i;
    # work through the $num-i.chars places (positions, indices?)
    my @rev = (0..$n).reverse;
    for @rev -> $i { # <= Wolfram text is misleading here
	my $b'i  = $base-o ** $i;
	@a[$i]   = floor (@r[$i] / $b'i);

        say "  i = $i; a = '@a[$i]'; r = '@r[$i]'" if 0 or $debug;

        # calc r for next iteration
	@r[$i-1] = @r[$i] - @a[$i] * $b'i if $i > 0;
    }
    # @a contains the index of the digits of the number in the new base
    my $num-o = '';
    # digits are in the reversed order
    for @a.reverse -> $di {
        my $digit = @dec2digit[$di];
        $num-o ~= $digit;
    }
    =end comment


} # w-frac-rebase

sub w-rebase(
    :$num-i is copy, # to handle fractions and leading signs
    :$base-i where ( 2 <= $base-i <= 91 ),
    :$base-o where ( 2 <= $base-o <= 91 ),
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :lc($LC) is copy,
    :$debug,
    ) is export(:w-rebase) {

    my UInt $len = $num-i.chars; # includes any radix point or sign

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # consider any sign and keep it separate for now
    my $sign = "";
    if $num-i ~~ /^ (<[+-]>) (.+) / {
        $sign  = ~$0 if $0.defined;
        $num-i = ~$1;
    }

    # allow for fractional parts
    my $radix-point = '.';
    my $frac-i = 0;
    my $frac-o;
    if $num-i.contains: $radix-point {
        ($num-i, $frac-i) = $num-i.split: $radix-point;
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
    # trim leading zeroes from the integral part
    $num-i ~~ s:i/^0+/0/;

    # leading zero takes special handling
    if $num-i == 0 {
        # temporary "fix"
        return 0;
    }

    # see Wolfram's solution (article Base, see notes above)
    # need ln_b x = ln x / ln b
    # note Raku routine 'log' is math function 'ln' if no optional base
    # arg is entered
    my $log_b'x = log $num-i.Numeric / log $base-o;
    # get place index of first digit
    my $n = floor $log_b'x;
    # now the algorithm
    # we need @r below to be a fixed array of size $n + 2
    my @r[$n + 2];
    my @a[$n + 1];
    @r[$n] = $num-i;
    # work through the $num-i.chars places (positions, indices?)
    my @rev = (0..$n).reverse;
    for @rev -> $i { # <= Wolfram text is misleading here
	my $b'i  = $base-o ** $i;
	@a[$i]   = floor (@r[$i] / $b'i);

        say "  i = $i; a = '@a[$i]'; r = '@r[$i]'" if 0 or $debug;

        # calc r for next iteration
	@r[$i-1] = @r[$i] - @a[$i] * $b'i if $i > 0;
    }
    # @a contains the index of the digits of the number in the new base
    my $num-o = '';
    # digits are in the reversed order
    for @a.reverse -> $di {
        my $digit = @dec2digit[$di];
        $num-o ~= $digit;
    }

    # trim leading zeroes
    $num-o ~~ s/^ 0+ /0/;
    $num-o ~~ s:i/^ 0 (<[0..9a..z]>) /$0/;

    if $frac-o {
        # not so fast! take care of the fractional part
        # reassemble the number's parts
        $num-o ~= '.' ~ $frac-o;
    }

    if $sign {
        $num-o = $sign ~ $num-o;
    }

    $num-o
} # w-rebase
# wolfram-rebase
