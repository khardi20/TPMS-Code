function [ index ] = max_frequencies( rx, Fs, num_freqs )
%max_frequencies
%This function takes the rx signal, sample rate and the number of maxs to
%record
%this function then outputs the frequency of the peaks
%% Init vars
lenFFT = length(rx);
freq_scale = (Fs /2) / (lenFFT / 2);
freq = abs(fft(rx));
range = 10;
index(1:num_freqs) = 0;
%% Picks the max for each freq but makes sure that adjacent values dont interfere
for a = 1:num_freqs
[m,index(a)] = max(freq);
freq(index(a)) = 0;
if index(a) - range > 0 && index(a) + range <= length(freq)
freq(index(a)-range:index(a)+range) = 0;
elseif index(a) - range < 0
freq(1:index(a)+range) = 0;
freq(length(freq)+index(a)-range:length(freq)) = 0;
else
freq(index(a)-range:length(freq)) = 0;
freq(1:(index(a)+range)-length(freq)) = 0;
end
end
%% Calcs the frequency of the peak
for a = 1:num_freqs
if index(a) > lenFFT/2
index(a) = (index(a) - lenFFT) * freq_scale;
else
index(a) = index(a) * freq_scale;
end
end
end