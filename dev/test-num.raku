#!/usr/bin/env raku

use lib <../lib>;
use Number::Rebase::number;

my $a1 = Number::Rebase::number.new: 0xa; # integer value 10
my $a2 = Number::Rebase::number.new: '0xa'; # integer value 10
say $a1.num.^name;
say $a2.num.^name;

my $d1 = Number::Rebase::number.new: 2.1234e2; 
my $d2 = Number::Rebase::number.new: <2.1234e2>; 
say $d1.num.^name;
say $d1.num;
say $d1.integer;
say $d1.fraction;

say $d2.num.^name;
say $d2.num;
say $d2.integer;
say $d2.fraction;


my $b1 = Number::Rebase::number.new: 0b10; # integer value 2
my $b2 = Number::Rebase::number.new: '0b10'; # integer value 2
say $b1.num.^name;
say $b2.num.^name;

my $c1 = Number::Rebase::number.new: 0o10; # integer value 8
my $c2 = Number::Rebase::number.new: '0o10'; # integer value 8
say $c1.num.^name;
say $c2.num.^name;

=finish

