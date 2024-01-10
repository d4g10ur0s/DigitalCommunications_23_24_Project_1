% Load the image
img = imread("parrot.png");
% Convert pixel values to binary representation
bI = reshape((dec2bin(typecast(img(:),'uint8'),8)-'0').',1,[]);
% Ervthma 2a
combinedSymbols = reshape(bI, 2, numel(bI)/2).';
combinedSymbols = bi2de(combinedSymbols, 'left-msb');
uniqueValues = unique(combinedSymbols);
[counts, values] = histcounts(combinedSymbols, 'BinMethod', 'integers');
normalizedCounts = counts / numel(combinedSymbols);
disp('Unique Values and Frequencies:');
disp([values(1:end-1); counts]);
disp('Normalized Frequencies (Probability):');
disp(normalizedCounts);
% Huffman dictionary
huffmanDict = huffmandict(uniqueValues, normalizedCounts);
% Encode values
symbolCellArray = num2cell(combinedSymbols);
encodedData = huffmanenco(symbolCellArray, huffmanDict);
% Display Huffman dictionary and encoded data
disp('Huffman Dictionary:');
disp(huffmanDict);
% Ervthma 1b
originalLength = numel(combinedSymbols);
encodedLength = numel(encodedData);
compressionRatio = originalLength / encodedLength;
disp(['Original Length: ', num2str(originalLength)]);
disp(['Encoded Length: ', num2str(encodedLength)]);
disp(['Compression Ratio: ', num2str(compressionRatio)]);
