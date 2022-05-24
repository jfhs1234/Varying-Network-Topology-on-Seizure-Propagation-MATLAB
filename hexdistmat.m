function [ distmat ] = hexdistmat(n)
% create distance matrix (n x n nodes) layed in hexagonal formation
% with distance between node and surrounding 6 neighbours = 1
for p=1:n
    y((n*(p-1)+1):(p*n))=repmat((p-(p-1)*(1-sqrt(0.75))),1,n);
    if rem(p,2)==0
        x((n*(p-1)+1):(p*n))=1.5:n+0.5;
    else
        x((n*(p-1)+1):(p*n))=1:n;
    end
end

distmat = sqrt(((y - y').^2) + ((x - x').^2));

end

