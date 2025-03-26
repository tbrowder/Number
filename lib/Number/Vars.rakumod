unit module Number::Vars;

constant \radix-point is export = '.';

# Standard digit set for bases 2 through 91 (char 0 through 91).
# The array of digits is indexed by their decimal value.
our @dec2digit is export = [
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', # 10
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', # 20
    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', # 30
    'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', # 40
    'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', # 50
    'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', # 60
    'y', 'z', '!', '#', '$', '%', '&', '(', ')', '*', # 70
    '+', ',', '"', '/', ':', ';', '<', '=', '>', '?', # 80
    '@', '[', ']', '^', '_', '`', '{', '|', '}', '~', # 90
    '.',                                              # 91
    ];
# Standard digit set for bases 2 through 91 (char 0 through 91).
# The hash is comprised of digit keys and their decimal value.
our %digit2dec is export = @dec2digit.antipairs;
