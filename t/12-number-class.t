use Test;

use Number :ALL;
use Number::Subs :ALL;

=begin comment
Number in: '1234', base in: 11, decimal value: 1610
Number in: '-1234', base in: 11, decimal value: -1610
Number in: '123.4', base in: 11, decimal value: 146.363636
Number in: '-123.9', base in: 11, decimal value: -146.818182
=end comment

my ($o);

$o = Number.new: :number<\x[2088]11>;
isa-ok $o, Number, "inline embedded base indicator, leading";
#is $o.base, 8, "base 8";
is $o.number, <\x[2088]11>, "number ok, leading";
say "decimal: ", $o.decimal;
say "base: ", $o.base;

# temp end
done-testing;
exit;

$o = Number.new: :number<11\x[2088]>;
isa-ok $o, Number, "inline embedded base indicator, trailing";
#is $o.base, 8, "base 8";
is $o.number, <11\x[2088]>, "number ok, trailing";
say $o.number;
say $o.decimal;
#is $o.number, "-123.4", "self.number is correct, with angle brackets";

$o = Number.new: :number<-123.4>, :base(10);
isa-ok $o, Number;
is $o.number, "-123.4", "self.number is correct, with angle brackets";
is $o.decimal, "-123.4", "self.decimal is correct, with angle brackets";
is $o.base, 10, "base 10";

$o = Number.new: :number(1234), :base(11);
isa-ok $o, Number;
is $o.number, "1234", "self.number is correct";
is $o.decimal, "1610", "self.decimal is correct";

$o = Number.new: :number<1234>, :base(11);
isa-ok $o, Number;
is $o.number, "1234", "self.number is correct, with angle brackets";
is $o.decimal, "1610", "self.decimal is correct";
is $o.base, 11, "base 11";

$o = Number.new: :number<-123.4>, :base(11);
isa-ok $o, Number;
is $o.number, "-123.4", "self.number is correct, with angle brackets";
is $o.decimal, "-146.363636", "self.decimal is correct, with angle brackets";
is $o.base, 11, "base 11";

dies-ok {
    $o = Number.new: :number(1234), :base(1);
}, "invalid base 1";

dies-ok {
    $o = Number.new: :number(1234), :base(92);
}, "invalid base 92";

done-testing;

=begin comment
Number in: '1234', base in: 10, decimal value: 1234
Number in: '-1234', base in: 10, decimal value: -1234
Number in: '123.4', base in: 10, decimal value: 123.4
Number in: '-123.9', base in: 10, decimal value: -123.9
=end comment

=begin comment
# used to calculate expected test values
my @n = < 1234 -1234 123.4 -123.9 >;
my @b = 10, 11;
for @b -> $b { for @n -> $n {
        my $dec = parse-base $n, $b;
        say "Number in: '$n', base in: $b, decimal value: $dec"
    } }
=end comment
