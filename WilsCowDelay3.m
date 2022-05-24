function [exc,inh] = WilsCowDelay3(t,dt,E,delmatexc,delmatinh,p,stim)

a = p.a;
b = p.b;
c = p.c;
d = p.d;
e = p.e;
P = p.P;
Q = p.Q;
h = p.h;
tauE = p.tauE;
tauI = p.tauI;
Namp = p.Namp;
Noise = p.Noise;
stimtime = stim.time/dt;
stimnodes = stim.nodes;

n2=size(E,1);
dEmax = size(delmatexc,2);
dImax = size(delmatinh,2);
steps = t/dt;
starty = max(dEmax,dImax)+1;

exc = zeros(n2,steps);
inh = zeros(n2,steps);
exc(:,1:starty) = zeros(n2,starty);
inh(:,1:starty) = zeros(n2,starty);

for y=starty:steps
    delexc = zeros(n2,1);
    delinh = zeros(n2,1);
    for g=1:dEmax
        consE = a.*(delmatexc{g}*exc(:,y-g+1));
        delexc = delexc + consE;
    end
    for f=1:dImax
        consI = c.*(delmatinh{f}*exc(:,y-f+1));
        delinh = delinh + consI;
    end
    dEdt = (-exc(:,y) + Sigm(delexc - b.*inh(:,y) + P + Namp*Noise(:,y)))./tauE;
    dIdt = (-inh(:,y) + Sigm(delinh + e*exc(:,y)- d.*inh(:,y) + Q))./tauI;
%     if rem(y,1000)==0
%         time = y*dt
%     end
    if (y)==stimtime
        exc(:,y+1) = exc(:,y) + h.*dEdt;
        inh(:,y+1) = inh(:,y) + h.*dIdt;
        exc(stimnodes,y+1) = 1;
    else
        exc(:,y+1) = exc(:,y) + h.*dEdt;
        inh(:,y+1) = inh(:,y) + h.*dIdt;
     end
end
exc = single(exc);
inh = single(inh);

end

function S=Sigm(x)
S=1./(1+exp(-(x-4)));
end