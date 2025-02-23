use Test;

use UUID::V4;
use Number::Rebase :ALL;

my $debug = 0;

# test clases and fractions
# decimal, octal, and hexadecimal

my ($o, $base, $number);

my @bases = 2..91;

my @bnums = <10 10.1>;
my @onums = <42 42.1>;
my @dnums = <42 42.1>;
my @hnums = <42 42.1 e2 e2.a>;

for @bnums -> $number {
    $o = Number::Rebase::NumObj.new: :$number, :base(2);
    isa-ok $o, Number::Rebase::NumObj;
}
for @onums -> $number {
    $o = Number::Rebase::NumObj.new: :$number, :base(8);
    isa-ok $o, Number::Rebase::NumObj;
}
for @dnums -> $number {
    $o = Number::Rebase::NumObj.new: :$number, :base(10);
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
