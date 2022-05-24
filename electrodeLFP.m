function [ macroLFP ] = electrodeLFP( LFP,n,ns )
% calculate electrode LFP by summing all LFPs in grids using guassian
% to reduce the influence of periphery nodes on summed recording
midpos = ns/2;
nodegrid = reshape(1:n^2,n,n)';
distmat = tordistmat(n);
macroLFP = zeros((n/ns)^2,size(LFP,2));

centrow = midpos:ns:n-midpos;
centcol = midpos:ns:n-midpos;
centernodes = zeros(1,length(centrow)*length(centcol));

% saves the number of the central node of each grid to variable, to return
% layout of these use transposed reshape function (similar to sheet)
v = 1;
for j=1:length(centcol)
    for k=1:length(centrow)
        centernodes(v) = nodegrid(centrow(k),centcol(j)); 
        v = v + 1;
    end
end

for q=1:length(centernodes)
    macroL = zeros(1,size(LFP,2));
    distvec = distmat(centernodes(q),:);
    advec = distvec < 8; %% size of the electrode field here
    lfpnodes = find(advec);
    for p=1:length(lfpnodes)
        % normpdf sigma set to 3, increase this to increase the size of the
        % capture field/contribution of outer nodes to electrode lfp
        macroL = macroL + LFP(lfpnodes(p),:).*normpdf(distvec(lfpnodes(p)),0,3); 
    end
    macroLFP(q,:) = macroL;
end

end

