#!/usr/bin/env raku

use Number :ALL;
use Number::Subs :ALL;
use Number::Wolfram :ALL;

use lib "./t";
use Helpers;

my $debug = 0;

# the data file to be generated or used
my $dfil = "t/data/real-number-rebase.dat";
# the test file to be generated;
my $ofil = "t/90-base2-base36-round-trip-tests.t";

my $data  = 0;
my $test  = 0;
my $force = 0;
my $int   = 0; # no real tests

if not @*ARGS {
    print qq:to/HERE/;
    Usage: {$*PROGRAM} <mode> [int|debug|force]

    Creates tests for the Wolfram method of rebasing integral
      and real numbers.

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
    when /^ f / {
        ++$force;
    }
    when /^ i / {
        ++$int;
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
    if $dfil.IO.r {
        if $force {
            say "Over-writing test data file: $dfil";
        }
        else {
            say "Test data file '$dfil' exists, use \$force to over-write";
            say "Exiting...";
        }
    }

    write-test-data-wolfram :$int, :$debug;
}

if $test {
    if $ofil.IO.r {
        if $force {
            say "Over-writing test file: $ofil";
        }
        else {
            say "Test file '$ofil' exists, use \$force to over-write";
            say "Exiting...";
        }
    }

    # call the sub
    # sub write-test-wolfram(
    # :$dfil!, # the file with test data
    # :$ofil!, # the test file to be generated
    write-test-wolfram :$dfil, :$ofil, :$int;

    =begin comment
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
    =end comment

    say "See output test file: '$ofil'";
}
