#!/usr/bin/env raku

use lib "./t";
use Helpers;

my $ofil = "./t/11-real-number-tests.t";
my $fh = open $ofil, :w;

my $length = 20;

$fh.print: qq:to/HERE/;
# WARNING - THIS FILE IS AUTO-GENERATED - EDITS MAY BE LOST
# See ./make-real-number-tests.raku for the generating source

use Test;
use Number :ALL;

#plan 97;

my \$r; # exe results to test
my \$length = $length; 
HERE

#my @bases-i = 2..36;
my @bases-i = 2, 8, 10, 16; # ..36;

my @bases-o = @bases-i;
my $num = "1000";
my $r;

# track number of tests
my $n = 0;
for @bases-i -> $bi {
    for @bases-o -> $bo {
       ++$n; write-test-base $num, :$bi, :$bo, :$fh, :nl;  # newline: first test in group
       ++$n; write-test-base $num, :$bi, :$bo, :$fh, :$length; 
       ++$n; write-test-base $num, :$bi, :$bo, :$fh, :prefix;
       ++$n; write-test-base $num, :$bi, :$bo, :$fh, :prefix, :$length;
       ++$n; write-test-base $num, :$bi, :$bo, :$fh, :suffix; 
       ++$n; write-test-base $num, :$bi, :$bo, :$fh, :suffix, :$length; 

       # special test for hex output: :LC
       next unless ($bi == 10) and ($bo == 16);
       ++$n; write-test-base 16, :$bi, :$bo, :$fh, :prefix, :$length, :LC; 
    }
}

$fh.say: "\ndone-testing;";
$fh.close;
say "See new test file: '$ofil' ($n tests)";


