function [newadj ] = addlongdist( adjmat,exp,numb )
% adjmat = adjacency matrix to be changed
% numb = number of long distance connections to be added]
% exp = exponent for distance matrix to create distribution of long
%       distance connections to be randomly added to adjmat
    

n2 = size(adjmat,1);
n = sqrt(n2);
distmat = tordistmat(n);


prmat = (distmat.^exp);
prmat(logical(eye(size(prmat)))) = 0;
prmat = (prmat)./sum(prmat);
% find positions of long distance nodes
[row,col] = find(prmat>rand(n2,n2));

% add long distance nodes whilst removing random connection
for i=1:numb
    add = randi(length(row));
    if adjmat(row(add),col(add))==0
        adjmat(row(add),col(add)) = 1;
        [rmvr,rmvc] = find(adjmat);
        rmvnum = length(rmvr);
        rmv = randi(rmvnum);
        adjmat(rmvr(rmv),rmvc(rmv)) = 0;
    end
    
end


newadj = adjmat;

end

