clear;

%% Discussion

% This grid is meant to have an overall BB defined by these corners:
%   140 < lon < 148.5
%   10  < lat < 19

% A strip around the perimeter that is .5 deg wide is reserved for
% telescoping from 1km to 8km. Inside this perimeter the grid spacing is
% 1km.

% This new grid is to be 1km in the interior and 8km at the edges, and I
% think the most expedient way to do this is to redefine the latitude
% intervals and the longitude intervals to get the sizing right in km.

% The center of the grid is 
%       lon 144.25       
%       lat 14.5
% At this location you can figure out (web great circle calculator) that
%       1 deg Lon = 107.8919
%       1 deg Lat = 111.1949

%   onlineconversion.com/map_greacircle_distance.htm

lonMin = 140;
lonMax = 148.5;
latMin = 10;
latMax = 19;

cLon = 107.6530;
cLat = 111.1949;

% So the trick will be to game the lat/lon intervals below



%% Start with longitude. 

% The outer limits are
%       140 to 148.5
% and the inner limits are (approximately)
%       140.5 to 148
% The transition region is meant to be linear, which refers specifically to
% dz, so formulate the process using dz.
%

dzInner = 1/cLon;   % 1km interior interval
dzOuter = 8/cLon;   % 8km maximun interval

% Construct the inner region with perfect 1km spacing. It runs
% approximately (but not perfectly) between 140.5 and 148

% NOTE: game it so that there's an even number of interior intervals

nLonInterior = floor((148 - 140.5) * cLon/2) *2

lon_innerMin = ((148 + 140.5) /2) - nLonInterior/2 / cLon
lon_innerMax = ((148 + 140.5) /2) + nLonInterior/2 / cLon 

% Sanity check. Should equal nLonInterior
(lon_innerMax - lon_innerMin)*cLon

% intLon = (lon_innerMax - lon_innerMin) / dzInner;

% The transition region has the first dz set at dzInner, and the subsequent
% dz values get bigger and bigger until they get to the outer region. The
% sum of these dz values has to equal .5. An approximate solution is

%%
trial=[dzInner:.0058:dzOuter]
(lon_innerMin - lonMin) - sum(trial)
%%

% I've used MMA to devise a scheme that
% finds the slope of the line to machine precision using
%   Table[dzInner + (i-1) C, {i,nTerms}]
%   Solve[Apply[Plus,%] ==1, C]//Flatten
%   %% /. %
% Note that the idea is to fiddle with the number of terms until the last
% term in the series is close to my desired dzOuter. [It won't be perfect]

nTerms=length(trial);
C = .00598517430723699;
dzOuter = dzInner + (nTerms-1)*C

% Check to make sure the sum is OK

[dzInner:C:dzOuter+.00001]
deltaLon = sum(ans)

% Now construct the entire dzLon


intLon = round((lon_innerMax - lon_innerMin) / dzInner);

% KLUDGE!!
nKludge = 8;

myDzLon = [ [dzOuter:-C:dzInner] dzInner*ones(1,intLon-nKludge) fliplr([dzOuter:-C:dzInner]) ];
fig(1);clf;plot(myDzLon);ylabel('delta\_lon')

% So the longitudes are

myLon = (lon_innerMin + nKludge*dzInner) - deltaLon +[0 cumsum(myDzLon)];
fig(2);plot(myLon);ylabel('lon')


%% Do the latitudes. 

% The outer limits are
%       10 to 19
% and the inner limits are (approximately)
%       10.5 to 18.5
% The transition region is meant to be linear, which refers specifically to
% dz, so formulate the process using dz.
%

dzInner = 1/cLat;   % 1km interior interval
dzOuter = 8/cLat;   % 8km maximun interval

% Construct the inner region with perfect 1km spacing. It runs
% approximately (but not perfectly) between 141 and 148

% NOTE: game it so that there's an even number of interior intervals

nLatInterior = floor((18.5 - 10.5) * cLat/2) *2

lat_innerMin = ((10.5 + 18.5) /2) - nLatInterior/2 / cLat
lat_innerMax = ((10.5 + 18.5) /2) + nLatInterior/2 / cLat 

% Sanity check. Should equal nLonInterior
(lat_innerMax - lat_innerMin)*cLat

% intLon = (lon_innerMax - lon_innerMin) / dzInner;

% The transition region has the first dz set at dzInner, and the subsequent
% dz values get bigger and bigger until they get to the outer region. The
% sum of these dz values has to equal 1. An approximate solution is

trial=[dzInner:.005:dzOuter]
sum(trial)-(19-lat_innerMax)


% I've used MMA to devise a scheme that
% finds the slope of the line to machine precision using
%   Table[dzInner + (i-1) C, {i,nTerms}]
%   Solve[Apply[Plus,%] ==1, C]//Flatten
%   %% /. %
% Note that the idea is to fiddle with the number of terms until the last
% term in the series is close to my desired dzOuter. [It won't be perfect]

nTerms=length(trial);
C = .00500127277097266;
dzOuter = dzInner + (nTerms-1)*C

% Check to make sure the sum is OK

[dzInner:C:dzOuter+.00001]
deltaLat = sum(ans)

% Now construct the entire dzLon


intLat = round((lat_innerMax - lat_innerMin) / dzInner);
% Kludge! The source bathymetry file doesn't quite go up to 19N so reduce
% the number of interior latitude points
nKludge = 8;

myDzLat = [ [dzOuter:-C:dzInner] dzInner*ones(1,intLat-nKludge) [dzInner:C:dzOuter] ];
fig(1);clf;plot(myDzLat);ylabel('delta\_lat')

% So the longitudes are

myLat = lat_innerMin - deltaLat +[0 cumsum(myDzLat)];
fig(2);plot(myLat);ylabel('lat')


%% Create the coast.in file

% the data write begins in the upper left corner, runs counterclockwise
% until you get back (almost) to the starting point.


nx=length(myLon); ny=length(myLat);

dumWest = zeros(ny-1,2);
for jj=1:ny-1
    dumWest(jj,1) = myLat(end-jj+1);
    dumWest(jj,2) = myLon(1);
end

dumSouth = zeros(nx-1,2);
for ii=1:nx-1
    dumSouth(ii,1) = myLat(1);
    dumSouth(ii,2) = myLon(ii);
end

dumEast = zeros(ny-1,2);
for jj=1:ny-1
    dumEast(jj,1) = myLat(jj);
    dumEast(jj,2) = myLon(end);
end

% dumNorth needs one more entry at the end to close the rectangle
dumNorth = zeros(nx,2);
for ii=1:nx
    dumNorth(ii,1) = myLat(end);
    dumNorth(ii,2) = myLon(end-ii+1);
end

coast = vertcat(dumWest,dumSouth,dumEast,dumNorth);

save('coast.in','coast','-ascii')

['Include/gridparam.h:  Lm=',num2str(nx-1),'   Mm=',num2str(ny-1)]

