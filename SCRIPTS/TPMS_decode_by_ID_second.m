function [preamble, ID, pressure, temp, flags, crc, packet] = TPMS_decode_by_ID_second( ID,TPMS_bits )
%this function assumes that the ID comes after the packet information
% this function takes the ID as a Hax string and the packet
%finds the start of the packet
[m, ind] = find_ID(ID, TPMS_bits);
ind = ind - length(TPMS_bits) + - 31;
%takes the preamble
preamble_bits = TPMS_bits(1:ind-1);

%decodes the rest of the packet
packet = man_decode(TPMS_bits());
%fills up each field with the bits then calculates the values
pressure_bits = packet(1:8);
temp_bits = packet();
ID_bits = packet();
flags = packet();
crc = packet(57:end);
count = 7:-1:0;
preamble = num2str(preamble_bits);
temp = sum(temp_bits .* 2.^count);
pressure = sum(pressure_bits .* 2.^count);
ID = dec2hex(sum(ID_bits .* 2 .^ (31:-1:0)));
%solves for a CRC pattern
CRC_pattern(packet, 9);
end


% function [ preamble, ID, pressure, temp, flags, crc, packet] = TPMS_decode_by_ID_first( ID, TPMS_bits )
% [m, ind] = find_ID(ID, TPMS_bits);
% ind = ind - length(TPMS_bits) + 1;
% preamble_bits = TPMS_bits(1:ind-1); %takes the preamble
% packet = man_decode(TPMS_bits(ind:ind+127));    %decodes the rest of the packet
% if length(packet) >= 64
% ID_bits = packet(1:32);%fills up each field with the bits then calculates the values
% pressure_bits = packet(33:40);
% temp_bits = packet(41:48);
% flags = packet(49:56);
% crc = packet(57:end);
% count = 7:-1:0;
% preamble = num2str(preamble_bits);
% temp = sum(temp_bits .* 2.^count);
% pressure = sum(pressure_bits .* 2.^count);
% ID = dec2hex(sum(ID_bits .* 2 .^ (31:-1:0)));
% else
% preamble = 0;
% temp = 0;
% pressure = 0;
% ID = '0';
% flags = 0;
% crc = 0;
% end