function [ f,mx ] = fourierT( results,fs )
% fs = Sampling frequency
length = size(results,2);

X = fft(results,length);
X = X(1:ceil(length/2));

% magnitude
mx = abs(X);
% frequency vector
% f = (0:ceil(length/2)-1)*fs/length; 
DF = fs/length; % frequency increment
f = 0:DF:fs/2;

end

