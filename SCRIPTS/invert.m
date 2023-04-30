function [ out ] = invert( in )
%invert
% this function takes in a binary packet of ones and zeros and inverts each
% bit
out = in;
for x = 1:length(in)
out(x) = xor(1, out(x));
end
end