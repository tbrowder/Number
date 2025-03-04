#!/usr/bin/env raku

use lib <../lib>;
use Number :frac, :parts;

my $debug = @*ARGS ?? 1 !! 0;

my @n = <
    0d123
    '0d123'
    1.2
    3.45678e2
    .012
    1.0 
    0xa 
    0o10 
    0b10 
    45
    '1.2'
    '3.45678e2'
    '.012'
    '1.0'
    '0xa'
    '0o10' 
    '0b10' 
    '45'
    'abc' 
    'a.b' 

    'xyz' 
    'a.b.c'
>;

for @n -> $n {
    my $typ = $n.^name;
    say "input: |$n| ^name: $typ";
    if $n ~~ /^ "'"? 0 (b|o|x|d) / {
        say "  it looks like a typed number";
    }
    next;

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
