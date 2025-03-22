#!/usr/bin/env raku

say "Showing routine 'roll' error with constant 'srand' seed.";
say();

my $nrands = 5;
my @uints = 1..4;
for 0..^5 {
    srand 5;
    my $n = @uints.roll($nrands).join(" ");
    say $n;
}

