function [fixed_preamble] = fix_preamble( preamble )
preamble(preamble < 0) = 0;
fixed_preamble = preamble;
end