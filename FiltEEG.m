function [output] = FiltEEG(LFP, order, sampleRate, cutoff, type)

% cutoff = 1Hz to remove DC frequency
% order = 4 (size of the filter kernel)

nyquist=sampleRate/2;
cutoff=cutoff./nyquist;

[b, a] = butter(order, cutoff ,type); 
LFP = double(LFP);
output = filtfilt(b, a, LFP); 

end