function [ TPMS_signal, modulated_signal, bin_ID, bin_press, bin_temp] = TPMS_transmitter(...
dec_temperature, dec_pressure, ID )
[bin_temp, bin_press] = decimal_to_binary(dec_temperature, dec_pressure);
bin_ID = Hex_to_Bin(ID);
flags = [1 1 1 0 0 0 0 1];
[data] = [bin_temp bin_press bin_ID flags];
checksum = comm.CRCGenerator('Polynomial', [1 1 1 0 1 0 1 0 1]);
CRC_data = step(checksum, data.');
unencoded_data = [CRC_data.'];
encoded_data = man_encode (unencoded_data);
preamble = step(comm.BarkerCode('Length', 13, 'SamplesPerFrame', 23)).';
fixed_preamble = fix_preamble(preamble);
unmodulated_signal = [fixed_preamble encoded_data];
modulated_signal = FSK_modulator(unmodulated_signal);
TPMS_signal = [modulated_signal; modulated_signal; modulated_signal];
end