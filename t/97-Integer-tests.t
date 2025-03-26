use Test;

use Number::Wolfram;

my $n = "1234";

$n = PadDigits $n, 3;
is $n.chars, 4;
is $n, "1234";

$n = PadDigits $n, 6;
is $n.chars, 6;
is $n, "001234";

#$n = IntegerDigits $n, 10, 6;
done-testing;
