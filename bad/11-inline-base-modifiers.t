use Test;

use Number :ALL;
use Number::Subs :ALL;

# Test variations of inline base modifiers

#plan 6;

=begin comment
-₁₁10.1

-10.1₁₁

₆₂
₆₂
=end comment

my $A = '-10.1';
my $a = '-₁₁10.1';
my $b = '-10.1₁₁';
my $c = "-10.1\x2081\x2081";
my $d = "-10.1\x[2081]\x[2081]";
my $e = "-\x2081\x2081,10.1";
my $f = "-\x[2081]\x[2081]10.1";

my $r = -11.090909; # result from raku: $X.parse-base: 11

my $base;
my $r2 = parse-base2 $A, $base;
is $r2, $r;

$r2 = parse-base2 $a, $base;
is $r2, $r;

done-testing;
=finish

$r2 = parse-base2 $b;
is $r2, $r;

$r2 = parse-base2 $c;
is $r2, $r;

$r2 = parse-base2 $d;
is $r2, $r;

$r2 = parse-base2 $e;
is $r2, $r;

$r2 = parse-base2 $f;
is $r2, $r;

