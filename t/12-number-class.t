use Test;

use Number :ALL;
use Number::Subs :ALL;

my $o = Number.new: :number(1234), :base(11);
isa-ok $o, Number;

dies-ok {
    my $o = Number.new: :number(1234), :base(1);
}

dies-ok {
    my $o = Number.new: :number(1234), :base(92);
}

done-testing;

