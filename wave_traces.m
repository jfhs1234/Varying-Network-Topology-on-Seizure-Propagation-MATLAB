function [] = wave_traces(resmat,gap,plotnum,timestart,timeend)

% resmat = results matrix
% gap = unit jump between nodes of each trace
% plotnum = number of plots (plotnum*gap can not exceed 1/2 width of sheet)
% timestart = start timestep
% timeend = end timestep

nodes = size(resmat,1);
n = sqrt(nodes);
nodegrid = reshape(1:nodes,[n,n]);
nodegrid = nodegrid';

for q=1:plotnum
    nodepos = nodegrid(n/2,n-q*gap); % altered to start from far right side
    subplot(plotnum,1,q);
    plot(resmat(nodepos,timestart:timeend));
end

end

