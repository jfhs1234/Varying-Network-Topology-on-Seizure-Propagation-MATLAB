function [exc,inh] = WilsCowDelayfix(t,dt,delaystep,E,delmatexc,delmatinh,p,stim)

a = p.a;
b = p.b;
c = p.c;
d = p.d;
P = p.P;
Q = p.Q;
Namp = p.Namp;
Noise = p.Noise;
stimtime = stim.time/dt;
stimnodes = stim.nodes;

n2=size(E,1);
dEmax = size(delmatexc,3);
dImax = size(delmatinh,3);
steps = t/dt;
deljump = delaystep/dt;
starty = (max(dEmax,dImax))*deljump; 


exc = zeros(n2,steps,'single');
inh = zeros(n2,steps,'single');
exc(:,1:starty) = zeros(n2,starty,'single');
inh(:,1:starty) = zeros(n2,starty,'single');

for y=starty:steps
    delexc = zeros(n2,1);
    delinh = zeros(n2,1);
    for d=1:dEmax
        consE = a.*(delmatexc(:,:,d)*exc(:,y-(deljump*d)+1:y-(deljump*(d-1))));
        delexc = delexc + sum(consE,2);
    end
    for d=1:dImax
        consI = c.*(delmatinh(:,:,d)*exc(:,y-(deljump*d)+1:y-(deljump*(d-1))));
        delinh = delinh + sum(consI,2);
    end
    dEdt = -exc(:,y) + Sigm(delexc - b.*inh(:,y) + P + Namp*Noise(:,y));
    dIdt = -inh(:,y) + Sigm(delinh - d.*inh(:,y) + Q);
    if (y)==stimtime
        exc(:,y+1) = exc(:,y) + dEdt;
        inh(:,y+1) = inh(:,y) + dIdt;
        exc(stimnodes,y+1) = 1;
    else
        exc(:,y+1) = exc(:,y) + dEdt;
        inh(:,y+1) = inh(:,y) + dIdt;
     end
end

end

function S=Sigm(x)
S=1./(1+exp(-(x-4)));
end