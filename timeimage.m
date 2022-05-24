function [] = timeimage( eRes,time )

n = sqrt(size(eRes,1));
plotgrid = reshape(1:n^2,n,n);
plotgrid = plotgrid';
eframe = eRes(:,time);
eMat = zeros(n,n);

for z=1:n
    for q=1:n
        eMat(z,q) = eframe(plotgrid(z,q));
    end
end
clims = [0,1];
imagesc(eMat,clims);
colorbar;


end

