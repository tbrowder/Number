use Test;

use Number::Wolfram :ALL;

my $debug = 0;
my ($num-i, $num-o, $base-i, $base-o);

$num-i = 3;
$base-i = 10;
$base-o = 2;
$num-o = w-rebase :$num-i, :$base-i, :$base-o, :$debug;
is $num-o, "11";
say "num-o = $num-o";

$num-i = -3;
$num-o = w-rebase :$num-i, :$base-i, :$base-o, :$debug;
is $num-o, "-11";
say "num-o = $num-o";

$num-i = 3.1;
$num-o = w-rebase :$num-i, :$base-i, :$base-o, :$debug;
is $num-o, "11";
say "num-o = $num-o";

done-testing;

