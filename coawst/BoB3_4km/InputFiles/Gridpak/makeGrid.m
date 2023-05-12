clear;

% The plan here is a little different than is was when I created the
% PALAU_800m grid. What I want to do now is reuse the corners from the
% PALAU_800m grid and increase the density in the middle to 400m. Then I
% need to feather the grid spacing out to the edges.

%% get my PALAU_400m grid

jFile = '../../../PALAU_800m/InputFiles/Gridpak/PALAU_800m.nc';
jLon  = nc_varget(jFile,'lon_psi');
jLat  = nc_varget(jFile,'lat_psi');    

%% My boundaries from the PALAU_800m grid
 
jLatMin = mean(jLat(1,1));
jLatMax = mean(jLat(end,1));
jLonMin = mean(jLon(:,1));
jLonMax = mean(jLon(:,end));

%% So what are the dimensions of this box?

Wedge = geodesic_dist(jLon(1,1),  jLat(1,1),  jLon(end,1),  jLat(end,1));
Sedge = geodesic_dist(jLon(1,1),  jLat(1,1),  jLon(1,end),  jLat(1,end));
Eedge = geodesic_dist(jLon(1,end),jLat(1,end),jLon(end,end),jLat(end,end));
Nedge = geodesic_dist(jLon(end,1),jLat(end,1),jLon(end,end),jLat(end,end));

% If you subtract off 25km from all sides, how many 800m intervals do you
% get?
% first-cut
Nedge - 50000;ans/400
Sedge - 50000;ans/400
Eedge - 50000;ans/400
Wedge - 50000;ans/400
aaa=5;

%% Make an executive decision

% Fix the number of 400m intervals at

i400 = 1386;
j400 = 1254;

% Then fit this inside the same domain I used for PALAU_800m

latSW = jLat(1,1);
lonSW = jLon(1,1);

latNW = jLat(end,1);
lonNW = jLon(end,1);

latSE = jLat(1,end);
lonSE = jLon(1,end);

latNE = jLat(end,end);
lonNE = jLon(end,end);

aaa=5;

%%  Southern boundary 

% The central longitude is
lonCenS = ( lonSW + lonSE )/2

% calculate the number of meters per degree, then the 400m intervals in degrees
mpDeg = geodesic_dist(lonSW,latSW,lonSE,latSE) / ( lonSE - lonSW );
dLon400S = 400/mpDeg;
dLon2500S = 2500/mpDeg;

% There will be i400/2 of the intervals to the RHS of the central
% longitude. I want to telescope the remainder out to the maximum longitude.

zTelS = lonSE - lonCenS - i400/2 * dLon400S;

% The transition region has the first dz set at dlon400S, and the subsequent
% dz values get larger and larger until they get to the edge. The
% sum of these dz values has to equal the length of the transition region calculated
% above. I've used MMA to devise a scheme that
% finds the slope of the line to machine precision using
%   nTerms=<pick something>
%   Table[dLon400S + (i-1) C, {i,nTerms}]
%   NumberForm[Solve[Apply[Plus,%] == zTel, C],15]
% You try different values of nTerms until you find the value that gives
% the largest final interval that is still smaller than dLon2500N.
%
% For the sourthern edge, nTerms is 19
% NOTE: you have to use the same value for nTerms for the northern edge

nTerms = 17;
dLon400S
dLon2500S
zTelS

C = .00114378197788626
[dLon400S:C:dLon400S+(nTerms-1)*C]
sum(ans) - zTelS


% Now construct the entire dzLon

% The set of intervals to the right of the center latitude is

[dLon400S*ones(1,i400/2) [dLon400S:C:dLon400S+(nTerms-1)*C] ];

% so the set of longitudes larger than the center latitude is 

rhsS = lonCenS + cumsum(  [dLon400S*ones(1,i400/2) [dLon400S:C:dLon400S+(nTerms-1)*C] ]   )  ;

% so the set of longitudes smaller than the center latitude is 

lhsS = lonCenS - fliplr(cumsum(  [dLon400S*ones(1,i400/2) [dLon400S:C:dLon400S+(nTerms-1)*C] ]   ))  ;

% and the total set of allowed longitudes is

myLonS =[lhsS, lonCenS , rhsS  ];

fig(1);clf;plot(myLonS);title('longtides on S border')
fig(2);clf;plot(diff(myLonS));title('longitude intervals on S border')

% Now pair the longitudes with latitudes, because the latitudes vary as
% you go EW.

myLatS = interp1(jLon(1,:),jLat(1,:),myLonS,'linear','extrap');


% a few checks
myLonS(1)   - lonSW
myLonS(end) - lonSE
length(myLonS)

geodesic_dist(lonSW,latSW,lonSE,latSE)
geodesic_dist(myLonS(1),latSW,myLonS(end),latSW)

aaa=5;


%%  Northern boundary 

% The central longitude is
lonCenN = ( lonNW + lonNE )/2

