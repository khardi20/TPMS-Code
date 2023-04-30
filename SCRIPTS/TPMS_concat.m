function [ out, samples ] = TPMS_concat( in )
% This function takes in the input signal in the form of a multidemensional
% array and concatenates them into a single demension
[x, y] = size(in);
out = zeros(1, x*y);
samples = 1:x*y;
for a = 0:x-1
out(a*y+1:(a+1)*y) = in(a+1,:);
end
end