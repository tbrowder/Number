use Test;

use Number :ALL;

plan 4;

isa-ok Number, Number;
isa-ok Number::Subs, Number::Subs;
isa-ok Number::Vars, Number::Vars;
isa-ok Number::Wolfram, Number::Wolfram;
