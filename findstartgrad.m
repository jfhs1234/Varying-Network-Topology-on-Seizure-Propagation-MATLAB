function [ change_vec, changetime ] = findstartgrad( resmat,window )
% calculates gradient between two points and measures peak in gradient
% change

n2 = size(resmat,1);
tsteps = size(resmat,2);
change_vec = zeros(n2,length(window+1:window:tsteps-window));

for j=1:n2
    v=1;
    for q=window+1:window:tsteps-window
        p1 = resmat(j,q-window);
        p2 = resmat(j,q);
        p3 = resmat(j,q+window);
        g1 = p1-p2;
        g2 = p2-p3;
        graddiff = abs(g2-g1);
        change_vec(j,v) = graddiff;
        v = v+1;
    end
end

changetime = zeros(n2,1);

for j=1:n2
    peak = findpeaks(change_vec(j,:));
    biggest = max(peak);
    [~,l] = find(change_vec(j,:)>biggest/2);
    changetime(j) = l(1)*window;
end

end

