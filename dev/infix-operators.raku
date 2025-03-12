#!/usr/bin/env raku

use Slang::NumberBase;

multi infix:<+>(
    Numeric $x, 
    $y,
) {
    $x + $y
}
say ("1" + "2");

=begin comment
multi infix:<+>(
    $x where ( $x ~~ / \" (<[0..9a..zA..Z]>+) 
                       [
                         ('\x208' <[0..9]>)
                         ('\x208' <[0..9]>)?
                       ]?
                     \" $/
             ), 
    $y,
) {
#    $x + $y
 2
}
=end comment

my $x = "\x2082,1";
say ($x + "1");

#say ("1\x2082" + "2");

