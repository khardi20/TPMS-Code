function [ m, ind ] = find_ID( ID, signal )
%find_ID
%This function takes the ID in Hex and the packet and solves for the
%location of the ID within the packet using corr
% The function outputs the max value and its index
%% Convert the ID to bin and then encode it
ID_binary = Hex_to_Bin(ID);
encoded_ID = man_encode(ID_binary);
%% perform corr and take the max val and index
acor = xcorr(signal, encoded_ID);
figure
plot(1:length(acor), acor)
xlabel('Index')
ylabel('Correlation')
title('Correlation of Encoded ID and Encoded TPMS Packet')
[m, ind] = max(acor);
end