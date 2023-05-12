clear; 
% close all;

% Choose psi grid on 1-degree intervals
%   Lat 0 to 11N
%   Lon 10 to 20

latList = [12:.5:16]
lonList = [142:.5:146]




%% Double check

% fig(99);clf;
% plot(myLonWest,myLatWest,'*');hold on
% plot(myLonEast,myLatEast,'*');
% plot(myLonNorth,myLatNorth,'*');
% plot(myLonSouth,myLatSouth,'*');






%% Create the coast.in file

% Pause a second to think about how Gridpak uses the sqgrid.in file.

% All of the lat/lon points I am generating are assumed to be on the psi
% grid, which is why the first thing I did was import Brian's lat/lon
% coordinates for the psi grid.

% the data write begins in the upper left corner, runs counterclockwise
% until you get back to the starting point. Not that the number pairs for
% the corners always appear twice.

% NOTE that I have to reverse the order of the western and northern data


nx=length(lonList)
ny=length(latList)

dumWest = zeros(ny,2);
for jj=1:ny
    dumWest(jj,:) = [latList(end-jj+1),lonList(1)];
%     dumWest(jj,1) = myLat(end-jj+1);
%     dumWest(jj,2) = myLonWest(1);
end

dumSouth = zeros(nx,2);
for ii=1:nx
    dumSouth(ii,:) = [latList(1),lonList(ii)];
%     dumSouth(ii,1) = myLat(1);
%     dumSouth(ii,2) = myLon(ii);
end

dumEast = zeros(ny,2);
for jj=1:ny
    dumEast(jj,:) = [latList(jj), lonList(end)];
%     dumEast(jj,1) = myLat(jj);
%     dumEast(jj,2) = myLon(end);
end

% dumNorth needs one more entry at the end to close the rectangle
dumNorth = zeros(nx,2);
for ii=1:nx
    dumNorth(ii,:) = [latList(end),lonList(end-ii+1)];
%     dumNorth(ii,1) = myLat(end);
%     dumNorth(ii,2) = myLon(end-ii+1);
end

save('west.in','dumWest','-ascii');
save('south.in','dumSouth','-ascii');
save('east.in','dumEast','-ascii');
save('north.in','dumNorth','-ascii');

% unix(['echo "',num2str(ny),' " > coast.in']);
% unix(['cat west.in >> coast.in']);
% unix(['echo "',num2str(nx),' " >> coast.in']);
% unix(['cat south.in >> coast.in']);
% unix(['echo "',num2str(ny),' " >> coast.in']);
% unix(['cat east.in >> coast.in']);
% unix(['echo "',num2str(nx),' " >> coast.in']);
% unix(['cat north.in >> coast.in']);


% coast = vertcat(dumWest,dumSouth,dumEast,dumNorth);
% 
% save('coast.in','coast','-ascii')

['Include/gridparam.h:  Lm=',num2str(nx-1),'   Mm=',num2str(ny-1)]

