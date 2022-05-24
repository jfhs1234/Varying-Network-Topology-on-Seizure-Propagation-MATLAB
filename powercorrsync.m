function [ meancorr, correl ] = powercorrsync(electrodeLFP)

E = size(electrodeLFP,1);
v=1;
for q=1:E
    for a=1:E
        if q~=a
            testE1 = electrodeLFP(q,:);
            testE2 = electrodeLFP(a,:);
            corcoef = corrcoef(testE1,testE2);
            correl(v) = corcoef(1,2);
            v = v + 1;
        end
    end
end

meancorr = mean(correl);

end