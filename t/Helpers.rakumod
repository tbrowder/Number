unit module Helpers;

use Text::Utils :strip-comment;

use Number :ALL;
use Number::Wolfram :ALL;
use Number::Subs :ALL;

# We do NOT write any tests that are expected to fail (such as using :prefix
# and :suffix at the same time

# this sub writes test data for sub w-rebase
sub write-test-data-wolfram(
     :$dfil!,
Bool :$int!,
     :$trim = 0,
     :$debug,
) is export {

    my $fh = open $dfil.IO.absolute, :w;
    if $int {
        $fh.print: qq:to/HERE/;
        # base X int number | base X |  decimal int number equivalent (base 10)
        #    (created by gen..raku)

        HERE
    }
    else {
        $fh.print: qq:to/HERE/;
        # base X real number | base X |  decimal real number equivalent (base 10)
        #    (created by gen..raku)

        HERE
    }

    # produces data lines in this format:
    #   number number-base  decimal-equiv  (numbers may be int or real)
    #   
    # plan
    #   For bases 2..36 generate a set of M strings N chars long.
    #
    my $M  =  2; # one negative
    my $N1 = 12; # integer
    my $N2 =  5; # fraction

    for 2..36 -> $base {
        # get the digit array for the given base
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
        my @int = @digits.roll: $N1+1;
        @int.shift; # bad num
        my $int = @int.join;

        my $int1 = $int;
        # negate
        my $int2 = '-' ~ $int1;

        my @frac = @digits.roll: $N2+1;
        my $frac = @frac.join;
        my $real1 = $int ~ '.' ~ $frac;
        my $real2 = '-' ~ $real1;

        say $real1 if 0 or $debug;

        # create the actual test sets:
        my $dec-int1 = parse-base $int1, $base;
        my $dec-int2 = parse-base $int2, $base;

        my $dec-real1 = parse-base $real1, $base;
        my $dec-real2 = parse-base $real2, $base;

        if $trim {
            =begin comment
            # trim fraction to $trim chars max
            my ($int1, $frac1) = $dec1.split('.');
            my ($int2, $frac2) = $dec2.split('.');

            my $nc1 = $frac1.chars;
            my $nc2 = $frac2.chars;

            if $nc1 > $trim {
                $frac1 = $frac1.comb[0..^$trim].join;
            }
            if $nc2 > $trim {
                $frac1 = $frac2.comb[0..^$trim].join;
            }

            # reassemble
            $dec1 = $int1 ~ '.' ~ $frac1;
            $dec2 = $int2 ~ '.' ~ $frac2;
            =end comment
        } # end trim block

        # string.num   base    decimal-result
        if $int {
            $fh.say: "$int1  $base  $dec-int1";
            $fh.say: "$int2  $base  $dec-int2";
        }
        else {
            $fh.say: "$real1  $base  $dec-real1";
            $fh.say: "$real2  $base  $dec-real2";
        }

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
    $fh.close;
}

sub write-test-wolfram(
     :$dfil!, # the file with test data
     :$ofil!, # the test file to be generated
) is export {
    # this writes tests for sub w-rebase
    my $fh = open $ofil, :w;

    $fh.print: qq:to/HERE/;
    use Test;

    use Number :ALL;
    use Number::Wolfram :ALL;

    my \$res;

    HERE

    my $sink;
    my ($base, $bnum, $dnum);

    my @lines = $dfil.IO.lines;
    for @lines -> $line is copy {
        $line = strip-comment $line;
        next unless $line ~~ /\S/;

        my @s = $line.words;

        $bnum = "{@s.shift.lc}";
        $base = @s.shift;
        $dnum = "{@s.shift.lc}";

        $fh.print: qq:to/HERE/;
        \$res = w-rebase :num-i('$bnum'), :base-i($base), :base-o(10);
        is \$res, '$dnum';

        \$res = w-rebase :num-i('$dnum'), :base-i(10), :base-o($base);
        is \$res, '$bnum';

        HERE

    } # end of loop

    $fh.print: qq:to/HERE/;

    done-testing;
    HERE

    $fh.close;

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