% calculate the number of meters per degree, then the 800m intervals in degrees
mpDeg = geodesic_dist(lonNW,latNW,lonNE,latNE) / ( lonNE - lonNW );
dLon400N = 400/mpDeg;
dLon2500N = 2500/mpDeg;

% There will be i400/2 of the intervals to the RHS of the central
% longitude. I want to telesope the remainder out to the maximum longitude.

zTelN = lonNE - lonCenN - i400/2 * dLon400N;

% The transition region has the first dz set at dlon400S, and the subsequent
% dz values get larger and larger until they get to the edge. The
% sum of these dz values has to equal the length of the transition region calculated
% above. I've used MMA to devise a scheme that
% finds the slope of the line to machine precision using
%   nTerms=<pick something>
%   Table[dLon800N + (i-1) C, {i,nTerms}]
%   NumberForm[Solve[Apply[Plus,%] == zTel, C],15]
% You try different values of nTerms until you find the value that gives
% the largest final interval that is still smaller than dLon2500N.
%
% For the sourthern edge, nTerms is 19
% NOTE: you have to use the same value for nTerms for the northern edge

% nTerms = 32;

dLon400N
dLon2500N
zTelN

C = .00115632584886289;

[dLon400N:C:dLon400N+(nTerms-1)*C]
sum(ans) - zTelN


% Now construct the entire dzLon

% The set of intervals to the right of the center latitude is

[dLon400N*ones(1,i400/2) [dLon400N:C:dLon400N+(nTerms-1)*C] ];

% so the set of longitudes larger than the center latitude is 

rhsN = lonCenN + cumsum(  [dLon400N*ones(1,i400/2) [dLon400N:C:dLon400N+(nTerms-1)*C] ]   )  ;

% so the set of longitudes smaller than the center latitude is 

lhsN = lonCenN - fliplr(cumsum(  [dLon400N*ones(1,i400/2) [dLon400N:C:dLon400N+(nTerms-1)*C] ]   ))  ;

% and the total set of allowed longitudes is

myLonN =[lhsN, lonCenN , rhsN  ];

fig(3);clf;plot(myLonN)
fig(4);clf;plot(diff(myLonN))

% Now pair the longitudes with latitudes, because the latitudes vary as
% you go EW.

myLatN = interp1(jLon(end,:),jLat(end,:),myLonN,'linear','extrap');

% a few checks
myLonN(1)   - lonNW
myLonN(end) - lonNE
length(myLonN)


geodesic_dist(lonNW,latNW,lonNE,latNE)
geodesic_dist(myLonN(1),latNW,myLonN(end),latNE)

aaa=5;


%%  Western boundary 

% The central latitude is
latCenW = ( latSW + latNW )/2

% calculate the number of meters per degree, then the 400m intervals in degrees
mpDeg = geodesic_dist(lonSW,latSW,lonNW,latNW) / ( latNW - latSW );
dLat400W = 400/mpDeg;
dLat2500W = 2500/mpDeg;

% There will be i400/2 of the intervals to the RHS of the central
% longitude. I want to telesope the remainder out to the maximum longitude.

zTelW = latNW - latCenW - j400/2 * dLat400W

% The transition region has the first dz set at dlon800S, and the subsequent
% dz values get larger and larger until they get to the edge. The
% sum of these dz values has to equal the length of the transition region calculated
% above. I've used MMA to devise a scheme that
% finds the slope of the line to machine precision using
%   nTerms=<pick something>
%   Table[dLon800N + (i-1) C, {i,nTerms}]
%   NumberForm[Solve[Apply[Plus,%] == zTel, C],15]
% You try different values of nTerms until you find the value that gives
% the largest final interval that is still smaller than dLon2500N.
%
% For the sourthern edge, nTerms is 19
% NOTE: you have to use the same value for nTerms for the northern edge

nTerms = 17;

dLat400W
dLat2500W
zTelW

C = .0011284301459549;

[dLat400W:C:dLat400W+(nTerms-1)*C]
sum(ans) - zTelW


% Now construct the entire dzLon

% The set of intervals to the right of the center latitude is

[dLat400W*ones(1,j400/2) [dLat400W:C:dLat400W+(nTerms-1)*C] ];

% so the set of longitudes larger than the center latitude is 

rhsW = latCenW + cumsum(  [dLat400W*ones(1,j400/2) [dLat400W:C:dLat400W+(nTerms-1)*C] ]   )  ;

% so the set of longitudes smaller than the center latitude is 

lhsW = latCenW - fliplr(cumsum(  [dLat400W*ones(1,j400/2) [dLat400W:C:dLat400W+(nTerms-1)*C] ]   ))  ;

% and the total set of allowed longitudes is

myLatW =[lhsW, latCenW , rhsW  ];

fig(5);clf;plot(myLatW)
fig(6);clf;plot(diff(myLatW))


% Now pair the latitudes with longitudes, because the longitudes vary as
% you go north.

myLonW = interp1(jLat(:,1),jLon(:,1),myLatW,'linear','extrap');

