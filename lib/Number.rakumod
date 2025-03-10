unit class Number;

my $DEBUG = 0;

my $LH = %*ENV<LENGTH_HANDLING>:exists ??
         %*ENV<LENGTH_HANDLING> !! 'ignore'; # other options: 'warn', 'fail'
my token length-action { ^ :i warn|fail $ }

our $bset = "01".comb.Set;
our $oset = (0..7).Set;
our $dset = (0..9).Set;
our $hset = "ABCDEFabcdef".comb.Set (|) $dset;

# Define tokens for common regexes (no prefixes are allowed)
my token binary is export(:token-binary)            { ^ <[01]>+ $ }
my token octal is export(:token-octal)              { ^ <[0..7]>+ $ }
my token decimal is export(:token-decimal)          { ^ \d+ $ } # actually an int
my token hexadecimal is export(:token-hexadecimal)  { :i ^ <[a..f\d]>+ $ }

# Note default Raku hex input handling is mixed case and upper-case
# for output.  This module handles either input but hex input MUST be
# either all upper or all lower case to preserve output.

# For general base specification functions 2..91
our token all-bases is export(:token-all-bases)  { ^
                                                   <[2..9]> |
                                                   <[1..8]><[0..9]> |
                                                   9 <[01]>
                                                 $ }

our $base63 is export(:base63) = 
            ( 0..9, "A".."Z", "a".."z", '!' ).join; # case-sensitive
our $base64 is export(:base64) = 
            ( 0..9, "A".."Z", "a".."z", '!'..'#' ).join; # case-sensitive

