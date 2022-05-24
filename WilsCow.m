function [exc,inh] = WilsCow(t,dt,E,I,adjmatexc,adjmatinh,p,stim)
exc(:,1) = E;
inh(:,1) = I;

a = p.a;
b = p.b;
c = p.c;
d = p.d;
P = p.P;
Q = p.Q;
Namp = p.Namp;
Noise = p.Noise;
stimtime = stim.time./dt;
stimnodes = stim.nodes;


steps = t/dt;

for y=1:steps
    dEdt = -exc(:,y) + Sigm(a.*(adjmatexc*exc(:,y)) - b.*inh(:,y) + P + Namp*Noise(:,y));
    dIdt = -inh(:,y) + Sigm(c.*(adjmatinh*exc(:,y)) - d.*inh(:,y) + Q);
    if y==stimtime
        exc(:,y+1) = exc(:,y) + dEdt;
        inh(:,y+1) = inh(:,y) + dIdt;
        exc(stimnodes,y+1) = 1;
    else 
        exc(:,y+1) = exc(:,y) + dEdt;
        inh(:,y+1) = inh(:,y) + dIdt;
    end
    if rem(y,100)==0
        yt = y
    end
end

end

function S=Sigm(x)
S=1./(1+exp(-(x-4)));
end
