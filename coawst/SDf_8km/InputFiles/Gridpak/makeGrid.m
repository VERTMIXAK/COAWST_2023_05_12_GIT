clear;

%% Discussion

% The original MERCATOR grid is Mercator projection that uses well
% defined intervals in latitude and longitude. 

% This new grid is to reuse the MERCATOR lat/lon plus maybe add some in
% between to get something like 8km.


% Harpers desired BB is approximately
%       -119.5 < lon < -116.75
%       `32    < lat < 33.75

% My MERCATOR files have this:-


% lat1d = 31.08333, 31.16667, 31.25, 31.33333, 31.41667, 31.5, 31.58333,
%     31.66667, 31.75, 31.83333, 31.91667, 32, 32.08333, 32.16667, 32.25,
%     32.33333, 32.41667, 32.5, 32.58333, 32.66667, 32.75, 32.83333, 32.91667,
%     33, 33.08333, 33.16667, 33.25, 33.33333, 33.41667, 33.5, 33.58333,
%     33.66667, 33.75, 33.83333, 33.91667, 34, 34.08333, 34.16667, 34.25,
%     34.33333 ;
% 
%  lon1d = -122.9167, -122.8333, -122.75, -122.6667, -122.5833, -122.5,
%     -122.4167, -122.3333, -122.25, -122.1667, -122.0833, -122, -121.9167,
%     -121.8333, -121.75, -121.6667, -121.5833, -121.5, -121.4167, -121.3333,
%     -121.25, -121.1667, -121.0833, -121, -120.9167, -120.8333, -120.75,
%     -120.6667, -120.5833, -120.5, -120.4167, -120.3333, -120.25, -120.1667,
%     -120.0833, -120, -119.9167, -119.8333, -119.75, -119.6667, -119.5833,
%     -119.5, -119.4167, -119.3333, -119.25, -119.1667, -119.0833, -119,
%     -118.9167, -118.8333, -118.75, -118.6667, -118.5833, -118.5, -118.4167,
%     -118.3333, -118.25, -118.1667, -118.0833, -118, -117.9167, -117.8333,
%     -117.75, -117.6667, -117.5833, -117.5, -117.4167, -117.3333, -117.25,
%     -117.1667, -117.0833, -117, -116.9167, -116.8333, -116.75, -116.6667,
%     -116.5833, -116.5, -116.4167 ;

% This is something like a 9km grid


% So I will choose
% c1 = .25/6;
% c2 =  c1/2;
myLon = [-121.75-.25/6 :.25/3:-116.75+.25/6 ];
myLat = [32-.25/6 :.25/3:33.75+.25/6 ];




%% Start with longitude. 
% No telescoping


myLon 
fig(2);plot(myLon);ylabel('lon')


%% Do the latitudes
% No telescoping

myLat
fig(4);clf;plot(myLat);ylabel('lat')

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

