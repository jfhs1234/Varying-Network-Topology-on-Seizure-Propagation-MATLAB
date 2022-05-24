function [ stimnodes ] = stimnodeclus( n,size)

% will stimulate the middle node in the grid
% size = radius of nodes to be stimulated

nodes = n^2;
nodegrid = reshape(1:nodes,[n,n]);
nodegrid = nodegrid';
stimnod1 = nodegrid(n/2,n/2); % identifying number for centre node
distmat = hexdistmat(n);
distvec = distmat(stimnod1,:); 
advec = distvec < size;
stimnodes = find(advec);
stimnodes = stimnodes';
end

