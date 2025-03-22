#!/usr/bin/env raku

my @s = "12345",
"12.345",
".12345",
"0.12345",
"12345.",
"12345.0";
;

for @s -> $num {
    my $res = $num.contains: '.';
    my @res = $num.split: '.';
    say "Input: '$num'";
    say "  contains '.': $res";
    say "  first part : '{@res.head}'";
    say "  second part: '{@res.tail}'";
}

