function [ down ] = down_sample( packet )
%down_sample
% This function takes in a packet with excess bits from demodulation. and
% downsamples based on the small number of consequtive bits
%% Starts a litte in because sometimes the first bits are compromised
ind = 50;
val = packet(ind);
lenPacket = length(packet);
%% finding the start of the next change so it does not throw off count
while packet(ind) == val && ind < lenPacket
ind = ind + 1;
end
%% Calculates the min number of consequtive bits and is the default single bit
min_count = lenPacket;
while ind < lenPacket-20
val = packet(ind);
count = 0;
while packet(ind) == val && ind < lenPacket
count = count + 1;
ind = ind + 1;
end

if count < min_count
min_count = count;
end
end
%% performs the down sampling based on the min count above
down = 0;
down_ind = 1;
ind = 1;
while ind < lenPacket
val = packet(ind);
count = 0;
while packet(ind) == val && ind < lenPacket
count = count + 1;
ind = ind + 1;
end
count = floor((count)/min_count);
if count == 0
count = 1;
end
a = 1;
while a <= count
down(down_ind) = val;
down_ind = down_ind + 1;
a = a+1;
end
end
end
