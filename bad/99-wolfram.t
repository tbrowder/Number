use Test;

use Number::Wolfram :ALL;

=begin comment

From Wolfram regarding base changes for real numbers:

...For example, the hexadecimal representation of 0.1 (which
terminates in decimal notation) is the infinite expression 0.19999..._h.

=end comment

my $debug = 0;

my ($num-i, $num-o, $base-i, $base-o);

$num-i = 0;
$base-i = 10;
$base-o = 2;
$num-o = w-rebase :$num-i, :$base-i, :$base-o, :$debug;
is $num-o, "0", "0 input, 0 output";
say "DEBUG: num-o = $num-o" if $debug;

$num-i = 3;
$base-i = 10;
$base-o = 2;
$num-o = w-rebase :$num-i, :$base-i, :$base-o, :$debug;
is $num-o, "11";
say "DEBUG: num-o = $num-o" if $debug;

$num-i = -3;
$num-o = w-rebase :$num-i, :$base-i, :$base-o, :$debug;
is $num-o, "-11";
say "DEBUG: num-o = $num-o" if $debug;

dies-ok {
    $num-i = '3.';
    $num-o = w-rebase :$num-i, :$base-i, :$base-o, :$debug;
}, "FATAL: should have one or more digits after a radix point";

$num-i = 3.1;
$num-o = w-rebase :$num-i, :$base-i, :$base-o, :$debug;
is $num-o, "11";
say "DEBUG: num-o = $num-o" if $debug;

# test a known conversion from decimal to hexadecimal for a real
# number
# 0.1 in decimal notation) is the infinite expression 0.19999..._h.
$num-i = 0.1;
$num-o = w-rebase :$num-i, :base-i(10), :base-o(16), :$debug;
is $num-o, "0.199999";
say "DEBUG: num-o = $num-o" if $debug;



done-testing;

