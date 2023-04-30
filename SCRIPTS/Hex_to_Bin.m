function [ bin ] = Hex_to_Bin(ID)
%Hex_to_Bin
% this function takes in the ID in a hex string and converts it to a
% binary array
binStr = dec2bin(hex2dec(strcat('A',ID)));
bin = zeros(1, length(binStr));
for x = 1:length(bin)
bin(x)= str2double(binStr(x));
end
bin = bin(5:end);
end