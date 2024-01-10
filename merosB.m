% source
src = load('source.mat').t;
% prediction and error
prediction = zeros(size(src));
error = zeros(size(src));
% number of samples used for prediction
p = 5;
% autocorrelation matrix
R = zeros(p,p);
% autocorrelation vector
r = zeros(1,p);
for num=p+1:size(src,1)
    % matrix calculation
    for i=1:p
        % matrix rows
        for j=1:p
            % matrix columns
            if j==1
                R(i,j) = R(i,j) + src(num) * src(num-i);
                r(i)=r(i)+R(i,1);
            else
                R(i,j) = R(i,j) + src(num-j) * src(num-i);
            end
        end
    end
end
R = R/(size(src,1)-p);
r = r/(size(src,1)-p);
a = R\r';
[centers , quantizedCoefficients] = uniform_quantizer(a,8,-2,2);
