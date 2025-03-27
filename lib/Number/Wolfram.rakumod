unit module Number::Wolfram;

use Number::Subs;
use Number::Vars;

=begin comment

General method of converting a real number x to base b where b is an
integer != 0. (But we shall use bases >= 2 and <= 90 for real numbers
and >= 2 and <= 91 for integers.)

(from Wolfram, see http://mathworld.wolfram.com/Base.html)

The base b representation of a number x is

 (a_n a_n-1 ... a_0 . a_-1 ...)_b

(e.g, 123.456_10).

The index n of the leading digit a_n needed to represent the number x in
base b is:

  n = floor (log_b x) [see computing log_b below]

but we can get n directly from IntegerDigits(x, :base(b)).

                       log_b x = ln x / ln b
                       In Raku, routine 'log x' is equivalent to 'ln x'
                         because e is the default base. Thus:
                         log_b x = log x / log b

then recursively compute the successive digits:

  a_i = floor ( r_i / b_i )

where r_n = x and

  r_(i-1) = r_i - a_i * b^i

for i = n, n - 1, ..., 1, 0, .... This gives the base b representation
of x. Note that if x is an integer, then i need only run through 0,
and that if x has a fractional part, then the expansion may or may not
terminate. For example, the hexadecimal representation of 0.1 (which
terminates in decimal notation) is the infinite expression
0.19999..._h.

The base of a logarithm is a number b used to define the number system
in which the logarithm is computed. In general, the logarithm of a
number x in base b is written log_b x. The symbol log x is an
abbeviation regrettably used both for the common logarithm log_10 x
(by engineers and physicists and indicated on pocket calcutators) and
for the natural logarithn log_e x(by mathematicians).  ln x denotes
the natural logarithm log_e x (as used by engineers and physicists and
indicated on pocket calculators), and lg x denotes log_2 x.  In this
work, the notations log x = log_10 x and ln x = log_e x are used.

To convert between logarithms in different bases, the formula

  log_b x = ln x / ln b                                 (20)

can be used.

=end comment

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
    note "DEBUG: \$num-i: '$num-i'" if 1 or $debug;

    # see Wolfram's solution (article Base, see notes above)
    # check validity of chars for the incoming set:
    valid-base-set $num-i, :base($base-i);

    # get the indices for the incoming char set
    my @ci = IntegerDigits $num-i, :base($base-i);
    if 0 or $debug {
        note "DEBUG: \@ci:";
        note " '$_'" for @ci;
        note();
    }

    # need ln_b x = ln x / ln b
    # but it's defined in @r as @r.head
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
    my @i = (0..$N-1).reverse;
    # $i..0 [. -1..-NF ]
    for @i -> $i { # <= Wolfram text is confusing here
        note "DEBUG:  i = '$i'" if 1 or $debug;
	my $bi = $base-o ** $i;
        @r[$i] = @r[$i+1] + @a[$i+1] * $base-o ** $i+1;
	@a[$i] = floor (@r[$i] / $bi);

        note "DEBUG:  i = $i; a = '@a[$i]'; r = '@r[$i]'" if 1 or $debug;
    }

    # @a now contains the indices of the digits of the number in the new base
    my $num-o = '';
    for @a -> $di {
        note "DEBUG: \@a -> \$di: '$di'" if 1 or $debug;
        #my $digit = @dec2digit[$di];
        #note "DEBUG: \@a -> \$di: '$di'; resulting \$digit: '$digit'";
        #$num-o ~= $digit if 1 or $debug;
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
} # w-rebase
# wolfram-rebase

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

    # trim any leading 0.
    $frac-i ~~ s:i/^ 0? '.'//;

    # assume max of 20 chars output
    my $n = 20;
    my @r[$n + 2];
    my @a[$n + 1];

    @r[0] = $frac-i;
    # work through the $num-i.chars places (positions, indices?)
    for @r -> $i { # <= Wolfram text is misleading here
	my $b'i  = $base-o ** $i;
	@a[$i]   = floor (@r[$i] / $b'i);
        say "  i = $i; a = '@a[$i]'; r = '@r[$i]'" if 0 or $debug;
        # calc r for next iteration
	@r[$i-1] = @r[$i] - @a[$i] * $b'i if $i > 0;
    }

    my @chars = $frac-i.comb;
    for 1..$n {
        @r.push: -$_;
    }

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
    my @r[$n + 2];   # empty array of $n+2 elements
    my @a[$n + 1];   # empty array of $n+1 elements
    @r[$n] = $num-i; # put $num-i in the $nth position
    # work through the $num-i.chars places (positions, indices)
    my @rev = (0..$n).reverse;
    for @rev -> $i {
        # <= Wolfram text is confusing me here
        # we are indexing from $n..0 and $i is the power $base-o is raised to
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

# subs based on name and signature from Wolfram Math Base info

# a Wolfram sub:
multi sub IntegerDigits(
    $n is copy,
    :$base = 10,
    --> List
    ) is export {

    # gives a list of the $base (default: 10) digits in the integer $n
    if $base <= 36 { $n .= uc; }

    # ensure input is valid for the desired base
    unless valid-base-set($n, :$base) {
        die "Integer '$n' not valid for base $base";
    }

    note "DEBUG: input \$n: '$n'";

    my @c = $n.comb;
    my @d;
    for @c {
        #our %digit2dec is export(:digit2dec) = @dec2digit.antipairs;
        my $d = %digit2dec{$_};
        note "DEBUG: char '$_', index '$d'";
        @d.push: $d; #%digit2dec{$_};
    }

    @d;
}

# a Wolfram sub:
#multi sub IntegerDigits(
sub PadDigits(
    $n is copy,
    UInt $len,
    :$base = 10,
    ) is export {

    # pads the list on the left with zeroes to give a list of length $len

    # ensure input is valid for the desired base
    unless valid-base-set($n, :$base) {
        die "Integer '$n' not valid for base $base";
    }

    while $n.chars < $len { $n = '0' ~ $n; }

    $n
}
