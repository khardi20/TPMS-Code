function [packet] = TPMS_receiver( TPMS_signal )
%TPMS_recevier
% This function takes in the received signal from a TPMS and will
% demodulate and decoded the packet
% close all
clc
% Sample rate used on USRP
Fs = 250000;
%These are the thresholds used to determine if a signal is present
power_threshold = 2*bandpower(TPMS_signal(1,:));
threshold = 3.25* power_threshold;
%% Reformatting Signal
rows = 5000;
TPMS_signal = TPMS_concat(TPMS_signal);
TPMS_signal = reformat(TPMS_signal, rows);
%% Traverse the entire received signal looking for TPMS signal
[r,c] = size(TPMS_signal);
ind = 1;
while ind <= r-2
[rx, t] = TPMS_concat(TPMS_signal(ind:ind+2,:));
%if there is an significant increase power that means that there is a
%TPMS signal
if bandpower(rx(1:2*rows)) > power_threshold
%locating the start point
lower_ind = 1;
while bandpower(rx(lower_ind:lower_ind+10)) < threshold && lower_ind < 2*rows - 10
lower_ind = lower_ind + 1;
end
%locating the end point
upper_ind = length(rx);
while bandpower(rx(upper_ind-10:upper_ind)) < threshold && upper_ind > 1
upper_ind = upper_ind - 1;
end
%holds the wave form of just the packet (no noise)
packet_waveform = rx(lower_ind:upper_ind);
%demodulate the packet
packet = demodulator( packet_waveform, Fs );
%decode the packet
decode_packet(packet)
ind = ind +2;
end
ind = ind + 1;
end
% figure
% plot(1:length(packet_waveform), real(packet_waveform));
end