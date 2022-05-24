function [ distmat ] = tordistmat( n )

for p=1:n
    y((n*(p-1)+1):(p*n))=repmat((p-(p-1)*(1-sqrt(0.75))),1,n);
    if rem(p,2)==0
        x((n*(p-1)+1):(p*n))=1.5:n+0.5;
    else
        x((n*(p-1)+1):(p*n))=1:n;
    end
end

disty = min(abs(y-y'),n-abs(y-y'));
distx = min(abs(x-x'),n-abs(x-x'));

distmat = sqrt(disty.^2 + distx.^2);

end

