unit module Number::Subs;

use Number::Vars :ALL;

sub parse-input(
    :$number,
    :$base is copy,
    :$decimal is copy;
    :$sign is copy;
    :$integer is copy;
    :$fraction is copy;
    ) is export {

    my $num = $number;
    my ($prefix, $suffix)  = "", ""; # to hold embedded base modifiers

    if $num ~~ Str {
        # it must be a string repr of a valid base number
        my $s = "";

        # save any leading sign
        $sign = "";
        if $num ~~ /^ (<[+-]>) (.+) $/ {
            $sign = ~$0;
            $num  = ~$1;
        }

        #=============================================================
        # extract any leading or trailing modifiers (can have only one
        # type or the other) leading modifiers
        #=============================================================
        # leading modifiers
        if $num ~~ /^
                      (0 <[bodx]>)?
                      (.+)
                   $/ {
            $prefix = ~$0 if $0.defined;
            $num    = ~$1;
        }
        elsif $num ~~ /^
                      (<[ \x[2081] .. \x[2089] ]><[ \x[2080] .. \x[2089] ]>?)?
                      (.+)
                   $/ {
            $prefix = ~$0 if $0.defined;
            $num    = ~$1;
        }
        # trailing modifiers (cannot have both leading and training
        # modifiers)
        elsif $num ~~ /^
                         # accepting all chars other than prefix modifiers
                         (<-[ \x[2080] .. \x[2089] ]>+)
                         # trailing suffix modifiers, if any
                         ( <[ \x[2081] .. \x[2089] ]><[ \x[2080] .. \x[2089] ]>?)?
                     $/ {
            $num    = ~$0;
            $suffix = ~$1 if $1.defined;
        }
        #==============================
        # end modifier extraction
        #==============================

        # any fractional parts
        if $num ~~ /^
                      # extracte all chars before the radix point
                      (<-[.]>)
                      # and all after, if any
                      ['.' (.+)]?
                      $/ {
            $num  = ~$0;
            $num ~= ~$1 if $1.defined;
        }
        # num is now in parts for reassembly
    }
    else {
        note "DEBUG TWEAK: Tom fix for this input for \$number: |$number|";
        exit;
    }
}

# from core.c: multi method parse-base(Str:D: Int:D $radix --> Numeric:D) {
sub parse-base2(
    Str:D $num is copy,
    $base is copy, #  where ( 2 <= $base <= 91 ),
    :$debug,
    --> Numeric:D
) is export(:parse-base2) {

    # The input string may have embedded base modifiers in multiple
    # formats:
    my Real $dec;

    # save any leading sign
    my $sign = "";
    if $num ~~ /^ (<[+-]>) (.+) $/ {
        $sign = ~$0;
        $num  = ~$1;
    }

    if $sign {
        $num = $sign ~ $num;
    }

    $dec = parse-base $num, 11;

    =begin comment
    # leading modifiers
    if $num ~~ /<[ \x[2080] .. \x[2089] / {
    }
    elsif $num ~~ // {
    }
    =end comment

    $dec.Numeric;
}

sub create-set(
    $text,
    :$debug,
    --> Set
    ) is export {

    my @chars = $text.comb.unique;
    my %h;
    for @chars {
        %h{$_} = True;
    }
    %h.Set;
} # sub create-set

sub create-base-set(
    UInt $base where ( 2 <= $base <= 91 ),
    :$debug,
    --> Set
    ) is export {

    my $first-char-idx = 0;
    my $F = $first-char-idx;
    my $first-char = @dec2digit[$first-char-idx];
    my $FC = $first-char;

    my $last-char-idx  = $base - 1;
    my $L = $last-char-idx;

    my $last-char = @dec2digit[$last-char-idx];
    my $LC = $last-char;

    my $chars = @dec2digit[$F..$L].join;

    # if the base is < 37 (letter case insensitive)
    if $base < 37 {
        # add the lower-case letters
        $chars ~= $chars.lc;
    }

    if 0 or $debug {
        say "DEBUG base $base, first char is char index $F, char '$FC'";
        say "                   last char is char index $L, char '$LC'";
        say "All chars:";
        say $chars;
        #say "DEBUG exit";exit;
    }

    my %h;
    for $chars.comb -> $c is copy {
        $c .= Str;
        %h{$c} = True;
    }
    %h.Set;
} # sub create-base-set

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
    # for now just handle integers (later, real, i.e., digits after a fraction
    # point)
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
