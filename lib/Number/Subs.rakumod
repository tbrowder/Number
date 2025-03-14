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
    UInt $base where ( 1 < $base < 92 ),
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
