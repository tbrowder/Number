unit module Helpers;

use Number::Vars :ALL;

# we do NOT write any tests that are expected to fail (such as using :prefix
# and :suffix at the same time

# this sub writes test data for sub w-rebase
sub write-test-data-wolfram(
    :$debug,
) is export {

    # produces data lines in this format:
    #   string.num   base    decimal-result
    # plan
    #   For bases 2..36 generate a set of M strings N chars long split by
    #       a '.' (radix point), then a space, then the base number..
    #
    my $M  =  2; # one negative
    my $N1 = 12; # left side of the radix point
    my $N2 =  5; # right side of the radix point

    for 2..36 -> $base {
        # get the digit array
        my @digits = @dec2digit[0..^$base];
        if 0 and $debug {
            say "chars for base $base:";
            print "  ";
            print "$_ " for @digits;
            say();
        }

        # get two random sets of $N digits
        # example from librasteve:
        srand 5;
        my @n1 = @digits.roll: $N1+1;
        @n1.shift; # bad num
        my $n1 = @n1.join("");

        my @n2 = @digits.roll: $N2+1;
#       @n2.shift; # bad num
        my $n2 = @n2.join("");
        my $set1 = ($n1 ~ '.' ~ $n2);

        say $set1 if 0 or $debug;

        # get another two random sets of $N digits
        # negate the second sets
        my @n3 = @digits.roll: $N1+1;
#       @n3.shift; # bad num
        my $n3 = @n3.join("");
        $n3 = "-" ~ $n3;

        my @n4 = @digits.roll: $N2+1;
#       @n4.shift; # bad num
        my $n4 = @n4.join("");
        my $set2 = ($n3 ~ '.' ~ $n4);
        say $set2 if 0 or $debug;

#       # create the actual test set:
#       my $dec1 = parse-base $set1, $base;
#       my $dec2 = parse-base $set2, $base;
#       say "$set1 $dec1 $base" if 0 or $debug;
#       say "$set2 $dec2 $base" if 0 or $debug;

        =begin comment
        # the actual tests
        # num2string
        $r = num2string $dec1, :$base;
        is $r, $set1;
        $r = num2string $dec2, :$base;
        is $r, $set2;

        # string2num
        $r = string2num $set1, :$base;
        is $r, $dec1;
        $r = string2num $set2, :$base;
        is $r, $dec2;
        =end comment

    }

}


sub write-test-wolfram(
    # this writes tests for sub wolfram-rebase
) is export {
}

sub write-test-rebase(
    # this writes tests for sub rebase
    $num,
    :$bi where ( $bi ~~ /2|8|10|16/ ),
    :$bo where ( $bo ~~ /2|8|10|16/ ),
    :$fh,
    # optional arguments
    :$nl is copy, # just for separating groups of tests
    :$length is copy,
    :$prefix is copy,
    :$suffix is copy,
    :lower-case(:lc(:$LC)) is copy,
    ) is export {
}

sub write-test-base(
    # this writes tests the family of subs X2Y (e.g., bin2oct)
    $num,
    :$bi where ( $bi ~~ /2|8|10|16/ ),
    :$bo where ( $bo ~~ /2|8|10|16/ ),
    :$fh,
    # optional arguments
    :$nl is copy, # just for separating groups of tests
    :$length is copy,
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    ) is export {

    $nl     = 0 unless $nl.defined;
    $length = 0 unless $length.defined;
    $prefix = 0 unless $prefix.defined;
    $suffix = 0 unless $suffix.defined;
    $LC     = 0 unless $LC.defined;

    my $BI;
    my $BO;
    with $bi {
        when /2/  { $BI = "bin" }
        when /8/  { $BI = "oct" }
        when /10/ { $BI = "dec" }
        when /16/ { $BI = "hex" }
    }
    with $bo {
        when /2/  { $BO = "bin" }
        when /8/  { $BO = "oct" }
        when /10/ { $BO = "dec" }
        when /16/ { $BO = "hex" }
    }

    # typical tests
    #   $r = hex2hex $num;
    #   is $r, $num;
    #   $r = hex2hex $num, :prefix;
    #   is $r, "0x1";
    $fh.say() if $nl;
    $fh.print: "\$r = {$BI}2$BO\(";
    # $num must be real for dec input
    if $BI == 10 {
        $fh.print: $num;
    }
    else {
        $fh.print: "'$num'";
    }

    if $length {
        $fh.print: ", :\$length";
    }
    if $prefix {
        $fh.print: ", :prefix";
    }
    elsif $suffix {
        $fh.print: ", :suffix";
    }
    if $LC {
        $fh.print: ", :LC";
    }
    $fh.say: ");";

    # write the actual tests
    if $length and $prefix {
        $fh.say: "is \$r.chars, $length;";
    }
}
