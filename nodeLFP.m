function [ LFP, mLFP ] = nodeLFP(excres,inhres,p)
% calculate LFP of each node from results
n2 = size(excres,1);
tsteps = size(excres,2);
LFP = p.a.*excres + p.b.*inhres + p.Q.*ones(n2,tsteps)+p.Noise;
mLFP = mean(LFP,1);

end

