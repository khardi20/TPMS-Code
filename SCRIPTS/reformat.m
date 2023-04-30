function [ array ] = reformat( vector, rows )
%Takes in a single demension array and formats it to multidemsional based
%on the number of rows given
columns = floor(length(vector)/rows);
array = zeros(columns, rows);
for ind = 1:columns
array(ind,:) = vector((ind-1)*rows + 1:ind*rows);
end
end