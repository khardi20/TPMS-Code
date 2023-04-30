function [FSK_signal] = FSK_modulator (unmodulated_signal)
mod_order = 2;
freq_sep = 73737;
Fs = 100e6/128;
nsamp = 50;
FSK_signal = fskmod(unmodulated_signal, mod_order, freq_sep, nsamp, Fs);
end