function  [ statefreq ] = nodestate2( resmat)
% statefreq(1,:) = upper
% statefreq(2,:) = middle
% statefreq(3,:) = lower

n2 = size(resmat,1);
tsteps = size(resmat,2);
statefreq = zeros(3,tsteps);
for node=1:n2
    for t=1:tsteps
        state = resmat(node,t);
        if state<0.1
            statefreq(3,t) = statefreq(3,t)+1;
        elseif state>0.9
             statefreq(1,t) = statefreq(3,t)+1;
        elseif state>0.1 && state<0.9
            statefreq(2,t) = statefreq(2,t)+1;
        end
    end
end
statefreq = statefreq'; % for ease of plotting
end

