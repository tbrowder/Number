use Test;

use UUID::V4;

use Number :ALL;
use Number::Subs :ALL;

my $debug = 0;

# test clases and fractions
# binary, octal, decimal, and hexadecimal

my ($o, $base, $number);

my @bases = 2..91;

my @bnums = <10 10.1>;
my @onums = <42 42.1>;
my @hnums = <42 42.1 e2 e2.a>;

my @dnums = <42 42.1>; #  0d18.1>;
for @dnums -> $number {
    say "base 10 number: '$number', gist: '{$number.gist}'";
    $o = Number.new: :$number, :base(10);
    isa-ok $o, Number, "it's a Number class object";
    #next;

    if $number.Str.Numeric == 42 {
        is $o.number, "42", "its .number attr is 42";
        is $o.integer.Str.Numeric, 42, "integer: 42";
#       is $o.fraction.Int, 0, "fraction: 0";
    }
    elsif $number.Str.Numeric == 42.1 {
        is $o.number, "42.1", "its .number attr is 42.1";
#       is $o.integer.Int, '42', "integer: '42'";
#       is $o.fraction, '0.1', "fraction: '0.1'";
    }
}
done-testing;
=finish

for @bnums -> $number {
    $o = Number::Rebase::NumObj.new: :$number, :base(2);
    isa-ok $o, Number::Rebase::NumObj;
}
for @onums -> $number {
    $o = Number::Rebase::NumObj.new: :$number, :base(8);
    isa-ok $o, Number::Rebase::NumObj;
}
for @hnums -> $number {
    $o = Number::Rebase::NumObj.new: :$number, :base(16);
    isa-ok $o, Number::Rebase::NumObj;
}

# check all the bases
for @bases -> $base {
    my $number = "1.1";
    $o = Number::Rebase::NumObj.new: :$number, :base(16);
    isa-ok $o, Number::Rebase::NumObj;
}

dies-ok {
    my $number = "1.1";
    $o = Number::Rebase::NumObj.new: :$number, :base(1);
}, "invalid base 1";

dies-ok {
    my $number = "1.1";
    $o = Number::Rebase::NumObj.new: :$number, :base(92);
}, "invalid base 92";

done-testing;
