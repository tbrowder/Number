#!/usr/bin/env raku

use Number :ALL;
use Number::Subs :ALL;
use Number::Wolfram :ALL;

use lib "./t";
use Helpers;

my $debug = 0;

# Wolfram
# the data files to be generated or used
my $dfil1 = "t/data/int-number-rebase.dat";
my $dfil2 = "t/data/real-number-rebase.dat";

# the test files to be generated;
my $ofil1 = "t/90-int-base2-36-round-trip.t";
my $ofil2 = "t/90-real-base2-36-round-trip.t";

my $data  = 0;
my $test  = 0;
my $force = 0;

if not @*ARGS {
    print qq:to/HERE/;
    Usage: {$*PROGRAM} <mode> [int|debug|force]

    Creates tests for the Wolfram method of rebasing integral
      and real numbers.

    Modes:
      data - generate the data files
      test - generate the test files

    HERE
    exit;
}

for @*ARGS {
    when /^ de / {
        ++$debug;
    }
    when /^ f / {
        ++$force;
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

if $data {
    FIL: for ($dfil1, $dfil2).kv -> $i, $f {
        my $int = $i == 0 ?? True !! False;
        if $f.IO.r {
            if $force {
                say "Over-writing test data file: $f";
            }
            else {
                say "Test data file '$f' exists, use \$force to over-write";
                next FIL;
            }
        }
        # call the sub
        write-test-data-wolfram :dfil($f), :$int, :$debug;
    }
}

if $test {
    FIL: for ($ofil1, $ofil2).kv -> $i, $f {
        my $df  = $i == 0 ?? $dfil1 !! $dfil2;
        my $int = $i == 0 ?? True !! False;
        if $f.IO.r {
            if $force {
                say "Over-writing test file: $f";
            }
            else {
                say "Test file '$f' exists, use \$force to over-write";
                next FIL;
            }
        }
        # call the sub
        # sub write-test-wolfram(
        # :$dfil!, # the file with test data
        # :$ofil!, # the test file to be generated
        write-test-wolfram :dfil($df), :ofil($f);
        say "See output test file: '$f'";
    }
}
