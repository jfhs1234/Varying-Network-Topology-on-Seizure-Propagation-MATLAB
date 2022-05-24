function [ changetime ] = findstartpeak( resmat,thresh )
% find first point of increase in activity on signal
n2 = size(resmat,1);
changetime = zeros(n2,1);

for q=1:n2
    vec = resmat(q,:);
    [~,x] = find(vec>thresh,1);
    if x>1
        changetime(q,1) = x;
    end
end


end

