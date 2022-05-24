clear all
close all
clc
%%
n = 50;
ns = 10;
t = 5;
dt = 0.001;
delaystep = 0.001; % delaystep/dt must be integar

E = zeros(n^2,1); % initial E values
I = zeros(n^2,1); % initial I values


%% generatenetwork(nodes column/row length, negative exponent, % edge density)
tic
[adjexc] = gennetavgdeg(n,1.5,12);
[adjinh] = gennetavgdeg(n,1.5,12);
toc

%% parameter settings, equations below
% dEdt = -E + Sigm(a.*(adjexc*E) - b.*I + P + Namp*Noise);
% dIdt = -I + Sigm(c.*(adjinh*E) - d.*I + Q);
p.a=4.0;
p.b=25;
p.c=2.0;
p.e=15;
p.d=0;
p.P=-2.5;
p.Q=-5;
p.tauE = 0.02;
p.tauI =  0.01;
p.h = dt;
p.Namp=1;
p.Noise = addnoise(n,ns,t,dt);

%% stimulation parameters
% set to 0 for no stimulation?
stim.time = 1;
% picking one random node and all it's connections for stimulation
stim.nodes = stimnodeclus(n,3); % stimnodeclus(n,sigma(size of cluster))

%% run simulation
% tic
% [ex,ih] = WilsCow(t,dt,E,I,adjexc,adjinh,p,stim);
% toc

%% delaysim matrices
tic
delmex = addDelay(adjexc,delaystep);
delmih = addDelay(adjinh,delaystep);
toc

%% run delay simulation
tic
[ex,ih] = WilsCowDelay3(t,dt,E,delmex,delmih,p,stim);
toc

%% plot time series
% timeplot = 1:(t/dt+1);
% plot(timeplot,ex(500,:)) 
% figure, plot(timeplot,ih)
% 
%% make movie of simulation

%MF = makemovie(ex,501,10);

%%
v = VideoWriter('51vid.avi');
open(v)

eRes = ex;
start = 601;
step = 4;

n = sqrt(size(eRes,1));
plotgrid = reshape(1:n^2,n,n);
plotgrid = plotgrid';
steps = size(eRes,2);
for d=start:step:steps
    eframe = eRes(:,d);
    for z=1:n
        for q=1:n
            eMat(z,q) = eframe(plotgrid(z,q));
        end
    end
    clims = [0,1];
    imagesc(eMat,clims);
    time = d*0.001;
    title(['Time = ' num2str(time) ' seconds'])
    colorbar;
    F = getframe;
    writeVideo(v,F);
end
close(v)

