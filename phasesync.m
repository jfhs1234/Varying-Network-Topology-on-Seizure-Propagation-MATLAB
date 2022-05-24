function [meanR,R ] = phasesync(electrodeLFP,bandpass)

lowF = bandpass(1);
highF = bandpass(2);
N = size(electrodeLFP,2);
E = size(electrodeLFP,1);
nodes = size(electrodeLFP,1);
%% synchrony by time 
fh = zeros(nodes,N);
for q=1:E
    fh(q,:) = filterhilbert(electrodeLFP(q,:),1000,lowF,highF);
end

R = zeros(1,N);
for time=1:N
    anglevec = angle(fh(:,time));
    R(time) = abs(mean(exp(1i*anglevec)));
end

%% synchrony over entire trial for each electrode pair
% v=1;
% for q=1:E
%     for a=1:E
%         if q~=a
%             angles1 = angle(fh(q,:));
%             angles2 = angle(fh(a,:));
%             ISPC(v) = abs(mean(exp(1i*(angles1-angles2))));
%             v = v + 1;
%         end
%     end
% end

meanR = mean(R);
% meanISPC = mean(ISPC);

end


