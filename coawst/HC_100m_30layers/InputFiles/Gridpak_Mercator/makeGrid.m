clear;

% The idea here is to take an existing grid and wrap a telescoping layer
% around the outside. 
%   /import/c1/VERTMIX/jgpender/roms-kate_svn/SCSA_4km/InputFiles/Gridpak



% Here are the corners Harper wants


lonmin = -123.18;
lonmax = -122.56;
latmin = 47.29;
latmax = 47.885;

% At this latitude you get
%   76 km/deg longitude'
%   111 km/deg latitude
%
% I want ~150m spacing

100 / 76000;deltaLon = round(100000 * ans)/100000
100 / 111000;deltaLat = round(1000000 * ans)/1000000



newX = [lonmin:deltaLon:lonmax];
newY = [latmin:deltaLat:latmax];

aaa=5;

%% Create the coast.in file

% the data write begins in the upper left corner, runs counterclockwise
% until you get back (almost) to the starting point.

% Remember that you're not supposed to duplicate the corners!!


nx=length(newX); ny=length(newY);

dumWest = zeros(ny,2);
dumWest(:,1) = fliplr(newY(1:end));
dumWest(:,2) = newX(1);

dumSouth = zeros(nx,2);
dumSouth(:,1) = newY(1);
dumSouth(:,2) = newX(1:end);

dumEast = zeros(ny,2);
dumEast(:,1) = newY(1:end);
dumEast(:,2) = newX(end);

dumNorth = zeros(nx,2);
dumNorth(:,1) = newY(end);
dumNorth(:,2) = fliplr(newX(1:end));




%%

fig(10);clf;
plot(dumWest(:,2),dumWest(:,1),'*');hold on
plot(dumSouth(:,2),dumSouth(:,1),'*')
plot(dumEast(:,2),dumEast(:,1),'*')
plot(dumNorth(:,2),dumNorth(:,1),'*')

%%

% coast = vertcat(dumWest,dumSouth,dumEast,dumNorth);

['Include/gridparam.h:  Lm=',num2str(nx-1),'   Mm=',num2str(ny-1)]

% save('coast.in','coast','-ascii')


%% Create the sqgrid.in file

% Note that I can skip the fort2sq.bash script. What this does is convert
% lat/lon to x/y, but I've already got x/y for this grid.

% fileID = fopen('west.in','w');
% fprintf(fileID,'%12.8f %12.8f \n','dumWest');
% fclose(fileID);
% 
% 
% aaa=5;

save('west.in','dumWest','-ascii');
save('east.in','dumEast','-ascii');
save('north.in','dumNorth','-ascii');
save('south.in','dumSouth','-ascii');

% unix(['echo "',num2str(ny),' " > coast.in']);
% % unix(['echo "',num2str(ny-1),' " > sqgrid.in']);
% unix(['cat west.in >> coast.in']);
% 
% unix(['echo "',num2str(nx),' " >> coast.in']);
% % unix(['echo "',num2str(ny-1),' " > sqgrid.in']);
% unix(['cat south.in >> coast.in']);
% 
% unix(['echo "',num2str(ny),' " >> coast.in']);
% % unix(['echo "',num2str(ny-1),' " >> sqgrid.in']);
% unix(['cat east.in >> coast.in']);
% 
% unix(['echo "',num2str(nx),' " >> coast.in']);
% % unix(['echo "',num2str(nx-1),' " >> sqgrid.in']);
% unix(['cat north.in >> coast.in']);