% a few checks
myLatW(1)   - latSW
myLatW(end) - latNW
length(myLatW)

geodesic_dist(lonSW,latSW,lonNW,latNW)
geodesic_dist(myLonW(1),myLatW(1),myLonW(end),myLatW(end))

aaa=5;

%%  Eastern boundary 

% The central latitude is
latCenE = ( latSE + latNE )/2

% calculate the number of meters per degree, then the 800m intervals in degrees
mpDeg = geodesic_dist(lonSE,latSE,lonNE,latNE) / ( latNE - latSE );
dLat400E = 400/mpDeg;
dLat2500E = 2500/mpDeg;

% There will be i400/2 of the intervals to the RHS of the central
% longitude. I want to telesope the remainder out to the maximum longitude.

zTelE = latNE - latCenE - j400/2 * dLat400E

% The transition region has the first dz set at dlon800S, and the subsequent
% dz values get larger and larger until they get to the edge. The
% sum of these dz values has to equal the length of the transition region calculated
% above. I've used MMA to devise a scheme that
% finds the slope of the line to machine precision using
%   nTerms=<pick something>
%   Table[dLon800N + (i-1) C, {i,nTerms}]
%   NumberForm[Solve[Apply[Plus,%] == zTel, C],15]
% You try different values of nTerms until you find the value that gives
% the largest final interval that is still smaller than dLon2500N.
%
% For the sourthern edge, nTerms is 19
% NOTE: you have to use the same value for nTerms for the northern edge

nTerms = 17;

dLat400E
dLat2500E
zTelE

C = .00113243452114959;

[dLat400E:C:dLat400E+(nTerms-1)*C]
sum(ans) - zTelE


% Now construct the entire dzLon

% The set of intervals to the right of the center latitude is

[dLat400E*ones(1,j400/2) [dLat400E:C:dLat400E+(nTerms-1)*C] ];

% so the set of longitudes larger than the center latitude is 

rhsE = latCenE + cumsum(  [dLat400E*ones(1,j400/2) [dLat400E:C:dLat400E+(nTerms-1)*C] ]   )  ;

% so the set of longitudes smaller than the center latitude is 

lhsE = latCenE - fliplr(cumsum(  [dLat400E*ones(1,j400/2) [dLat400E:C:dLat400E+(nTerms-1)*C] ]   ))  ;

% and the total set of allowed longitudes is

myLatE =[lhsE, latCenE , rhsE  ];

fig(7);clf;plot(myLatE)
fig(8);clf;plot(diff(myLatE))


% Now pair the latitudes with longitudes, because the longitudes vary as
% you go north.

myLonE = interp1(jLat(:,end),jLon(:,end),myLatE,'linear','extrap');

% a few checks
myLatE(1)   - latSE
myLatE(end) - latNE
length(myLatE)

geodesic_dist(lonSE,latSE,lonNE,latNE)
geodesic_dist(myLonE(1),myLatE(1),myLonE(end),myLatE(end))

aaa=5;


%% Create the coast.in file

% the data write begins in the upper left corner, runs counterclockwise
% until you get back (almost) to the starting point.


nx=length(myLonS); ny=length(myLatW);

%
dumWest = zeros(ny-1,2);
for jj=1:ny-1
    dumWest(jj,1) = myLatW(end-jj+1);
    dumWest(jj,2) = myLonW(end-jj+1);
end


dumSouth = zeros(nx-1,2);
for ii=1:nx-1
    dumSouth(ii,1) = myLatS(ii);
    dumSouth(ii,2) = myLonS(ii);
end

dumEast = zeros(ny-1,2);
for jj=1:ny-1
    dumEast(jj,1) = myLatE(jj);
    dumEast(jj,2) = myLonE(jj);
end

% dumNorth needs one more entry at the end to close the rectangle
dumNorth = zeros(nx,2);
for ii=1:nx
    dumNorth(ii,1) = myLatN(ii);
    dumNorth(ii,2) = myLonN(end-ii+1);
end

coast = vertcat(dumWest,dumSouth,dumEast,dumNorth);

['Include/gridparam.h:  Lm=',num2str(nx-1),'   Mm=',num2str(ny-1)]

save('coast.in','coast','-ascii')


%% Compare PALAU_400m to PALAU_800m

myFinal = 'PALAU_400m.nc';


myLat = nc_varget(myFinal,'lat_psi');
myLon = nc_varget(myFinal,'lon_psi');

%% Plot perimeter


fig(10);clf;
plot(jLon(:,1),jLat(:,1) );hold on;
plot(jLon(:,end),jLat(:,end) )
plot(jLon(1,:),jLat(1,:) )
plot(jLon(end,:),jLat(end,:) )
plot(myLon(:,1),myLat(:,1),'r' )
plot(myLon(:,end),myLat(:,end),'r' )
plot(myLon(1,:),myLat(1,:),'r' )
plot(myLon(end,:),myLat(end,:),'r' )


