function [stimnodes] = stimnodenum(admat)
%   admat = adjacency matrix
%   stimnodes = node number of nodes to be stimulated        
%    
%   picks one node at random and all nodes with outgoing connection from it

nodes=size(admat,1);
x = randi(nodes); % initial node to be stimulated
stimnodes = find(admat(x,:));
stimnodes = stimnodes';

%% stimulate grid square
% x = randi(ns^2/n^2);
% nodes = 1:n^2;
% nodegrid = reshape(nodes,[n,n]);
% v = 1;
% for q=1:(n/ns)
%     for r=1:(n/ns)
%         subsqrgrid = nodegrid(ns*(q-1)+1:ns*q,ns*(r-1)+1:ns*r);
%         submap(:,v) = subsqrgrid(:);
%         v = v + 1;
%     end
% end
% 
% stimnodes = submap(:,x);
% stimnodes = stimnodes';

end


