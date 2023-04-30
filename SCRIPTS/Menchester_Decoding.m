%% Menchester Decoding
function [Menchester_Decode_out] = Menchester_Decoding(Menchester_decode_input)
inp_len = length(Menchester_decode_input);
Menchester_Decode_out = zeros(1,inp_len/2);
for i=1:2:inp_len
    if(Menchester_decode_input(i) == 0 && Menchester_decode_input(i+1) == 1)
        Menchester_Decode_out((i+1)/2) = 1;
    else
        Menchester_Decode_out((i+1)/2) = 0;
    end
end