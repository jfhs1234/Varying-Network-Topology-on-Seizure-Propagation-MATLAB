function [ prmat, prmat2 ] = gennetdens(n,exp,avgdeg)
%
%   n = length of row/column of spatial node matrix
%   exp = exponant of probability matrix (probmat^-exp)
%   edgeden = desired edge density in percent, will always give same number
%   of edges by randomly removing/adding them after initial assignment

distmat = hexdistmat(n)

% probability matrix using negative of exponent
prmat = (distmat.^-exp);
prmat(isinf(prmat))=0;
prmat2 = (prmat*avgdeg)/sum(prmat);
% creating adjacency matrix
admat1 = prmat > rand(n^2,n^2);
vari = nnz(admat1);
admat = admat1;

% % calculating wiring using gaussian curve
% prmat = normpdf(distmat);
% s = size(prmat,1);
% prmat(1:(s+1):end)=0;

edges = (edgeden/100)*((n^2)*((n^2)-1));

while nnz(admat) > edges
        t = randi(n^2); 
        u = randi(n^2);
        admat(t,u) = 0;
end

while nnz(admat) < edges
        t = randi(n^2); 
        u = randi(n^2);
        admat(t,u) = 1;
end

end


