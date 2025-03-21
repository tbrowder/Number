unit module Number::Wolfram;

use Number::Vars :ALL;

=begin comment

General method of converting a real number x to base b where b
is an integer != 0. (But we shall use bases >= 2 and <= 90
for real numbers and >= 2 and <= 91 for integers.)

(from Wolfram, see http://mathworld.wolfram.com/Base.html)

The base b representation of a number x is 

 (a_n a_n-1 ... a_0.a_-1 ...)_b

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

sub from-dec-to-b37-b62(
    $x'dec,
    $base-o where ( 36 < $base-o < 63 ),
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Str
    ) is export(:from-dec-to-b37-b62) {

    my UInt $len = $x'dec.chars;
    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # see Wolfram's solution (article Base, see notes above)

    # need ln_b x = ln x / ln b

    # note Raku routine 'log' is math function 'ln' if no optional base
    # arg is entered
    my $log_b'x = log $x'dec / log $base-o;

    # get place index of first digit
    my $n = floor $log_b'x;

    # now the algorithm
    # we need @r below to be a fixed array of size $n + 2
    my @r[$n + 2];
    my @a[$n + 1];

    @r[$n] = $x'dec;

    # work through the $x'dec.chars places (positions, indices?)
    # for now just handle integers (later, real, i.e., digits after a fraction point)
    my @rev = (0..$n).reverse;
    for @rev -> $i { # <= Wolfram text is misleading here
	my $b'i  = $base-o ** $i;
	@a[$i]   = floor (@r[$i] / $b'i);

        say "  i = $i; a = '@a[$i]'; r = '@r[$i]'" if 0 or $debug;

        # calc r for next iteration
	@r[$i-1] = @r[$i] - @a[$i] * $b'i if $i > 0;
    }

    # @a contains the index of the digits of the number in the new base
    my $x'b = '';
    # digits are in the reversed order
    for @a.reverse -> $di {
        my $digit = @dec2digit[$di];
        $x'b ~= $digit;
    }

    # trim leading zeroes
    $x'b ~~ s/^ 0+ /0/;
    $x'b ~~ s:i/^ 0 (<[0..9a..z]>) /$0/;

    $x'b;
} # from-dec-to-b37-b62

# rewrite of sub 'from-dec-to-b37-b62' to cover all rebases
#sub wolfram-rebase(
sub w-rebase(
    :$num-i, # $x'dec,
    :$num-o,
    :$base-i where ( 2 <= $base-i <= 91 ),
    :$base-o where ( 2 <= $base-o <= 91 ),
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :lc($LC) is copy,
    :$debug,
    --> Str
    ) is export(:w-rebase) {

    my UInt $len = $num-o.chars; # $x'dec.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # see Wolfram's solution (article Base, see notes above)

    # need ln_b x = ln x / ln b

    # note Raku routine 'log' is math function 'ln' if no optional base
    # arg is entered
#   my $log_b'x = log $x'dec / log $base-o;
    my $log_b'x = log $num-i / log $base-o;

    # get place index of first digit
    my $n = floor $log_b'x;

    # now the algorithm
    # we need @r below to be a fixed array of size $n + 2
    my @r[$n + 2];
    my @a[$n + 1];

#   @r[$n] = $x'dec;
    @r[$n] = $num-i;

    # work through the $x'dec.chars places (positions, indices?)
    # for now just handle integers (later, real, i.e., digits after a 
    # fraction point)

    my @rev = (0..$n).reverse;
    for @rev -> $i { # <= Wolfram text is misleading here
	my $b'i  = $base-o ** $i;
	@a[$i]   = floor (@r[$i] / $b'i);

        say "  i = $i; a = '@a[$i]'; r = '@r[$i]'" if 0 or $debug;

        # calc r for next iteration
	@r[$i-1] = @r[$i] - @a[$i] * $b'i if $i > 0;
    }

    # @a contains the index of the digits of the number in the new base
    my $x'b = '';
    # digits are in the reversed order
    for @a.reverse -> $di {
        my $digit = @dec2digit[$di];
        $x'b ~= $digit;
    }

    # trim leading zeroes
    $x'b ~~ s/^ 0+ /0/;
    $x'b ~~ s:i/^ 0 (<[0..9a..z]>) /$0/;

    $x'b;
} # w-rebase
# wolfram-rebase
