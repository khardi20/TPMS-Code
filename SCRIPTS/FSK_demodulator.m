function [ packet] = FSK_demodulator( rx, Fs )
%FSK_demodulator
%This function performs FSK demodulation on the signal and outputs the
%packet
%% variable intialization
lenRx = length(rx);
t = (1:lenRx)/Fs;
interp_val = 20;
bits_per_packet = 750;
samp_per_sym = floor(interp_val * lenRx / bits_per_packet);
down_samp = interp_val * lenRx - bits_per_packet * samp_per_sym;
interval = floor(interp_val * lenRx / down_samp);
%% Adjusting the offset frequency
freq = max_frequencies(rx, Fs,2);
offset = -(freq(1) + freq(2))/2;
mod_sig = exp(j*2*pi*t*offset);
rx = rx .* mod_sig;
%% Calculating the freq separation
freq = max_frequencies(rx, Fs, 2);
freq_sep = abs(freq(1)) + abs(freq(2));
%% downsamples so there is an symbols per bits divides evenly
down_samp_sig = zeros(1, bits_per_packet * samp_per_sym);
rx_interp = interp(rx, interp_val);
for y = 1:down_samp
down_samp_sig((y-1) * (interval-1) + 1:y * (interval - 1)) = rx_interp((y-1) * interval + 1:y * interval - 1);
end
%% Demodulates packet
over_packet = invert(fskdemod(down_samp_sig,2,freq_sep,samp_per_sym, Fs*interp_val));
%% Because more bits were output than needed a downsample is used
packet = down_sample(over_packet);
%figure
%plot(1:lenRx, abs(fft(rx)))
end