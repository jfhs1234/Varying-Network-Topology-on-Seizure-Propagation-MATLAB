function [ delaycons,delaymat] = addDelay(adjmt,dt)
% get delay times for all connections of given adjacency matrix

n2 = size(adjmt,1);
n = sqrt(n2);
distmat = tordistmat(n);
distmat = distmat.*0.5; % convert to distance in mm
c_v = 2; % speed in m/s
c_v = (c_v*1000); % speed in mm/s
delaymat = ceil(distmat./(c_v*dt)); % time delay in seconds % delay in timesteps

delaymat(~adjmt) = 0;
dim3 = max(max(delaymat));

delaycons = {};
for z=1:dim3
    [row,col] = find(delaymat==z);
    delaycons{z} = sparse(row,col,1,n2,n2);
end

end

