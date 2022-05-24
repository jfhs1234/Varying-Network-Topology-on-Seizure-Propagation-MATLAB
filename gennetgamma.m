function [ admat, meanid,prunenum ] = gennetgamma( n,a,b,avgdeg )
%
%   n = length of row/column of spatial node matrix
%   a = unimodal peak of gamma
%   b = scalar of gamma
%   avgdeg = desired average in degree for nodes

% creating x and y co-ordinates of nodes
distmat = tordistmat(n);

% probability matrix using negative of exponent
prmat = gampdf(distmat,a,b);
prmat(isinf(prmat))=0;
prmat = (prmat.*avgdeg)./sum(prmat);
% creating adjacency matrix
admat = prmat > rand(n^2,n^2);
admat = single(admat);

% in degree for first adjacency matrix
fixedges = (n^2)*avgdeg;
while nnz(admat)<fixedges
    ED = nnz(admat);
    prmat2 = prmat - 10.*admat;
    prmat2(prmat2<0)=0;
    prmat2 = (prmat2.*abs(avgdeg-(ED/n^2)))./sum(prmat2);
    admat2 = prmat2>rand(n^2,n^2);
    admat = admat + admat2;
end

% prune extra adges
if nnz(admat)>fixedges
    prunenum = nnz(admat) - fixedges;
    [row,col] = find(admat,prunenum*100+1);
    admat(row(1:50:prunenum*50+1),col(1:50:prunenum*50+1)) = 0;
end

id = sum(admat,1);
meanid = mean(id);
% % calculating wiring using gaussian curve
% prmat = normpdf(distmat);
% s = size(prmat,1);
% prmat(1:(s+1):end)=0;



end
