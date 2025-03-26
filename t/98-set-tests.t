use Test;

use Number::Subs;
use Number::Vars;

my $C = create-set "ab";
my $D = create-set "abc";
is $C (<=) $D, True;

my $E = create-set "12";
is $E (<=) $D, False;

my $txt = "12a";
is valid-base-set($txt, :base(16)), True; 
is valid-base-set($txt, :base(11)), True; 
is valid-base-set($txt, :base(10)), False; 

$txt = "12B";
is valid-base-set($txt, :base(16)), True; 
is valid-base-set($txt, :base(37)), True; 

done-testing;



