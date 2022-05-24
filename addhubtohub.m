function [ newadj,hubs ] = addhubtohub( adjmat,numb )
% adjmat = adjacency matrix to be changed
% numb = number of hub to hub connections to be added

n2 = size(adjmat,1);

for i=1:numb
    deg = sum(adjmat,1) + sum(adjmat,2)'; % degree = indegree+outdegree
    orderdeg = sort(deg);
    percentile_index = ceil(n2*0.95); % finds position of 95th percentile
    thresholddeg = orderdeg(percentile_index); 
    hubs = find(deg>thresholddeg);
    hub1 = randi(length(hubs));
    hub2 = randi(length(hubs));
    [row,col] = find(adjmat);
    rmvnum = length(row);
    rmv = randi(rmvnum);
    adjmat(row(rmv),col(rmv)) = 0;
    if adjmat(hubs(hub1),hubs(hub2))==1
            hub1 = randi(length(hubs));
            hub2 = randi(length(hubs));
    else
        adjmat(hubs(hub1),hubs(hub2))=1;
    end
    
end

newadj = adjmat;
end

