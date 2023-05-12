clear; 
close all;

%% Discussion

% The idea is to do a forecast of Brian Powell's ROMS output in the Guam
% area, like I did for Hood Canal. This data is on a ~8km grid and Harper
% wants this telescoped down to 1km. This program outputs psi-grid lat/lon
% points for the coast program in the Gridpak package, so the idea is to
% find a BB Harper likes on Brian's psi grid and use the perimeter for the
% local grid. And when I say "perimeter" what I mean is the 4 corners,
% because I'm going to have way too many points for them to sit on

% NOTE that I've chosen the perimeter so that there aren't any islands
% hitting the BB on either my grid or Brian's grid.

% The strategy here is going to be pretty different. Brian's grid is pretty
% close to 8km. I want a 1km grid in the interior that stretches to Brian's
% 8 km grid on the edges. The region for the stretching is about 1 degree 
% latitude/longitude. If you look at, say, the latitude of the western edge
% you see:
%   the lower left corner
%   12 points you don't care about
%   the frink grid point that is 1 degree higher than the lower left corner
%   many points that are about 8 km apart
%   the frink grid point that is 1 degree lower thant he upper right corner
%   12 points you don't care about
%   the upper left corner

% Let's just assume this all the way around.

% So
% 1) Use the LL corner
% 2) Stretch from the LL corner to the 14th point (leaving the 14th point unchanged
% 3) Leaving all the interior points unchanged, add 7 points between each
% 4) Stretch from the last interior point to the UL corner
% 5) Leave the UL corner unchanged


%% Read in the psi grid for the subsetted frink ROMS output

frinkFile = 'frinkGrid.nc_aSmidgeTooBig';
lon_psi_frink = nc_varget(frinkFile,'lon_psi');
lat_psi_frink = nc_varget(frinkFile,'lat_psi');

% Cut Brian's grid back a little bit on the eastern edge
lon_psi_frink = lon_psi_frink(:,1:end-1);
lat_psi_frink = lat_psi_frink(:,1:end-1);


[nyF, nxF] = size(lon_psi_frink);

lonFrinkWest = lon_psi_frink(:,1);
latFrinkWest = lat_psi_frink(:,1);

lonFrinkEast = lon_psi_frink(:,end);
latFrinkEast = lat_psi_frink(:,end);

lonFrinkSouth = lon_psi_frink(1,:);
latFrinkSouth = lat_psi_frink(1,:);

lonFrinkNorth = lon_psi_frink(end,:);
latFrinkNorth = lat_psi_frink(end,:);



aaa=5;

% I want a myLatWest and a myLonWest.

% lat first

% [ (1) stretch (14) add points (15) ... (ny-14) add points (ny-13) stretch (ny) ]

% Work on the stretching

cDum = .293478;
dum = [1:cDum:8];
RHS = fliplr([dum 0]);
LHS = [0 fliplr(dum)];

%% South 

myVar   = lonFrinkSouth;

pos1    = myVar(1);
pos14   = myVar(14);
posEm13 = myVar(end-13);
posE    = myVar(end);

myLHS = pos1 + cumsum(LHS)/sum(LHS) *(pos14 - pos1)
temp = posE - cumsum(RHS)/sum(RHS) *(posE - posEm13);
myRHS = fliplr(temp)

% nMax = (length(myVar)-27)/8

temp2 = myLHS(1:end-1);

for nn=14:length(myVar)-14
    [myVar(nn):(myVar(nn+1)-myVar(nn))/8:myVar(nn+1)];
    temp2 = [temp2 ans(1:end-1)];
    aaa=5;
end;
myLonSouth = [temp2 myRHS];

myLatSouth = interp1(lonFrinkSouth,latFrinkSouth,myLonSouth,'linear');

fig(1);clf;
plot(myLonSouth,myLatSouth)
hold on;
plot(lonFrinkSouth,latFrinkSouth,'g')

%% North 

myVar   = lonFrinkNorth;

pos1    = myVar(1);
pos14   = myVar(14);
posEm13 = myVar(end-13);
posE    = myVar(end);

myLHS = pos1 + cumsum(LHS)/sum(LHS) *(pos14 - pos1)
temp = posE - cumsum(RHS)/sum(RHS) *(posE - posEm13);
myRHS = fliplr(temp)

% nMax = (length(myVar)-27)/8

temp2 = myLHS(1:end-1);

for nn=14:length(myVar)-14
    [myVar(nn):(myVar(nn+1)-myVar(nn))/8:myVar(nn+1)];
    temp2 = [temp2 ans(1:end-1)];
    aaa=5;
end;
myLonNorth = [temp2 myRHS];

myLatNorth = interp1(lonFrinkNorth,latFrinkNorth,myLonNorth,'linear');

fig(2);clf;
plot(myLonNorth,myLatNorth)
hold on;
plot(lonFrinkNorth,latFrinkNorth,'g')

aaa=5;

%% West 

myVar   = latFrinkWest;

pos1    = myVar(1);
pos14   = myVar(14);
posEm13 = myVar(end-13);
posE    = myVar(end);

myLHS = pos1 + cumsum(LHS)/sum(LHS) *(pos14 - pos1)
temp = posE - cumsum(RHS)/sum(RHS) *(posE - posEm13);
myRHS = fliplr(temp)

temp2 = myLHS(1:end-1);

for nn=14:length(myVar)-14
    [myVar(nn):(myVar(nn+1)-myVar(nn))/8:myVar(nn+1)];
    temp2 = [temp2 ans(1:end-1)];
    aaa=5;
end;
myLatWest = [temp2 myRHS];

myLonWest = interp1(latFrinkWest,lonFrinkWest,myLatWest,'linear');

fig(3);clf;
plot(myLonWest,myLatWest)
hold on;
plot(lonFrinkWest,latFrinkWest,'g')

%% East 

myVar   = latFrinkEast;

pos1    = myVar(1);
pos14   = myVar(14);
posEm13 = myVar(end-13);
posE    = myVar(end);

myLHS = pos1 + cumsum(LHS)/sum(LHS) *(pos14 - pos1)
temp = posE - cumsum(RHS)/sum(RHS) *(posE - posEm13);
myRHS = fliplr(temp)

temp2 = myLHS(1:end-1);

for nn=14:length(myVar)-14
    [myVar(nn):(myVar(nn+1)-myVar(nn))/8:myVar(nn+1)];
    temp2 = [temp2 ans(1:end-1)];
    aaa=5;
end;
myLatEast = [temp2 myRHS];

myLonEast = interp1(latFrinkEast,lonFrinkEast,myLatEast,'linear');

fig(4);clf;
plot(myLonEast,myLatEast)
hold on;
plot(lonFrinkEast,latFrinkEast,'g')


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

