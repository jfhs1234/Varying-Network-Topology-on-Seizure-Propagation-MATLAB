function [ X,var1,var2 ] = powersync(electrodeLFP,meanLFP)

N = size(electrodeLFP,2);
var1 = zeros(N,1);
var2 = zeros(N,1);
for time = 1:N
    var1vec = abs(electrodeLFP(time).^2 - (meanLFP(time))^2);
    var1(time) = mean(var1vec);
    V1 = (sum(electrodeLFP(:,time))./N)^2; % square of sum 
    V2 = (sum(electrodeLFP(:,time).^2))/N; % sum of squares
    var2vec = abs(V2 - V1);
    var2(time) = mean(var2vec);
end
X = mean(var1)/mean(var2);

end
