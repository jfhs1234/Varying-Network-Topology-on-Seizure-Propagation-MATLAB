clear all
close all
clc

n = 50;
ns = 10;
t = 4;
dt = 0.001;
% delaystep = 0.001; % delaystep/dt must be integar

E = zeros(n^2,1); % initial E values
I = zeros(n^2,1); % initial I values

%% parameter settings, equations below
% dEdt = -E + Sigm(a.*(adjexc*E) - b.*I + P + Namp*Noise);
% dIdt = -I + Sigm(c.*(adjinh*E) - d.*I + Q);
p.a=2.6;
p.b=25;
p.c=1.4;
p.d=0;
p.P=-2.5;
p.Q=-5;
p.Namp=1;
p.Noise = addnoise(n,ns,t,dt);
%% stimulation parameters
% set to 0 for no stimulation?
stim.time = 0.2;
% picking one random node and all it's connections for stimulation
stim.nodes = stimnodeclus(n,6); % stimnodeclus(n, radius size of cluster)

%%
scan1 = 2:10;
%scan2 = 2:1:5;
s1 = length(scan1);
%s2 = length(scan2);
%exresults_exp = zeros(s1,n^2,(t/dt+1));
%ihresults_exp = zeros(s1,n^2,(t/dt+1));
graphtheory = zeros(s1,8);

adjinh = gennetavgdeg(n,3,16);
[asp,cc,ed,e] = graphmeasures(adjinh);
graphtheory(1,5:8) = [asp,cc,ed,e];


for z=1:s1
        tic
        adjexc = gennetavgdeg(n,scan1(z),13);
%       adjinh = gennetavgdeg(n,3,13);
%       delmex = addDelay(adjexc,delaystep);
%       delmih = addDelay(adjinh,delaystep);
%       [ex,ih] = WilsCowDelay3(t,dt,E,delmex,delmih,p,stim);
%        [ex,ih] = WilsCow(t,dt,E,I,adjexc,adjinh,p,stim);
        toc
        tic
        [asp,cc,ed,e] = graphmeasures(adjexc);
        graphtheory(z,1:4) = [asp,cc,ed,e];
        %exresults_exp(z,:,:) = ex;
        %ihresults_exp(z,:,:) = ih;
        toc
        it = [z] 
end

%% watch results
% 
% resmovE(:,:) = exresults_exp(7,:,:);
% resmovI(:,:) = ihresults_exp(7,:,:);
% movie(makemovie(resmovE,190,1))

%% plot results
v=1;
scans=1:10;
for q=scans
        subplot(length(scans),2,v)
        ex(:,:) = exresults_exp(q,:,:);
        ih(:,:) = ihresults_exp(q,:,:);
        [lfp,meanlfp] = nodeLFP(ex,ih,p);
        plot(meanlfp)
        ylim([-7 13])
        xlim([0 1000])
        v=v+1;
        subplot(length(scans),2,v)
        filtered = FiltEEG(meanlfp,4,1000,10);
        [f,mx] = fourierT(filtered,1000);
        plot(f,mx)
        ylim([0 1200])
        xlim([0 400])
        v=v+1;
end

