#!/usr/bin/env raku

use Test;
use Number :ALL;

my $o;

my $s = "\x2083";
say $s.comb.head, " <= subscript 3 (hex char 2083)";
$s = $s.comb.head;
say $s.ord, " <= subscript 3 (decimal char 8323)";

say qq:to/HERE/;
Routine 'ord' coerces the invocant or argument
to Str and shows the Unicode code point number of the 
first code point (and ignores the rest). The inverse 
operation is 'chr'.

Mnemonic: returns an ordinal number.

Routine 'chr' coerces the invocant or argument to Int, interprets
it as a Unicode code point and
returns a Str made of that code point.

Mnemonic: turns an integer into a character.
HERE

$s = $s.ord;
say $s.base(16), " <= subscript 3 (hex char 2083)";
say $s.Numeric, " <= subscript 3 (decimal char 8323)" ;
say $s.Numeric, " <= subscript 3 (decimal char 8323)" ;

my $t = "\x2083\x[2084]23";
say $t.comb.join, " <= subscript 34 (base 34, number 23)";

my $u = "0o33";
say $u, " <= octal number 33";
say $u.ord.Numeric, " <= octal number 33, decimal 48";


say "for docs:";
my $x = "abcd";
say ($x ~~ Int), " Str '$x' is NOT an Int";
say $x.ord, " .ord of the first char in '$x'";;
say 'a'.ord, " .ord of char 'a'";;

my $z = "0o11"; #234";
$o = Number.new: :number($z);
say $o.number;
say $o.decimal;
is $o.decimal, 9;

=finish


#$x = "abc";
#say $x.ord;

my $o = Number.new: :number($x);
say $o.number;
say $o.decimal;

