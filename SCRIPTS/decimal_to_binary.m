function [ bin_temperature, bin_pressure ] = decimal_to_binary( dec_temperature, dec_pressure )
bin_temperature = de2bi(dec_temperature, 8, 'left-msb');
bin_pressure = de2bi(dec_pressure,8, 'left-msb');
end