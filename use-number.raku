#!/usr/bin/env raku

use Number :ALL;

my $o = Number.new: :number(1234);
say $o.number;
say $o.base;

$o = Number.new: :number<1234>;
say $o.number;
say $o.base;
