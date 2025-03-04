#!/usr/bin/env raku

use lib <../lib>;
use Number :frac, :parts;

my $debug = @*ARGS ?? 1 !! 0;

my @n = 1.2, 3.45678e2, .012, 1.0, 0xa, 0o10, 0b10, 45,
        '1.2', '3.45678e2', '.012', '1.0', '0xa', '0o10', '0b10', '45',
        'abc', 'xyz', 'a.b', 'a.b.c';

for @n {
    my $typ = $_.^name;

    my $f = frac $_, :$debug;
    $f = 'undef' if !$f.defined;
    say "$_, $f";
    next;

    =begin comment
    frac $_;
    =end comment

    #=begin comment
    my $int;
    my $frac;
    parts $_, $int, $frac;
    $frac = 'undef' if !$frac.defined;
    say "$_, $int, $frac";
    #=end comment
}
