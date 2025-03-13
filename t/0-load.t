use Test;

use Number :ALL;

plan 3;

isa-ok Number, Number;
isa-ok Number::Subs, Number::Subs;
isa-ok Number::Vars, Number::Vars;
