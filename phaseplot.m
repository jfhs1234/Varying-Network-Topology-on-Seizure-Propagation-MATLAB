function [convresult ] = phaseplot( results,fs,sr )
% plot time vs phase for time series data. 
% code adapted from "Analyzing Neural Time Series Data" Mike X Cohen, 2014
% fs (desired frequency for phase plot) can not be greater than nyquist of 
% sr (sampling rate)

% create wavelet
time = -1:1/sr:1;
s = (4/(2*pi*fs))^2; % n/2.pi.frequency, n defines number of wavelet cycles
wavelet = exp(2*1i*pi*fs.*time) .* exp(-time.^2./(2*s)/fs);

% lengths for fft
resultslen = size(results,2);
wavelen = length(wavelet);
conlen = wavelen+resultslen-1;
halfwavelen = (wavelen-1)/2;
timeseries = 0:1/sr:round(resultslen/sr);

% fft wavelet and results
wavefft = fft(wavelet,conlen);
eegfft = fft(results,conlen);

% inverse fft and trim the multiplication product of fft's
convresult = ifft(wavefft.*eegfft,conlen) * sqrt(s);
convresult = convresult(halfwavelen+1:end-halfwavelen);

% subplot(2,1,1)
% plot(timeseries,abs(convresult).^2)
% subplot(2,1,2)
% plot(timeseries,angle(convresult))

end


