clear
close all
clc

n = 100;
ns = 10;
t = 1;
dt = 0.001;
delaystep = 0.005; % delaystep/dt must be integar

E = zeros(n^2,1); % initial E values
I = zeros(n^2,1); % initial I values
%%
tic
[adjexc,meanidE] = gennetavgdeg(n,3,50);
[adjinh,meanidI] = gennetavgdeg(n,3,50);
toc
%%
stim.time = 0.2;
stim.nodes = stimnodeclus(n,5);
%%
tic
delmex = addDelay(adjexc,delaystep);
delmih = addDelay(adjinh,delaystep);
toc

%%

scana = 0.3:0.05:0.8;
scanc = 0.2:0.1:1;
s1 = length(scana);
s2 = length(scanc);
exresults_ac = single(zeros(s1,s2,n^2,(t/dt+1)));
ihresults_ac = single(zeros(s1,s2,n^2,(t/dt+1)));

scanP = -4:1:1;
scanQ = -5:1:1;
s3 = length(scanP);
s4 = length(scanQ);
exresults_PQ = single(zeros(s3,s4,n^2,(t/dt+1)));
ihresults_PQ = single(zeros(s3,s4,n^2,(t/dt+1)));

%%
tic
for A=1:s1
    for C=1:s2
        p.a=scana(A);
        p.b=25;
        p.c=scanc(C);
        p.d=0;
        p.P=-2.5;
        p.Q=-5;
        p.Namp=1;
        p.Noise = addnoise(n,ns,t,dt);
    
        E = zeros(n^2,1); % initial E values
        I = zeros(n^2,1); % initial I values
        [ex,ih] = WilsCowDelay(t,dt,delaystep,E,delmex,delmih,p,stim);
        exresults_ac(A,C,:,:) = ex;
        ihresults_ac(A,C,:,:) = ih;
        it = [A,C]
    end
end

for k=1:s3
    for q=1:s4
        p.a=0.6;
        p.b=25;
        p.c=0.4;
        p.d=0;
        p.P=scanP(k);
        p.Q=scanQ(q);
        p.Namp=1;
        p.Noise = addnoise(n,ns,t,dt);
    
        E = rand(n^2,1); % initial E values
        I = rand(n^2,1); % initial I values
        [ex,ih] = WilsCowDelay(t,dt,delaystep,E,delmex,delmih,p,stim);
        exresults_PQ(k,q,:,:) = ex;
        ihresults_PQ(k,q,:,:) = ih;
        it = [q,k]
    end
end
toc
%%
resmov = zeros(n^2,(t/dt)+1);
resmov(:,:) = exresults_PQ(3,1,:,:);
movie(makemovie(resmov,100,1))
