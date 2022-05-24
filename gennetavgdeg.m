function [ sprmat, admat, meanid,prunenum ] = gennetavgdeg( n,exp,avgdeg )
%
%   n = length of row/column of spatial node matrix
%   exp = exponant of probability matrix (probmat^-exp)
%   avgdeg = desired average in degree for nodes


%distmat = hexdistmat(n);
distmat = tordistmat(n);

% probability matrix using negative of exponent
prmat = (distmat.^-exp);
prmat(isinf(prmat))=0;
prmat = (prmat.*avgdeg)./sum(prmat);
% creating adjacency matrix
admat = prmat > rand(n^2,n^2);

% increase edges until desired number
fixedges = (n^2)*avgdeg;
while nnz(admat)<fixedges
    ED = nnz(admat);
    prmat2 = prmat - 20.*admat;
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

sprmat = sparse(admat);
admat = single(admat);

end

