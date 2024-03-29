% Load the image
img = imread("parrot.png");
% get unique values
uniqueValues = unique(img(:));
numValues = length(uniqueValues);

orderedPairs = [];
for i = 1:numValues
    for j = 1:numValues
        orderedPairs = [orderedPairs; uniqueValues(i), uniqueValues(j)];
    end
end

% get the frequency of values
counts = zeros(size(orderedPairs,1),1);
[m, n] = size(img);
for col=1:n
    currentColumn = img(:,col);
    for c=1:size(orderedPairs,1)
        for ro=1:2:m
            if(orderedPairs(c,1)==currentColumn(ro) && orderedPairs(c,2)==currentColumn(ro+1))
                counts(c)=counts(c)+1;
            end 
        end
    end
end
% normalize frequencies , it is probability now
probs = counts/sum(counts(:));
disp('Unique Values');
disp(orderedPairs');
disp('Counts of Unique Values');
disp(counts');
disp('Probability of Unique Values');
disp(probs');
% Create custom labels for pairs
symbolLabels = cell(size(orderedPairs, 1), 1);
for i = 1:size(orderedPairs, 1)
    symbolLabels{i} = [num2str(orderedPairs(i, 1)),num2str(orderedPairs(i, 2))];
end
% Compute Huffman dictionary
huffmanDict = huffmandict(symbolLabels, probs);
% compute entropy of symbols
entropyValue = 0;
for i=1:size(probs,1)
    if (probs(i)~=0)% some symbols have 0 probability...
        entropyValue = entropyValue + -sum(probs(i) * log2(probs(i)));
    end
end
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
