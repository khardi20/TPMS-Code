function [ good_patterns ] = CRC_pattern( packet, p )
%CRC_pattern
% this function takes in the packet and the length of the pattern and
% solves for a CRC pattern using brute force
%% init vars
dec_nums = 0:2^p-1;
pattern_str = dec2bin(dec_nums);
pattern = zeros(2^p, p);
%% initializing the patterns array that will be checked
for x = 1:2^p
for y = 1:length(pattern_str(x,:))
pattern(x,y)= str2double(pattern_str(x,y));
end
end
n = length(packet);
k = n - p + 1;
pattern(2^(p-1)+1,:);
good_patterns = zeros(1, p);
good = 1;
%% cycles through all potential patterns
for y = 2^(p-1)+1:2^p
y;
x = 1;
div = packet(1:1);
a = 0;
while div(1) == 0 && x+a < k
div(1:end-1) = div(2:end);
div(end) = packet(x+a+p);
a = a + 1;
end
x = a + x;
while x < k
div = xor(div, pattern(y,:));
a = 0;
while div(1) == 0 && x+a < k
div(1:end-1) = div(2:end);
div(end) = packet(x+a+p);
a = a + 1;
end
x = a + x;
end
% If the pattern works put it in the good patterns array
if sum (div == zeros(1,p)) == p || sum(div == pattern(y,:)) == p
good_patterns(good, :) = pattern(y,:);
good = good + 1;
end
end
end
