filters = [2 4;4 8 ; 8 13 ; 14 30 ; 31 60 ; 61 140];
filtnum = size(filters,1);
for q=1:s1
    tic
    ex(:,:) = exresults_exp(q,:,:);
    ih(:,:) = ihresults_exp(q,:,:);
    [lfp,meanlfp] = nodeLFP(ex,ih,p);
    electrodes = electrodeLFP(lfp,50,10);
    X(q) = powersync(electrodes,meanlfp);
    [m,c] = powercorrsync(electrodes);
    cor(q) = m;
    for filt = 1:size(filters,1)
        [meanr,rvec,meanISPC,ISPCvec] = phasesync(electrodes,filters(filt,:));
        r2(filt) = meanISPC;
        r(filt) = meanr;
    end
    R(q) = mean(r);
    IPSC(q) = mean(r2);
    toc
end
%%
subplot(4,2,1)
start = 2;
plot(graphtheory(start:end,1),X(start:end),'*')
title('ASP vs Power Synchrony')
subplot(4,2,2)
plot(graphtheory(start:end,2),X(start:end),'*')
title('Clustering Coef vs Power Synchrony')
subplot(4,2,3)
plot(graphtheory(start:end,1),cor(start:end),'*')
title('ASP vs Power Correlation')
subplot(4,2,4)
plot(graphtheory(start:end,2),cor(start:end),'*')
title('Clustering Coef vs Power Correlation')
subplot(4,2,5)
plot(graphtheory(start:end,1),R(start:end),'*')
title('ASP vs Phase Synchrony (time)')
subplot(4,2,6)
plot(graphtheory(start:end,2),R(start:end),'*')
title('Clustering Coef vs Phase Synchrony (time)')
subplot(4,2,7)
plot(graphtheory(start:end,1),IPSC(start:end),'*')
title('ASP vs Phase Synchrony (pairs)')
subplot(4,2,8)
plot(graphtheory(start:end,2),IPSC(start:end),'*')
title('Clustering Coef vs Phase Synchrony (pairs)')
