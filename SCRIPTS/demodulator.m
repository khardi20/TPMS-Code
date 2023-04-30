function [ packet] = demodulator( rx, Fs )
%demodulator
% Takes in the packet and the sample rate
%This function determines if it uses ASK or FSK and then demodulates the
%signal and passes the demodulated packet out
%perform the FFT and get magnitude
freq = abs(fft(rx));
figure(3)
plot(1:length(freq), freq)
%range to prevent side bins from influencing results
range = 10;
[max1,ind1] = max(freq);
%Determines the two max bins that are not closely adjacent
if ind1 - range > 0 & ind1 + range <= length(freq)
freq(ind1-range:ind1+range) = 0;
elseif ind1 - range < 0
freq(1:ind1+range) = 0;
freq(length(freq)+ind1-range:length(freq)) = 0;
else
freq(ind1-range:length(freq)) = 0;
freq(1:(ind1+range)-length(freq)) = 0;
end
[max2, ind2] = max(freq);
%determines if the second frequency is large enough to be FSK
if max2 > max1/2
[packet] = FSK_demodulator(rx,Fs);
else
[packet] = ASK_demodulator(rx);
end
end