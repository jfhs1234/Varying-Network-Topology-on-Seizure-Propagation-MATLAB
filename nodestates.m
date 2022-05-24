function [ statefreq ] = nodestates( resmat,window )
% statefreq(1,:) = upperfixed
% statefreq(2,:) = bistable
% statefreq(3,:) = lowerfixed

n2 = size(resmat,1);
tsteps = size(resmat,2);
timewindows = window+1:window:tsteps;
statefreq = zeros(3,length(timewindows));

for t=1:length(timewindows)
    for node=1:n2
        activ = mean(resmat(node,(t-1)*window+1:t*window));
        if activ<=0.1
            statefreq(3,t) = statefreq(3,t)+1;
        end
        if activ>=0.9
             statefreq(1,t) = statefreq(1,t)+1;
        end
        if activ>0.1 && activ<0.9
            statefreq(2,t) = statefreq(2,t)+1;
        end
    end
end

end

