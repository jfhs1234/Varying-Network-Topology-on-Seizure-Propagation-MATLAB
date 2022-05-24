function [ stdmat ] = nodestd(resmat,window )
% returns matrix of standard deviation of each node for each time window

n2 = size(resmat,1);
tsteps = size(resmat,2);
t = floor(tsteps/window);
stdmat = zeros(n2,t);

for j=1:n2
    for q=1:t
        activity = resmat(j,(q-1)*window+1:q*window+1);
        stdmat(j,q) = std(activity);
    end
end

end

