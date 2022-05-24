clear all
close all
clc

n = 100;
ns = 10;
t = 2;
dt = 0.001;
delaystep = 0.01; % delaystep/dt must be integar

E = rand(n^2,1); % initial E values
I = rand(n^2,1); % initial I values


%% generatenetwork(nodes column/row length, negative exponent, % edge density)
tic
[adjexc,meanidE] = gennetavgdeg(n,3,50);
[adjinh,meanidI] = gennetavgdeg(n,3,50);
toc

%% 
% dEdt = -E + Sigm(a.*(adjexc*E) - b.*I + P + Namp*Noise);
% dIdt = -I + Sigm(c.*(adjinh*E) - d.*I + Q);
p.Noise = addnoise(n,ns,t,dt);
stim.time = 5;% set to 15 for no stimulation
stim.nodes = stimnodenum(adjexc);

%% plot state space
p.a=0.75;
p.b=10;
p.c=1.35;
p.d=0;
p.P=-2.5;
p.Q=-5;
p.Namp=1;
    
Xp=0:0.05:1;
Yp=0:0.05:1;
axis([0 1 0 1])
xlabel('E')
ylabel('I')
    
% inhibition
X=0.05:0.05:0.995;
invsigy=4-log(1./X-1);
Y=(invsigy+p.d.*X-p.Q)./p.c;
hold on
plot(Y,X,'--g')
hold off
    
% excitation
X=0.05:0.05:0.995;
invsigx=4-log(1./X-1);
Y=(p.a.*X+p.P - invsigx)./p.b;
hold on
plot(X,Y,'--r')
hold off
    
hold on
for q=1:3
    for w=1:3
        E = repmat(0.25*q,n^2,1); % initial E values
        I = repmat(0.25*w,n^2,1); % initial I values
        tic
        [ex,ih] = WilsCow(t,dt,E,I,adjexc,adjinh,p,stim);
        toc
        plot(mean(ex),mean(ih));
    end
end
hold off
    

%% paramter scan

scan = 0.2:0.2:1;
maxE = zeros(size(scan));
minE = zeros(size(scan));
maxI = zeros(size(scan));
minI = zeros(size(scan));

for k=1:length(scan)
    
    p.a=0.8;
    p.b=10;
    p.c=scan(k);
    p.d=0;
    p.P=-2.5;
    p.Q=-5;
    p.Namp=1;
    
    E = rand(n^2,1); % initial E values
    I = rand(n^2,1); % initial I values
    tic
    [ex,ih] = WilsCow(t,dt,E,I,adjexc,adjinh,p,stim);
    toc
    maxE(k) = max(mean(ex(:,50:(t/dt+1))));
    minE(k) = min(mean(ex(:,50:(t/dt+1))));
    maxI(k) = max(mean(ih(:,50:(t/dt+1))));
    minI(k) = max(mean(ih(:,50:(t/dt+1))));
end

plot(scan,[maxE;minE])
legend('maxE','minE')
figure,
plot(scan,[maxI;minI])
legend('maxI','minI')