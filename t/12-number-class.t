use Test;

use Number :ALL;
use Number::Subs :ALL;

=begin comment
Number in: '1234', base in: 11, decimal value: 1610
Number in: '-1234', base in: 11, decimal value: -1610
Number in: '123.4', base in: 11, decimal value: 146.363636
Number in: '-123.9', base in: 11, decimal value: -146.818182
=end comment

$o = Number.new: :number<-123.4>, :base(10);
isa-ok $o, Number;
is $o.number, "-123.4", "self.number is correct, with angle brackets";
is $o.decimal, "-123.4", "self.decimal is correct, with angle brackets";

my $o = Number.new: :number(1234), :base(11);
isa-ok $o, Number;
is $o.number, "1234", "self.number is correct";
is $o.decimal, "1610", "self.decimal is correct";

$o = Number.new: :number<1234>, :base(11);
isa-ok $o, Number;
is $o.number, "1234", "self.number is correct, with angle brackets";
is $o.decimal, "1610", "self.decimal is correct";

$o = Number.new: :number<-123.4>, :base(11);
isa-ok $o, Number;
is $o.number, "-123.4", "self.number is correct, with angle brackets";
is $o.decimal, "-146.363636", "self.decimal is correct, with angle brackets";

dies-ok {
    my $o = Number.new: :number(1234), :base(1);
}, "invalid base 1";

dies-ok {
    my $o = Number.new: :number(1234), :base(92);
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
