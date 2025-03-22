#!/usr/bin/env raku

use Number :ALL;
use Number::Subs :ALL;
use Number::Wolfram :ALL;

use lib "./t";
use Helpers;

my $debug = 0;

my $ofil = "t/90-base2-base36-round-trip-tests.t";

my $data = 0;
my $test = 0;
if not @*ARGS {
    print qq:to/HERE/;
    Usage: {$*PROGRAM} <mode> [debug]

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
    write-test-data-wolfram :$debug;
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

    say "See output test file: '$ofil'";
}
