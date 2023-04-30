function [ packet ] = ASK_demodulator(rx)
%ASK_demodulator
% Function performs ASK demodulation of the TPMS packet
%% Variable setup
interp_val = 2;
rx_interp = interp(rx, interp_val);
lenRx = length(rx_interp);
rx_rect = abs(rx_interp);
threshold = max(rx_rect/2);
%figure
%plot(1:lenRx, rx_rect)
%% Demodulation
rx_square = zeros(1, lenRx);
for x = 1:lenRx
if rx_rect(x) > threshold
rx_square(x) = 1;
end
end
%figure
%plot(1:lenRx, rx_square);
%% Down sampling
packet = down_sample(rx_square);
end