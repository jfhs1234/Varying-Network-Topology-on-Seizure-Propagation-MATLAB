function [ hilbertized,filtdata ] = filterhilbert( results,samplingrate,lowerfilt,upperfilt )

nyquist = samplingrate/2;
tw = 0.2; % transition width

filtfreqs = [0 , (1-tw)*lowerfilt , lowerfilt , upperfilt , ...
            (1+tw)*upperfilt , nyquist]./nyquist;
order = round(2*(samplingrate/lowerfilt));
filtshape = [0 0 1 1 0 0];

filtweights = firls(order,filtfreqs,filtshape);

filtdata = filtfilt(filtweights,1,double(results));
hilbertized = hilbert(filtdata);

end

