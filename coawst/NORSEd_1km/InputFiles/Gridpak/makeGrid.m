clear; 
% close all;

%% Discussion

% This is a telescoping Mercator grid, so the x/y intervals cannot be
% regular. This means the perimeter will be defined with lat/lon.

% The inner region is to be ~1km
%   348.75 < lon < 357.25
%   69.5   < lat < 72.25
latMin = 69.5;
latMax = 72.25;
lonMin = 348.75;
lonMax = 357.25;
lonC = (lonMin + lonMax)/2;
latC = (latMin + latMax)/2;


% N/S span through the center is
NYinner = round(geodesic_dist(lonC,latMin,lonC,latMax)/1000)
%       305.786 km      so use Ny_inner = 306
% E/W span through the center is
NXinner = round(geodesic_dist(lonMin,latC,lonMax,latC)/1000)
%       378.478 km      so use Nx_inner = 378 


% The stretching band is .5 degree all the way around, and the second
% derivative is to be continuous.


% The MERCATOR files have 1/12 degree intervals in both latitude and
% longitude.



aaa=4;







%% oriented N/S 

innerNS = [latMin:(latMax-latMin)/NYinner:latMax];

nNS = 10;argSig = [-4:(3+4)/nNS:3]
deltaNS = (latMax - latMin)/NYinner + (1/12) ./ (1 + exp(-argSig) )
sum(deltaNS)

myLat = [fliplr((innerNS(1) - cumsum(deltaNS) )) innerNS  (innerNS(end) + cumsum(deltaNS)) ];
fig(1);clf; plot(myLat)
fig(2);clf; plot(diff(myLat))
fig(3);clf; plot(diff(diff(myLat)))

myLatEast = myLat;
% myLatWest = fliplr(myLat);
myLatWest = myLat;


%% Oriented E/W

innerEW = [lonMin:(lonMax-lonMin)/NXinner:lonMax];

nEW = 7;argSig = [-4:(3+4)/nEW:3]
deltaEW = (lonMax - lonMin)/NXinner + (1/12) ./ (1 + exp(-argSig) )
sum(deltaEW)

myLon = [fliplr((innerEW(1) - cumsum(deltaEW) )) innerEW  (innerEW(end) + cumsum(deltaEW)) ];



fig(1);clf; plot(myLon)
fig(2);clf; plot(diff(myLon))
fig(3);clf; plot(diff(diff(myLon)))

myLonSouth = myLon;
% myLonNorth = fliplr(myLon);
myLonNorth = myLon;


%% Double check

myLonWest = 0*myLatWest + myLonSouth(1);
myLonEast = 0*myLatEast + myLonSouth(end);

myLatSouth = 0*myLonSouth + myLatEast(1);
myLatNorth = 0*myLonNorth + myLatEast(end);

myLonWest = myLonWest - 360;
myLonEast = myLonEast - 360;
myLonSouth = myLonSouth - 360;
myLonNorth = myLonNorth - 360;

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

