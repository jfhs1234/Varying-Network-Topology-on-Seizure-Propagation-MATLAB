function [] = activityVdist( exresmat,inresmat,timestep )
%% activity from 1 to 0 of wilson cowan nodes

% plots activity vs distance along one axis of the sheet at time stated in
% "timestep" argument 

nodes = size(exresmat,1);
n = sqrt(nodes);
nodegrid = reshape(1:nodes,[n,n]);
nodegrid = nodegrid';
centernod = nodegrid(n/2,n/2);
rowvec = nodegrid(n/2,:);
distmat = tordistmat(n);
distvec = distmat(centernod,:);

eresults = zeros(1,length(rowvec));
iresults = zeros(1,length(rowvec));
distances = zeros(1,length(rowvec));

for q=1:length(rowvec)
    eresults(q) = exresmat(rowvec(q),timestep);
    iresults(q) = inresmat(rowvec(q),timestep);
    distances(q) = distvec(rowvec(q)); % still not incorporated into final plot
end

plot(eresults)
xticks(5:10:95)
xticklabels(distances(5:10:95)./2)
ylim([0,1]); % limit for wilson-cowan measures
ylabel('Fractional Firing Rate of Wilson-Cowan Oscillator')
xlabel('Distance from Centre Node (mm)')
title('Activity along the central horizontal line of the sheet')
hold on
plot(iresults)
hold off
legend({'Excitatory','Inhibitory'})
end

