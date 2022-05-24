clear all
close all
clc

n = 50;
ns = 10;
dt = 0.001;

E = zeros(n^2,1); % initial E values
I = zeros(n^2,1); % initial I values


%% generatenetwork

mapscan = 0.5:0.5:5.5;

scan = length(mapscan);
graphGAM1 = zeros(scan*10,7);

for j=1:scan
    savename = ([num2str(mapscan(j)),'gam1.mat'])
    delmat = cell(10,1);
   % tic
    for q=1:10
        tic
        adjexc = gennetgamma(n,1,mapscan(j),12);
        toc
        tic
        [ASP,CC,mod,bet,edgedens,edges] = graphmeasures(adjexc);
        toc
        graphGAM1(10*(j-1)+q,:) = [ASP,CC,mod,bet,edgedens,edges,mapscan(j)];
        tic
        delmat{q} = addDelay(adjexc,dt);
        toc
    end
    save(savename,'delmat')
    save('graphresgamA1','graphGAM1')
  %  toc
end

%%
graphvalues = zeros(scan*10,7);
for j=1:scan
    delmat = cell(10,1);
    savename = ([num2str(mapscan(j)),'norm1.mat'])
    tic
    for q=1:10
        adjexc = gennetguassian(n,1,mapscan(j),12);
        [ASP,CC,mod,bet,edgedens,edges] = graphmeasures(adjexc);
        graphvalues(10*(j-1)+q,:) = [ASP,CC,mod,bet,edgedens,edges,mapscan(j)];
        delmat{q} = addDelay(adjexc,dt);
      
    end
    save(savename,'delmat')
    save('graphresnorm','graphvalues')
    toc
end

        

