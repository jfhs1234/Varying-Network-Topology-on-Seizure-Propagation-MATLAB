function [ F ] = makemovie( eRes, start, step)
%       make film of nodes
% eRes = simulation matrix of results
% step = number of iterations between film plots, 1 for all images.
% start = first timepoint for start of movie
%
% F = output frames, use movie function to play

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
    F(d) = getframe;
end


end

