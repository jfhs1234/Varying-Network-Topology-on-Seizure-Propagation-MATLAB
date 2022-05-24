function [ admat] = gennetlattice( n,avgdeg )
%
%   n = length of row/column of spatial node matrix
%   avgdeg = desired average in degree for nodes

% creating x and y co-ordinates of nodes
distmat = tordistmat(n);

admat = zeros(size(distmat));

for node=1:n^2
    distvec = distmat(node,:);
    [~,I] = sort(distvec);
    admat(node,I(2:avgdeg+1)) = 1;
end
% 
% 
% % in degree for first adjacency matrix
% fixedges = (n^2)*avgdeg;
% while nnz(admat)<fixedges
%     ED = nnz(admat);
%     prmat2 = prmat - 10.*admat;
%     prmat2(prmat2<0)=0;
%     prmat2 = (prmat2.*abs(avgdeg-(ED/n^2)))./sum(prmat2);
%     admat2 = prmat2>rand(n^2,n^2);
%     admat = admat + admat2;
% end
% 
% % prune extra adges
% if nnz(admat)>fixedges
%     prunenum = nnz(admat) - fixedges;
%     [row,col] = find(admat,prunenum*100+1);
%     admat(row(1:50:prunenum*50+1),col(1:50:prunenum*50+1)) = 0;
% end
% 


end
