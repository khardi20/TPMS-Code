function [ encoded_signal ] = man_encode( signal )
%man_encode
% this function takes in a packet and manchester encodes it
%encoded signal is twice the length
encoded_signal = zeros(1, 2*length(signal));
for x = 1:2:length(encoded_signal)
if signal((x+1)/2) == 1
encoded_signal(x) = 1;
else
encoded_signal(x) = 0;
end
encoded_signal(x+1) = xor(encoded_signal(x), 1);
end
end