=begin comment
# extended to base 91
our token base63 is export(:token-base63)           { ^ <[A..Za..z\d ! ]>+ $ }  # case-sensitive, multiple chars
our token base64 is export(:token-base64)           { ^ <[A..Za..z\d ! # ]>+ $ }  # case-sensitive, multiple chars
our token base65 is export(:token-base65)           { ^ <[A..Za..z\d ! # $ ]>+ $ }  # case-sensitive, multiple chars
our token base66 is export(:token-base66)           { ^ <[A..Za..z\d ! # $ % ]>+ $ }  # case-sensitive, multiple chars
our token base67 is export(:token-base67)           { ^ <[A..Za..z\d ! # $ % & ]>+ $ }  # case-sensitive, multiple chars
our token base68 is export(:token-base68)           { ^ <[A..Za..z\d ! # $ % & ( ]>+ $ }  # case-sensitive, multiple chars
our token base69 is export(:token-base69)           { ^ <[A..Za..z\d ! # $ % & ( ) ]>+ $ }  # case-sensitive, multiple chars
our token base70 is export(:token-base70)           { ^ <[A..Za..z\d ! # $ % & ( ) * ]>+ $ }  # case-sensitive, multiple chars
our token base71 is export(:token-base71)           { ^ <[A..Za..z\d ! # $ % & ( ) * + ]>+ $ }  # case-sensitive, multiple chars
our token base72 is export(:token-base72)           { ^ <[A..Za..z\d ! # $ % & ( ) * + , ]>+ $ }  # case-sensitive, multiple chars

# At this point we swap the original positions of the period and the double quotation mark
# in order to use the period as a radix point for bases 2..90.
our token base73 is export(:token-base73)           { ^ <[A..Za..z\d ! # $ % & ( ) * + , " ]>+ $ }  # case-sensitive, multiple chars
our token base74 is export(:token-base74)           { ^ <[A..Za..z\d ! # $ % & ( ) * + , " / ]>+ $ }  # case-sensitive, multiple chars
our token base75 is export(:token-base75)           { ^ <[A..Za..z\d ! # $ % & ( ) * + , " / : ]>+ $ }  # case-sensitive, multiple chars
our token base76 is export(:token-base76)           { ^ <[A..Za..z\d ! # $ % & ( ) * + , " / : ; ]>+ $ }  # case-sensitive, multiple chars
our token base77 is export(:token-base77)           { ^ <[A..Za..z\d ! # $ % & ( ) * + , " / : ; < ]>+ $ }  # case-sensitive, multiple chars
our token base78 is export(:token-base78)           { ^ <[A..Za..z\d ! # $ % & ( ) * + , " / : ; < = ]>+ $ }  # case-sensitive, multiple chars
our token base79 is export(:token-base79)           { ^ <[A..Za..z\d ! # $ % & ( ) * + , " / : ; < = > ]>+ $ }  # case-sensitive, multiple chars
our token base80 is export(:token-base80)           { ^ <[A..Za..z\d ! # $ % & ( ) * + , " / : ; < = > ? ]>+ $ }  # case-sensitive, multiple chars
our token base81 is export(:token-base81)           { ^ <[A..Za..z\d ! # $ % & ( ) * + , " / : ; < = > ? @ ]>+ $ }  # case-sensitive, multiple chars
our token base82 is export(:token-base82)           { ^ <[A..Za..z\d ! # $ % & ( ) * + , " / : ; < = > ? @ [ ]>+ $ }  # case-sensitive, multiple chars
our token base83 is export(:token-base83)           { ^ <[A..Za..z\d ! # $ % & ( ) * + , " / : ; < = > ? @ [ \] ]>+ $ }  # case-sensitive, multiple chars
our token base84 is export(:token-base84)           { ^ <[A..Za..z\d ! # $ % & ( ) * + , " / : ; < = > ? @ [ \] ^ ]>+ $ }  # case-sensitive, multiple chars
our token base85 is export(:token-base85)           { ^ <[A..Za..z\d ! # $ % & ( ) * + , " / : ; < = > ? @ [ \] ^ _ ]>+ $ }  # case-sensitive, multiple chars
our token base86 is export(:token-base86)           { ^ <[A..Za..z\d ! # $ % & ( ) * + , " / : ; < = > ? @ [ \] ^ _ ` ]>+ $ }  # case-sensitive, multiple chars
our token base87 is export(:token-base87)           { ^ <[A..Za..z\d ! # $ % & ( ) * + , " / : ; < = > ? @ [ \] ^ _ ` { ]>+ $ }  # case-sensitive, multiple chars
our token base88 is export(:token-base88)           { ^ <[A..Za..z\d ! # $ % & ( ) * + , " / : ; < = > ? @ [ \] ^ _ ` { | ]>+ $ }  # case-sensitive, multiple chars
our token base89 is export(:token-base89)           { ^ <[A..Za..z\d ! # $ % & ( ) * + , " / : ; < = > ? @ [ \] ^ _ ` { | } ]>+ $ }  # case-sensitive, multiple chars
our token base90 is export(:token-base90)           { ^ <[A..Za..z\d ! # $ % & ( ) * + , " / : ; < = > ? @ [ \] ^ _ ` { | } ~ ]>+ $ }  # case-sensitive, multiple chars

# Note base91 cannot have the period as a radix point but we handle it
# with a unicode character above the ASCII range.
our token base91 is export(:token-base91)           { ^ <[A..Za..z\d ! # $ % & ( ) * + , " / : ; < = > ? @ [ \] ^ _ ` { | } ~ .]>+ $ }  # case-sensitive, multiple chars

#| The original extended character set (29 more chars) after base62 to base91
#| (from http://base91.sourceforge.net/):
#|
#|                   1                   2
#| 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9
#| ! # $ % & ( ) * + , . / : ; < = > ? @ [ ] ^ _ ` { | } ~ "

#| In order to use the period as the radix point for fractions
#| we swap the period and the double quotation mark.

#|                   1                   2
#| 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9
#| ! # $ % & ( ) * + , " / : ; < = > ? @ [ ] ^ _ ` { | } ~ .

# Then, for bases 2 through 90 the radix point is the period. For base
# 91 we provide a separate routine to return the integer and fractional
# parts.

our @base is export(:base) = [
# bases 2-36: use Raku routines
'0',
'1',
&base2,  &base3,  &base4,  &base5,  &base6,  &base7,  &base8,  &base9,
&base10, &base11, &base12, &base13, &base14, &base15, &base16, &base17, &base18, &base19,
&base20, &base21, &base22, &base23, &base24, &base25, &base26, &base27, &base28, &base29,
&base30, &base31, &base32, &base33, &base34, &base35, &base36,

# bases 37-91: use this module
&base37, &base38, &base39,
&base40, &base41, &base42, &base43, &base44, &base45, &base46,
&base47, &base48, &base49, &base50, &base51, &base52, &base53,
&base54, &base55, &base56, &base57, &base58, &base59, &base60,
&base61, &base62, &base63, &base64, &base65, &base66, &base67, &base68, &base69, &base70,
&base71, &base72, &base73, &base74, &base75, &base76, &base77, &base78, &base79, &base80,
&base81, &base82, &base83, &base84, &base85, &base86, &base87, &base88, &base89, &base90,
&base91
];
=end comment

# Standard digit set for bases 2 through 91 (char 0 through 91).
# The array of digits is indexed by their decimal value.
our @dec2digit is export(:dec2digit) = [
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', # 10
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', # 20
    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', # 30
    'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', # 40
    'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', # 50
    'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', # 60
    'y', 'z', '!', '#', '$', '%', '&', '(', ')', '*', # 70
    '+', ',', '"', '/', ':', ';', '<', '=', '>', '?', # 80
    '@', '[', ']', '^', '_', '`', '{', '|', '}', '~', # 90
    '.',                                              # 91
    ];

# Standard digit set for bases 2 through 91 (char 0 through 91).
# The hash is comprised of digit keys and their decimal value.
our %digit2dec is export(:digit2dec) = @dec2digit.antipairs;

=begin comment
our %digit2dec is export(:digit2dec) = %(
    '0' =>  0, '1' =>  1, '2' =>  2, '3' =>  3, '4' =>  4, '5' =>  5, '6' =>  6, '7' =>  7, '8' =>  8, '9' =>  9, # 10
    'A' => 10, 'B' => 11, 'C' => 12, 'D' => 13, 'E' => 14, 'F' => 15, 'G' => 16, 'H' => 17, 'I' => 18, 'J' => 19, # 20
    'K' => 20, 'L' => 21, 'M' => 22, 'N' => 23, 'O' => 24, 'P' => 25, 'Q' => 26, 'R' => 27, 'S' => 28, 'T' => 29, # 30
    'U' => 30, 'V' => 31, 'W' => 32, 'X' => 33, 'Y' => 34, 'Z' => 35, 'a' => 36, 'b' => 37, 'c' => 38, 'd' => 39, # 40
    'e' => 40, 'f' => 41, 'g' => 42, 'h' => 43, 'i' => 44, 'j' => 45, 'k' => 46, 'l' => 47, 'm' => 48, 'n' => 49, # 50
    'o' => 50, 'p' => 51, 'q' => 52, 'r' => 53, 's' => 54, 't' => 55, 'u' => 56, 'v' => 57, 'w' => 58, 'x' => 59, # 60
    'y' => 60, 'z' => 61, '!' => 62, '#' => 63, '$' => 64, '%' => 65, '&' => 66, '(' => 67, ')' => 68, '*' => 69, # 70
    '+' => 70, ',' => 71, '"' => 72, '/' => 73, ':' => 74, ';' => 75, '<' => 76, '=' => 77, '>' => 78, '?' => 79, # 80
    '@' => 80, '[' => 81, ']' => 82, '^' => 83, '_' => 84, '`' => 85, '{' => 86, '|' => 87, '}' => 88, '~' => 89, # 90
    '.' => 90,                                                                                                    # 91
);
=end comment

our token base { ^ 2|8|10|16 $ }

#=============================
# class Number definition
#=============================
#class NumObj is export {

# as originally input:
has      $.number is required; # may have a radix point
has      $.base   is required; # 1 < base < 92

# the decimal number resulting from the input
has     $.sign;         # +1 or -1
has     $.integer;      # may be negative
has     $.fraction = 0; # fractional part

submethod TWEAK {
    if $!number < 0 {
        $!sign     = -1;
        $!integer *= -1;
    }
    else {
        $!sign     = +1;
    }
    unless 1 < $!base < 92 {
        die "FATAL: 'base' must be > 1 and < 92, input was '$!base'";
    }
    ($!integer, $!fraction) = self.to-base: $!number, :base($!base);
}

# Methods
#
# Following the referenced paper, express the integral and fractional
# parts as sum of each digit as a power:
#
#   digit * $base^digit-place
#
# where digit-place is (Npositive-digit - 1)..0 . -1..-(Nnegative-digit)

method to-base($number, Numeric :$base --> List) {
    # Use Raku directly if base is < 37
    my ($integer, $fraction) = $number.split: '.';

    if $fraction and $base > 36 {
        die "FATAL: Unable to handle real numbers with base > 36":
    }

    my $res = $number.parse-base: $base;
    my ($int, $dec) = 0, 0;
    if $fraction {
        ($int, $dec) = $res.split: '.';
        $dec = '0.' ~ $dec;
    }
    else {
        $int = $res;
        $dec = 0;
    }

    =begin comment
    my @D  = $integer.comb;
    my @np = (0..^@D.elems).reverse;
    my @d  = $fraction ?? $fraction.comb !! [];
    my @nn = 1..@d.elems;
    for @D.kv -> $i, $d {
        my $exp = @np[$i];
        my $v = $d * exp($exp, $base);
        $int += $v;
    }
    for @d.kv -> $i, $d  {
        my $exp = -1 * @nn[$i];
        my $v = $d * exp($exp, $base);
        $dec += $v;
    }
    =end comment

    $int, $dec;
}

multi method multiply-by(
    $num,
    :$base!
    ) {
}
multi method multiply-by(
    Number $o,
    ) {
}

multi method divide-by(
    $num,
    :$base!
    ) {
}
multi method divide-by(
    Number $o
    ) {
}

multi method add(
    $num,
    :$base!
    ) {
}
multi method add(
    Number $o
    ) {
}

multi method subtract(
    $num,
    :$base!
    ) {
}
multi method subtract(
    Number $o
    ) {
}

#===============================
# end of class Number definition
#===============================

# This is an internal sub
sub pad-number(
    $num is copy,
    UInt $base where &all-bases,
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Cool
    ) {

    my UInt $len = $num.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    if $prefix and $suffix {
        die "FATAL: You cannot select both :prefix and :suffix";
    }

    # This also checks for length error, upper-lower casing, and handling
    if 10 < $base < 37 {
        if $LC {
	    # special feature for case-insensitive bases
            $num .= lc;
        }
    }

    # strip any leading type indicator
    if $base ~~ /2|8|10|16/ {
        $num ~~ s/^0 [b|o|d|x]//;
    }
    # strip any leading zeroes
    if $num.chars > 1 {
        $num ~~ s/^0*//;
    }

    # now $num should be "clean"
    my $nc  = $num.chars; # with no extra characters (no leading zeroes)

    # num pad zeroes with no prefix
    my $npad0 = $length > $nc ?? ($length - $nc) !! 0;
    if $prefix {
        $npad0 -= 2;
        $npad0 = 0 if $npad0 < 0;
    }

    my $ncmin = $prefix ?? ($nc + 2) !! $nc;
    if ($length and ($LH ~~ (&length-action)) and ($ncmin > $length)) {
        my $msg = "Desired length ($length) of number '$num' is\
                     less than required by it";
        $msg ~= " and its prefix" if $prefix;
        $msg ~= " ($ncmin).";

        if $LH ~~ /$ :i warn $/ {
            note "WARNING: $msg";
        }
        elsif $LH ~~ /$ :i ignore $/ {
            ; # okay
        }
        else {
            die "FATAL: $msg";
        }
    }

    =begin comment
    padding, num raw length, and prefixes
    num  length prefix result
    x    0      none   x
    x    1      none   x
    x    2      none   0x
    x    3      none   00x
    x    4      none   000x

    x    1      0b     0bx
    x    2      0b     0bx
    x    3      0b     0bx
    x    4      0b     0b0x

    xxx  0      none   xxx
    xxx  2      none   xxx
    xxx  3      none   xxx
    xxx  4      none   0xxx

    xxx  0      0b     0bxxx
    xxx  2      0b     0bxxx
    xxx  3      0b     0bxxx
    xxx  4      0b     0bxxx
    xxx  5      0b     0bxxx
    xxx  6      0b     0b0xxx
    =end comment

    if $npad0 {
        # padding with zeross is required
        # first pad with zeroes, less any desired prefix
        my $zpad = '0' x $npad0;
        $num = $zpad ~ $num;
        $nc  = $num.chars;

        # now the following test should always be true!!
        unless $length > $ncmin {
            die "debug FATAL: unexpected \$length ($length)\
                NOT greater than \$ncmin ($ncmin)";
        }
    }

    if $prefix {
        when $base == 2  { $num = '0b' ~ $num }
        when $base == 8  { $num = '0o' ~ $num }
        when $base == 10 { $num = '0d' ~ $num }
        when $base == 16 { $num = '0x' ~ $num }
    }

    if $suffix {
        my @c = $base.comb;
        my $s;
        for @c {
            when /0/ { $s ~= "\x2080" }
            when /1/ { $s ~= "\x2081" }
            when /2/ { $s ~= "\x2082" }
            when /3/ { $s ~= "\x2083" }
            when /4/ { $s ~= "\x2084" }
            when /5/ { $s ~= "\x2085" }
            when /6/ { $s ~= "\x2086" }
            when /7/ { $s ~= "\x2087" }
            when /8/ { $s ~= "\x2088" }
            when /9/ { $s ~= "\x2089" }
            default {
                die "FATAL: Unknown base digit '$_'";
            }
        }
	$num ~= $s;
    }

    $num
} # pad-number

#------------------------------------------------------------------------------
# Subroutine: hex2dec
# Purpose : Convert a non-negative hexadecimal number (string) to a decimal number.
# Params  : Hexadecimal number (string), desired length (optional), suffix (optional).
# Returns : Decimal number (or string).
sub hex2dec(
    $hex where &hexadecimal,
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Cool
    ) is export(:hex2dec) {

    my UInt $len = $hex.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # need bases of incoming and outgoing number
    constant $base-i = 16;
    constant $base-o = 10;

    my $dec = $hex.parse-base: $base-i;
    $dec = pad-number $dec, $base-o, :$prefix, :$suffix, :$length, :$LC;

    $dec;
} # hex2dec

#------------------------------------------------------------------------------
# Subroutine: hex2bin
# Purpose : Convert a non-negative hexadecimal number (string) to a binary string.
# Params  : Hexadecimal number (string), desired length (optional), prefix (optional), suffix (optional).
# Returns : Binary number (string).
sub hex2bin(
    $hex where &hexadecimal,
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Str
    ) is export(:hex2bin) {

    my UInt $len = $hex.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # need bases of incoming and outgoing number
    constant $base-i = 16;
    constant $base-o =  2;

    # have to get decimal first
    my $dec = $hex.parse-base: $base-i;
    my $bin = $dec.base: $base-o;

    $bin = pad-number $bin, $base-o, :$prefix, :$suffix, :$length, :$LC;

    $bin;
} # hex2bin

#------------------------------------------------------------------------------
# Subroutine: dec2hex
# Purpose : Convert a non-negative integer to a hexadecimal number (string).
# Params  : Non-negative decimal number, desired length (optional), prefix (optional), suffix (optional), lower-case (optional).
# Returns : Hexadecimal number (string).
sub dec2hex(
    $dec where &decimal,
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Str
    ) is export(:dec2hex) {

    my UInt $len = $dec.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # need base of outgoing number
    constant $base-o = 16;

    my $hex = $dec.Numeric.base: $base-o;
    $hex = pad-number $hex, $base-o, :$prefix, :$suffix, :$length, :$LC;

    $hex;
} # dec2hex

#------------------------------------------------------------------------------
# Subroutine: dec2bin
# Purpose : Convert a non-negative integer to a binary number (string).
# Params  : Non-negative decimal number, desired length (optional), prefix (optional), suffix (optional).
# Returns : Binary number (string).
sub dec2bin(
    $dec where &decimal,
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Str
    ) is export(:dec2bin) {

    my UInt $len = $dec.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # need base of outgoing number
    constant $base-o = 2;

    my $bin = $dec.Numeric.base: $base-o;
    $bin = pad-number $bin, $base-o, :$prefix, :$suffix, :$length, :$LC;

    $bin;
} # dec2bin

#------------------------------------------------------------------------------
# Subroutine: bin2bin
# Purpose : Convert a binary number (string) to a binary number with possible
#           augmented features
# Params  : Binary number (string)
# Options : Desired length (padding with zeroes), prefix, suffix
# Returns : Binary number (or string).
sub bin2bin(
    $bin-i where &binary,
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Str
    ) is export(:bin2bin) {

    my UInt $len = $bin-i.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # no change of base needed
    constant $base-o = 2;

    my $bin-o = $bin-i;
    $bin-o = pad-number $bin-o, $base-o, :$prefix, :$suffix, :$length, :$LC;

    $bin-o;
} # bin2bin

#------------------------------------------------------------------------------
# Subroutine: oct2oct
# Purpose : Convert an octal number (string) to an octal number with
#           possible augmented features
# Params  : Octal number (string)
# Options : Desired length (padding with zeroes), prefix, suffix
# Returns : Octal number (or string).
sub oct2oct(
    $oct-i where &octal,
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Cool
    ) is export(:oct2oct) {

    my UInt $len = $oct-i.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # no change of base needed
    constant $base-o = 8;

    my $oct-o = $oct-i;
    $oct-o = pad-number $oct-o, $base-o, :$prefix, :$suffix, :$length, :$LC;

    $oct-o;
} # oct2oct

#------------------------------------------------------------------------------
# Subroutine: dec2dec
# Purpose : Convert an decimal number (string) to an decimal number with
#           possible augmented features
# Params  : Decimal number (string)
# Options : Desired length (padding with zeroes), prefix, suffix
# Returns : Digital number (or string).
sub dec2dec(
    $dec-i where &decimal,
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Cool
    ) is export(:dec2dec) {

    my UInt $len = $dec-i.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # no change in base needed
    constant $base-o = 10;

    my $dec-o = $dec-i.Numeric;
    $dec-o = pad-number $dec-o, $base-o, :$prefix, :$suffix, :$length, :$LC;

    $dec-o;
} # dec2dec

#------------------------------------------------------------------------------
# Subroutine: hex2hex
# Purpose : Convert a hexadecimal number (string) to a hexadecimal number with
#           possible augmented features
# Params  : Hexadecimal number (string)
# Options : Desired length (padding with zeroes), prefix, suffix
# Returns : Hexadecimal number (or string).
sub hex2hex(
    $hex-i where &hexadecimal,
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Cool
    ) is export(:hex2hex) {

    my UInt $len = $hex-i.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # no change of base needed
    constant $base-o = 16;

    my $hex-o = $hex-i;
    $hex-o = pad-number $hex-o, $base-o, :$prefix, :$suffix, :$length, :$LC;

    $hex-o;
} # hex2hex

#------------------------------------------------------------------------------
# Subroutine: bin2dec
# Purpose : Convert a binary number (string) to a decimal number with
#           possible augmented features
# Purpose : Convert a binary number (string) to a decimal number.
# Params  : Binary number (string)
# Options : Desired length (padding with zeroes), prefix, suffix
# Returns : Decimal number (or string).
sub bin2dec(
    $bin where &binary,
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Cool
    ) is export(:bin2dec) {

    my UInt $len = $bin.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # need bases of incoming and outgoing numbers
    constant $base-i =  2;
    constant $base-o = 10;

    my $dec = $bin.parse-base: $base-i;
    $dec = pad-number $dec, $base-o, :$prefix, :$suffix, :$length, :$LC;

    $dec;
} # bin2dec

#------------------------------------------------------------------------------
# Subroutine: bin2hex
# Purpose : Convert a binary number (string) to a hexadecimal number (string).
# Params  : Binary number (string), desired length (optional), prefix (optional), suffix (optional), lower-case (optional).
# Returns : Hexadecimal number (string).
sub bin2hex(
    $bin where &binary,
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Str
    ) is export(:bin2hex) {

    my UInt $len = $bin.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # need bases of incoming and outgoing number
    constant $base-i =  2;
    constant $base-o = 16;

    # need decimal intermediary
    my $dec = parse-base $bin, $base-i;
    my $hex = $dec.base: $base-o;
    pad-number $hex, $base-o, :$prefix, :$suffix, :$LC;

    $hex;
} # bin2hex

#------------------------------------------------------------------------------
# Subroutine: oct2bin
# Purpose : Convert an octal number (string) to a binary number (string).
# Params  : Octal number (string), desired length (optional), prefix (optional), suffix (optional).
# Returns : Binary number (string).
sub oct2bin(
    $oct where &octal,
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Str
    ) is export(:oct2bin) {

    my UInt $len = $oct.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # need bases of incoming and outgoing number
    constant $base-i = 8;
    constant $base-o = 2;

    # need decimal intermediary
    my $dec = $oct.parse-base: $base-i;
    my $bin = $dec.base: $base-o;
    $bin = pad-number $bin, $base-o, :$prefix, :$suffix, :$length, :$LC;

    $bin;
} # oct2bin

#------------------------------------------------------------------------------
# Subroutine: oct2hex
# Purpose : Convert an octal number (string) to a hexadecimal number (string).
# Params  : Octal number (string), desired length (optional), prefix (optional), suffix (optional), lower-case (optional).
# Returns : Hexadecimal number (string).
sub oct2hex(
    $oct where &octal,
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Str
    ) is export(:oct2hex) {

    my UInt $len = $oct.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # need bases of incoming and outgoing number
    constant $base-i =  8;
    constant $base-o = 16;

    # need decimal intermediary
    my $dec = $oct.parse-base: $base-i;
    my $hex = $dec.base: $base-o;
    $hex = pad-number $hex, $base-o, :$prefix, :$suffix, :$length, :$LC;

    $hex;
} # oct2hex

#------------------------------------------------------------------------------
# Subroutine: oct2dec
# Purpose : Convert an octal number (string) to a decimal number.
# Params  : Octal number (string), desired length (optional), suffix (optional).
# Returns : Decimal number (or string).
sub oct2dec(
    $oct where &octal, 
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Cool
    ) is export(:oct2dec) {

    my UInt $len = $oct.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # need bases of incoming and outgoing number
    constant $base-i =  8;
    constant $base-o = 10;

    my $dec = $oct.parse-base: $base-i;
    $dec = pad-number $dec, $base-o, :$prefix, :$suffix, :$length, :$LC;

    $dec;
} # oct2dec

#------------------------------------------------------------------------------
# Subroutine: bin2oct
# Purpose : Convert a binary number (string) to an octal number (string).
# Params  : Binary number (string), desired length (optional), prefix (optional), suffix (optional).
# Returns : Octal number (string).
sub bin2oct(
    $bin where &binary,
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Str
    ) is export(:bin2oct) {

    my UInt $len = $bin.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # need bases of incoming and outgoing number
    constant $base-i = 2;
    constant $base-o = 8;

    # need decimal intermediary
    my $dec = $bin.parse-base: $base-i;
    my $oct = $dec.base: $base-o;

    $oct = pad-number $oct, $base-o, :$prefix, :$suffix, :$length, :$LC;

    $oct;
} # bin2oct

#------------------------------------------------------------------------------
# Subroutine: dec2oct
# Purpose : Convert a non-negative integer to an octal number (string).
# Params  : Decimal number, desired length (optional), prefix (optional), suffix (optional).
# Returns : Octal number (string).
sub dec2oct(
    $dec where &decimal,
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Cool
    ) is export(:dec2oct) {

    my UInt $len = $dec.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # need base of outgoing number
    constant $base-o =  8;

    my $oct = $dec.Numeric.base: $base-o;
    $oct = pad-number $oct, $base-o, :$prefix, :$suffix, :$length, :$LC;

    $oct;
} # dec2oct

#------------------------------------------------------------------------------
# Subroutine: hex2oct
# Purpose : Convert a hexadecimal number (string) to an octal number (string).
# Params  : Hexadecimal number (string), desired length (optional), prefix (optional), suffix (optional).
# Returns : Octal number (string).
sub hex2oct(
    $hex where &hexadecimal, 
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Str
    ) is export(:hex2oct) {

    my UInt $len = $hex.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # need bases of incoming and outgoing number
    constant $base-i = 16;
    constant $base-o =  8;

    # need decimal intermediary
    my $dec = $hex.parse-base: $base-i;
    my $oct = $dec.base: $base-o;
    $oct = pad-number $oct, $base-o, :$prefix, :$suffix, :$length, :$LC;

    $oct;
} # hex2oct

#------------------------------------------------------------------------------
# Subroutine: rebase
# Purpose : Convert any number (integer or string) and base (2..91) to a number in another base (2..62).
# Params  : Number (string), desired length (optional), prefix (optional), suffix (optional), suffix (optional), lower-case (optional).
# Returns : Desired number (decimal or string) in the desired base.
sub rebase(
    $num-i,
    $base-i where &all-bases,
    $base-o where &all-bases,
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Cool
    ) is export(:baseM2baseN) {

    my UInt $len = $num-i.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # make sure incoming number is in the right base
    my $bset = create-base-set $base-i;
    my $nset = create-set $num-i;

    unless $nset (<=) $bset {
        die "FATAL: Incoming number '$num-i' in sub 'rebase' is\
              not a member of base '$base-i'.";
    }

    # check for same bases
    if $base-i eq $base-o {
        say "WARNING: Both bases are the same ($base-i), no conversion necessary."
    }

    # check for known bases, eliminate any prefixes
    my ($bi, $bo);
    {
        when $base-i == 2  {
	    $bi = 'bin';
	    $num-i ~~ s:i/^0b//;
	}
        when $base-i == 8  {
	    $bi = 'oct';
	    $num-i ~~ s:i/^0o//;
	}
        when $base-i == 10  {
	    $bi = 'dec';
	    $num-i ~~ s:i/^0d//;
	}
        when $base-i == 16 {
	    $bi = 'hex';
	    $num-i ~~ s:i/^0x//;
	}
    }
    {
        when $base-o == 2  { $bo = 'bin' }
        when $base-o == 8  { $bo = 'oct' }
        when $base-o == 10 { $bo = 'dec' }
        when $base-o == 16 { $bo = 'hex' }
    }

    if $bi and $bo and (0 or $debug) {
        note "\nDEBUG Use function '{$bi}2{$bo}' instead for an easier interface.";
    }

    =begin comment
    if 10 < $base-i < 36 && $num-i ~~ /Str/ {
        # we MUST use upper case
        $num-i .= uc;
    }
    =end comment

    # treatment varies if in or out base is decimal
    my $num-o;
    if $base-i == 10 {
	if $base-o < 37 {
            # use Raku routine
            $num-o = $num-i.base: $base-o;
	}
	else {
            $num-o = from-dec-to-b37-b91 $num-i, $base-o;
	}
    }
    elsif $base-o == 10 {
	if $base-i < 37 {
            # use Raku routine
            $num-o = parse-base $num-i, $base-i;
	}
	else {
	    $num-o = to-dec-from-b37-b91 $num-i, $base-o;
	}
    }
    elsif ($base-i < 37) and ($base-o < 37) {
        # use Raku routine
        # need decimal as intermediary
        my $dec = $num-i.parse-base: $base-i;
        $num-o  = $dec.base: $base-o;
    }
    else {
        # need decimal as intermediary
	my $dec;
	if $base-i < 37 {
            $dec = $num-i.parse-base: $base-i;
	}
	else {
	    $dec = to-dec-from-b37-b91 $num-i, $base-i;
	}

        # then convert to desired base
	if $base-o < 37 {
            # use Raku routine
            $num-o = $dec.base: $base-o;
	}
	else {
            $num-o = from-dec-to-b37-b91 $dec, $base-o;
	}
    }

    # Finally, pad the number, make upper-case, and add prefix or suffix as
    # appropriate
    if $base-o == 2 || $base-o == 8 || $base-o == 10 {
        $num-o = pad-number $num-o, $base-o, :$prefix, :$suffix, :$length, :$LC;
    }
    elsif $base-o == 16 {
        $num-o = pad-number $num-o, $base-o, :$prefix, :$suffix, :$length, :$LC;
    }
    elsif (10 < $base-o < 37) {
	# case insensitive bases
        $num-o = pad-number $num-o, $base-o, :$prefix, :$suffix, :$length, :$LC;
    }
    elsif (1 < $base-o < 11) {
	# case N/A bases
        $num-o = pad-number $num-o, $base-o, :$prefix, :$suffix, :$length, :$LC;
    }
    else {
	# case SENSITIVE bases
        $num-o = pad-number $num-o, $base-o, :$prefix, :$suffix, :$length, :$LC;
    }

    $num-o;
} # rebase

# str2num
sub to-dec-from-b37-b91(
    $num,
    UInt $base-i where ( 36 < $base-i < 63 ),
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Cool
    ) is export(:to-dec-from-b37-b62) {

    my UInt $len = $num.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

=begin comment
# see simple algorithm for base to dec:

Let's say you have a number

  10121 in base 3

and you want to know what it is in base 10.  Well, in base three the
place values [from the highest] are

   4   3  2  1  0 <= digit place (position)
  81, 27, 9, 3, 1 <= value: digit x base ** place

so we have 1 x 81 + 0 x 27 + 1 x 9 + 2 x 3 + 1 x 1

  81 + 0 + 9 + 6 + 1 = 97

that is how it works.  You just take the number, figure out the place
values, and then add them together to get the answer.  Now, let's do
one the other way.

45 in base ten (that is the normal one.) Let's convert it to base
five.

Well, in base five the place values will be 125, 25, 5, 1

We won't have any 125's but we will have one 25. Then we will have 20
left.  That is four 5's, so in base five our number will be 140.

Hope that makes sense.  If you don't see a formula, try to work out a
bunch more examples and they should get easier.

-Doctor Ethan,  The Math Forum

=end comment

    # reverse the digits (chars) of the input number
    my @num'r = $num.comb.reverse;
    my $place = $num.chars;

    my $dec = 0;
    
    for @num'r -> $char  {
	--$place; # first place is num chars - 1
        if $char ~~ /:i z/ {
            note "DEBUG: input char is '$char', place = $place" if $DEBUG;
        }
	# need to convert the digit to dec first
	my $digit-val = %digit2dec{$char};
        if $char ~~ /:i z/ {
            note "DEBUG: input char is '$char', digit val is $digit-val" if $DEBUG;
        }
	my $val = $digit-val * $base-i ** $place;
	$dec += $val;
    }

    $dec;
} # to-dec-from-b37-b91

#============
=begin comment

General method of converting a whole number (decimal) to a base b
(from Wolfram, see [Base] in README.md references):

the index of the leading digit needed to represent the number x in
base b is:

  n = floor (log_b x) [see computing log_b below]

then recursively compute the successive digits:

  a_i = floor r_i / b_i )

where r_n = x and

  r_(i-1) = r_i - a_i * b^i

for i = n, n - 1, ..., 1, 0

to convert between logarithms in different bases, the formula:

  log_b x = ln x / ln b

=end comment
#===========

sub from-dec-to-b37-b91(
    UInt $x'dec,
    UInt $base-o where ( 36 < $base-o < 63 ),
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Str
    ) is export(:_from-dec-to-b37-b91) {

    my UInt $len = $x'dec.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # see Wolfram's solution (article Base, see notes above)

    # need ln_b x = ln x / ln b

    # note Raku routine 'log' is math function natural log 'ln' if no optional base
    # arg is entered
    # my $log_b'x = log $x'dec / log $base-o;
    my $numerator   = log $x'dec;
    my $denominator = log $base-o;
    my $log_b'x = $numerator / $denominator;
    if $DEBUG {
        note qq:to/HERE/;
        DEBUG: sub from_dec_to_baseN
               input \$x'dec  = '{$x'dec}'
               input \$base-o = '$base-o';
               calculated ln \$x'dec = '$numerator';
               calculated ln \base-o = '$denominator';
               calculated \$log_b'x  = '{$log_b'x}';
        HERE
    }

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

        say "  i = $i; a = '@a[$i]'; r = '@r[$i]'" if 0 or $DEBUG;

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
} # from-dec-to-b37-b91


# exported subs

multi parts(
    $n,
    :$debug
    --> List
    ) is export(:parts) {

    # puts $n's parts in $int and $frac
    my $int = $n.truncate;
    my $frac = frac $n;

    $int, $frac;
} # end multi parts

multi parts(
    $n,
    $int is rw,
    $frac is rw,
    :$debug
    ) is export(:parts) {

    # puts $n's parts in $int and $frac
    $int = $n.truncate;
    $frac = frac $n;
} # end multi parts

sub frac(
    $n,
    :$base = 0,
    :$debug,
    ) is export(:frac) {

    # Note: Even though an arg may have a '.0' it will
    # be treated as an undefined value for the fractional
    # part.

    # For inputs as a string:
    # If the input is of base 91 it cannot
    # have a '.' as a radix point, otherwise it can only
    # have one '.'.
    my $is-str  = 0;
    my $is-allo = 0;
    if $n.^name eq 'Str' {
        ++$is-str;
        # check to see if it's an allomorph
        my $x = <<$n>>;
        my $typ = $x.^name;
        ++$is-allo if $typ ~~ /Int|Rat|Num/;
        # a crude check
        my $nc = 0;
        for $n.comb {
            ++$nc if $_ eq '.';
        }
        if !$is-allo {
            # need to determine if the base is 91
            if $nc {
                if $base == 91 {
                    note "WARNING: $n is base 91 with one or more periods.";
                    next;
                }
                elsif $nc > 1 {
                    note "WARNING: $n is not base 91 but it has multiple periods.";
                    next;
                }
            }
            note "WARNING: $n is not an allomorph ($typ)" if 1 || $debug;
            note qq:to/HERE/;
            Skipping for now until proper handling is implemented
            for non-allomorph strings as numbers
            HERE

            next;
        }
        note "WARNING: Number '$n' contains $nc radix chars ('.')" if $nc > 1;
    }

    my $num = $n.Num;
    my $f = $num.split('.')[1];
    my $i = $num.truncate;
    # any undefined fraction will be treated as zero
    $f = 0 if !$f.defined;

    if $debug {
        print qq:to/HERE/;
        DEBUG frac:
          input:     |$n|
          string?    |$is-str|
          name:      |{$n.^name}|
          .Num:      |$num|
          .truncate: |$i|
        HERE
        if $f.defined {
            say "  frac:      |$f|";
        }
        else {
            say "  frac:      |(undef)|";
        }
    }
    $f;
} # end sub frac

# was to-dec-from-b37-b91
# Extends routine 'parse-base' to base 91 for unsigned integers.
# Converts a string with a base (radix) of $base to its Numeric
# (base 10) equivalent.
sub str2num(
    $num is copy,
    UInt $base where 2..91
    --> Numeric
    ) is export(:str2num) {

    if $num.^name ~~ /Num|Int|Rat/ {
        return $num;
    }

    # adjust for Raku's convention
    if $base < 37 {
        $num .= uc;
    }
    # reverse the digits of the input number
    my @num'r = $num.comb.reverse;
    my $place = $num.chars;

    my UInt $dec = 0;
    for @num'r -> $digit {
	--$place; # first place is num chars - 1
	# need to convert the digit to dec first
	my $digit-val = %digit2dec{$digit};
	my $val = $digit-val * $base ** $place;
	$dec += $val;
    }

    if $DEBUG {
        note qq:to/HERE/;
        DEBUG: sub str2num
               input \$num      = '{$num}'
               input \$base     = '$base';
               calculated \$dec = '$dec';
        HERE
    }
    $dec;
} # str2num

# This version looks excellent for the integer part!
# was from-dec-to-b37-b91
multi sub num2str(
    UInt:D $dec,
    UInt:D $base
    --> Str
    ) is export(:num2str) {
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

=begin comment
# was from-dec-to-b37-b91
# Extends method 'base' to base 91 for unsigned integers.
# Converts an unsigned integer (base 10) to a string using base $base.
sub num2str(
    $num, # decimal integer
    UInt $base where 2..91
    --> Str:D
    ) is export(:num2str) {
    # my $log_b'x = log $x'dec / log $base-o;
    my $numerator   = log $num;
    my $denominator = log $base;
    my $log_b'x = $numerator / $denominator;
    if $DEBUG {
        note qq:to/HERE/;
        DEBUG: sub num2str
               input  \$num  = '{$num}'
               output \$base = '$base';
               calculated ln \$num  = '$numerator';
               calculated ln \$base = '$denominator';
               calculated \$log_b'x = '{$log_b'x}';
        HERE
    }

    # get place index of first digit
    my $n = floor $log_b'x;

    # now the algorithm

    # work through the $x'dec.chars places (????)
    # for now just handle integers (later, real, i.e., digits after a fraction point)
    my $x'b = '';
    my $ri = $num;
    for $n...0 -> $i {
        my $b'i = $base ** $i;
        my $ai = floor($ri / $b'i);
        note "  i = $i; a = '$ai'; r = '$ri'" if $DEBUG;
        $x'b ~= @dec2digit[$ai];

        # calc r for next iteration
	$ri = $ri - $ai * $b'i;
    }
    return $x'b;

    # trim leading zeroes
    $x'b ~~ s/^ 0+ /0/;
    #$x'b ~~ s:i/^ 0 (<[0..9a..z]>) /$0/;
    $x'b ~~ s:i/^ 0 (\S+) /$0/;

    return $x'b;
} # num2str
=end comment

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
} # sub create-set(

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
} # sub create-base-set(
