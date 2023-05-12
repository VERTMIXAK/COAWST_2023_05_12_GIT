clear; 
% close all;

%% Updated discussion

% I am going to clean this up a bit. The GUAMM_2km grid is going to use
% somewhat older source data (months old) so the posted data is constant-z
% (like MERCATOR) as opposed to ROMS-ready;


sourceGrid = '/import/c1/VERTMIX/jgpender/ROMS/Brian/GUAM_2km/GUAM_grid.nc';
% sourceGrid = '/import/c1/VERTMIX/jgpender/ROMS/Brian/GUAM_2km/dataDir/GUAM_2022-03-27.nc_0';


latSource = nc_varget(sourceGrid,'lat');
lonSource = nc_varget(sourceGrid,'lon');

delta = 2;
latSource = latSource(1+delta:end-delta,1+delta:end-delta);
lonSource = lonSource(1+delta:end-delta,1+delta:end-delta);


%% Edges

% NOTE: Do the western and northern edges from lowest to highest. The order
% will be flipped later in this script

% South 

myLonSouth = lonSource(1,:);
myLatSouth = latSource(1,:);


% North 

myLonNorth = lonSource(end,:);
myLatNorth = latSource(end,:);

% West

myLonWest = lonSource(:,1);
myLatWest = latSource(:,1);

% East

myLonEast = lonSource(:,end);
myLatEast = latSource(:,end);

%% Double check

fig(99);clf;
plot(myLonWest,myLatWest,'*');hold on
plot(myLonEast,myLatEast,'*');
plot(myLonNorth,myLatNorth,'*');
plot(myLonSouth,myLatSouth,'*');

aaa=5;


%% Create the coast.in file

% Pause a second to think about how Gridpak uses the sqgrid.in file.

% All of the lat/lon points I am generating are assumed to be on the psi
% grid, which is why the first thing I did was import Brian's lat/lon
% coordinates for the psi grid.

% the data write begins in the upper left corner, runs counterclockwise
% until you get back to the starting point. Not that the number pairs for
% the corners always appear twice.

% NOTE that I have to reverse the order of the western and northern data


nx=length(myLonSouth)
ny=length(myLonWest)

dumWest = zeros(ny,2);
for jj=1:ny
    dumWest(jj,:) = [myLatWest(end-jj+1), myLonWest(end-jj+1)];
%     dumWest(jj,1) = myLat(end-jj+1);
%     dumWest(jj,2) = myLonWest(1);
end

dumSouth = zeros(nx,2);
for ii=1:nx
    dumSouth(ii,:) = [myLatSouth(ii),myLonSouth(ii)];
%     dumSouth(ii,1) = myLat(1);
%     dumSouth(ii,2) = myLon(ii);
end

dumEast = zeros(ny,2);
for jj=1:ny
    dumEast(jj,:) = [myLatEast(jj), myLonEast(jj)];
%     dumEast(jj,1) = myLat(jj);
%     dumEast(jj,2) = myLon(end);
end

% dumNorth needs one more entry at the end to close the rectangle
dumNorth = zeros(nx,2);
for ii=1:nx
    dumNorth(ii,:) = [myLatNorth(end-ii+1),myLonNorth(end-ii+1)];
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

