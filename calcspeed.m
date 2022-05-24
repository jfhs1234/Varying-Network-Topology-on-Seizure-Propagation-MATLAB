function [ speeds ] = calcspeed(resmat,stimsize,mindist)

n2 = size(resmat,1);
n = sqrt(n2);
distmat = tordistmat(n);

ct = findstartpeak(resmat,0.6);
nodegrid = reshape(1:n2,[n n])';
centnod = nodegrid(n/2,n/2);
start = ct(centnod);

stimnodes = stimnodeclus(n,stimsize);
centredistvec = distmat(centnod,:);
distveccentretostim = centredistvec(stimnodes);
maxdistfromcentre = max(distveccentretostim);
ring = stimnodes(distveccentretostim>maxdistfromcentre-2);

distvec = zeros(n2,1);
% calculating the closest distance to outer ring of stimulation site
for node=1:n2
    distchoice = distmat(node,ring);
    distvec(node) = min(distchoice);
end

speeds = zeros(n2,1);


for q=1:length(speeds)
    if distvec(q)>mindist && ct(q,1)>1
        time = ct(q,1)-start;
        speeds(q) = (distvec(q)*0.5)./(0.001*(time));
    end
end

speeds = speeds(speeds~=0);
speeds = speeds(speeds~=Inf);

% speed in mm/s

end
