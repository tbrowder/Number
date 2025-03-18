my $s = "\x2083";
say $s.comb.head, " <= subscript 3 (hex char 2083)";
say $s.comb.head.ord, " <= subscript 3 (decimal char 8323)" ;
say $s.comb.head.ord.base(16), " <= subscript 3 (hex char 2083)";
say $s.comb.ord.Numeric, " <= subscript 3 (decimal char 8323)" ;

my $t = "\x2083\x[2084]23";
say $t.comb.join, " <= subscript 34 (base 34, number 23)";

my $u = "0o33";
say $u, " <= octal number 33";
say $u.ord.Numeric, " <= octal number 33, decimal 48";
