function [ Noise ] = addnoise(n,ns,t,dt)
% Noise input for nodes with subsquares recieving same noise
%   n = grid dimenson[1]
%   ns = subsquare dimension[1]
%   t = simulation time
%   dt = timestep

tsteps = t/dt+1;
randnoise = randn((n^2)/(ns^2),tsteps);
nodes = 1:n^2;
nodegrid = reshape(nodes,[n,n]);
v = 1;
for q=1:(n/ns)
    for r=1:(n/ns)
        subsqrgrid = nodegrid(ns*(q-1)+1:ns*q,ns*(r-1)+1:ns*r);
        Noise(subsqrgrid(:),:) = repmat(randnoise(v,:),ns^2,1);
        v = v + 1;
    end
end
  
end

