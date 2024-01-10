% Load the image
img = imread("parrot.png");
% get unique values
uniqueValues = unique(img);
% get the frequency of values
counts = zeros(size(uniqueValues));
[m, n] = size(img);
for col=1:n
    currentColumn = img(:,col);
    for c=1:size(uniqueValues)
        for ro=1:m
            if(uniqueValues(c)==currentColumn(ro))
                counts(c)=counts(c)+1;
            end 
        end
    end
end
% normalize frequencies , it is probability now
probs = counts/sum(counts(:));
disp('Unique Values');
disp(uniqueValues');
disp('Counts of Unique Values');
disp(counts');
disp('Probability of Unique Values');
disp(probs');
% compute huffman dictionary
huffmanDict = huffmandict(uniqueValues, probs);
% compute entropy of symbols
entropyValue = -sum(probs .* log2(probs));
disp(['Entropy of Huffman Encoding: ', num2str(entropyValue)]);
% compute average code length
averageCodeLength = 0;
for i=1:size(huffmanDict,1)
    a=huffmanDict(i,2);
    averageCodeLength=averageCodeLength+length(a{1})*probs(i);
end
disp(['Average Code Length: ', num2str(averageCodeLength)]);
% Compute Code Performance
codePerformance = entropyValue / averageCodeLength;
disp(['Code Performance: ', num2str(codePerformance)]);
%
% Ervthma 4
%
% Display Huffman dictionary and encoded data
disp('Huffman Dictionary:');
disp(huffmanDict);
% reshape , so that it fits
reshapedImage= reshape(img, 1, numel(img)).';
encodedData = huffmanenco(reshapedImage, huffmanDict);
decoded=huffmandeco(encodedData,huffmanDict);
imshow(reshape(decoded,m,n))
% Compute Compress Ratio
binaryRep=reshape((dec2bin(typecast(img(:),'uint8'),8)-'0').',1,[]);
compressRatio=numel(encodedData)/numel(binaryRep);
disp(['Compress Ratio: ', num2str(compressRatio)]);