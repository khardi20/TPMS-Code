function [ decoded ] = man_decode( encoded )
%man_decode
%This function takes in a manchester encoded signal and decodes it
x=floor(length(encoded)/2);
decoded = zeros(1, x);
%takes every other value starting at 1
for x = 1:2:length(encoded)
%making sure two succesive bits are not the same
if encoded(x) ~= encoded(x+1)
decoded((x+1)/2) = encoded(x);
else
decoded = -1;
break;
end
end
end