#!/usr/bin/env raku

use Number :ALL;
use Number::Subs :ALL;
use Number::Wolfram :ALL;

use lib "./t";
use Helpers;

my $debug = 0;

my $ofil = "t/90-base2-base36-round-trip-tests.t";

if $debug {
    my $nrands = 10;
    my @uints = 1..5;
    for 0..^5 {
        srand 5;
        my $n = @uints.roll($nrands).join;
        say $n if $_;
    }
    exit;
}

my $data = 0;
my $test = 0;
if not @*ARGS {
    print qq:to/HERE/;
    Usage: {$*PROGRAM} <mode> [debug]

    Modes:
      data - generate the data file
      test - generate the test file
    
    HERE
    exit;
}

for @*ARGS {
    when /^ de / {
        ++$debug;
    }
    when /^ d / {
        ++$data;
    }
    when /^ t / {
        ++$test;
    }
    default {
        note "FATAL: Unknown arg '$_'";
        exit;
    }
}

if $test {
my $fh = open $ofil.IO.absolute, :w;
$fh.print: q:to/HERE/;
# WARNING - THIS FILE IS AUTO-GENERATED - EDITS MAY BE LOST
# See ./gen-all-base-tests.raku for the generating source

use Test;
use Number :ALL;
use Number::Subs :ALL;
use Number::Wolfram :ALL;

#plan 97;

my $r; # exe results to test
my $length = 4; 

# temp ending
is 1, 1;

done-testing;
HERE
$fh.close;

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
    if $debug {
        say "chars for base $base:";
        print "  ";
        print "$_ " for @digits;
        say();
    }

    # get two random sets of $N digits
    # example from librasteve:
    my @n1 = @digits.roll: $N1;
    my $n1 = @n1.join("");
    my @n2 = @digits.roll: $N2;
    my $n2 = @n2.join("");
    my $set1 = ($n1 ~ '.' ~ $n2);
    say $set1 if 0 or $debug;

    # get another two random sets of $N digits
    # negate the second sets
    my @n3 = @digits.roll: $N1;
    my $n3 = @n3.join("");
    $n3 = "-" ~ $n3;
    my @n4 = @digits.roll: $N2;
    my $n4 = @n4.join("");
    my $set2 = ($n3 ~ '.' ~ $n4);
    say $set2 if 0 or $debug;

    # create the actual test set:
    my $dec1 = parse-base $set1, $base;
    my $dec2 = parse-base $set2, $base;
    say "$set1 $dec1 $base" if 0 or $debug;   
    say "$set2 $dec2 $base" if 0 or $debug;   

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
    say "See output test file: '$ofil'";
}
 
