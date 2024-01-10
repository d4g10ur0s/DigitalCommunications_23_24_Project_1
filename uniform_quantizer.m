function [centers,quantizedSignal] = uniform_quantizer(y, N, min_value, max_value)
    % Define quantization levels
    quantizationLevels = 2^N;
    % Calculate quantization step size
    quantizationStep = (max_value - min_value) / quantizationLevels;
    % Calculate centers
    centers = zeros(quantizationLevels,1);
    for i=1:quantizationLevels
        if i==1
            centers(i,1) = (2*min_value+quantizationStep)/2;
        elseif i==quantizationLevels-1
            centers(i,1) = (2*max_value-quantizationStep)/2;
        else
            centers(i,1) = (2*min_value+(2*i+1)*quantizationStep)/2;
        end
    end
    % Reverse order , so that max value is centers(1)
    centers = flip(centers);
    % Quantize the signal
    quantizedSignal = zeros(size(y,1),1);
    for i=1:size(y,1)
        for j=1:quantizationLevels
            % Put break statement for speed up
            if y(i)>=max_value
                quantizedSignal(i)=1;
                break;
            elseif y(i)<min_value
                quantizedSignal(i)=quantizationLevels;
                break;
            elseif y(i)<min_value+(j+1)*quantizationStep && y(i)>=min_value+j*quantizationStep
                quantizedSignal(i)=j+1;
                break;
            end
        end
    end
end