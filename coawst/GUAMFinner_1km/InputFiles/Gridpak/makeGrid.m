clear; 
% close all;

%% Updated Discussion

% There was a certain amount of flailing for grids GUAMBinner_1km through
% GUAMFinner_1km because Brian Powell's data wasn't on frinkiac any more -
% it was posted online in at least a couple of ways. I am going to clean
% that up by simply cleaving to the 8km-grid data downloads that I've been using for
% the IC/BC files, which reside here:
%       /import/c1/VERTMIX/jgpender/ROMS/UH_archived/GUAM_2022_largeArea
% which contains a grid file a la Powell called
%       GUAM_grid.nc
% which, unlike some of the data Brian posts on that POOIOS site, has a
% footprint that is plenty big enough for our needs.


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

frinkGrid = 'frinkGrid.nc_aSmidgeTooBig';
lon_psi_frink = nc_varget(frinkGrid,'lon_psi');
lat_psi_frink = nc_varget(frinkGrid,'lat_psi');

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


% Notice that there is a weird feature in Brian's grid

% fig(1);clf;
% plot( (lonFrinkSouth(1:end-1)+lonFrinkSouth(2:end) )/2 ,diff(lonFrinkSouth))
% xlabel('longitude');ylabel('diff(longitude)')


aaa=5;

% I want a myLatWest and a myLonWest.

% lat first


%% Stretching



% [ (1) stretch (14) add points (15) ... (ny-14) add points (ny-13) stretch (ny) ]

% Work on the stretching

% I usually use linear stretching, like this. Notice that the derivative of
% the spacing is constant.

% cDum = .293478;
% dum = [1:cDum:8];
% RHS = fliplr([dum 0]);
% LHS = [0 fliplr(dum)];
% 
% fig(90);clf;plot(diff(LHS))

% Harper now wants the following 2 changes
%   1) a sigmoid stretching, so the derivative is continuous
%   2) cut the transition region in half

% So Brian's grid is about 8km so I use his grid points in the interior of
% my grid, but add 8 points between each of Brian's points to give a 1km
% spacing. This region HAD been defined by, for instance
%
%       lon(14:end-13)
%
% The new transition region needs to be reduced to 55-60 km so try this: 
%       from lon(1) to lon(8)
% and
%       from lon(end-7) to lon(end)

% lon1 = lonFrinkSouth(1)
% lon2 = lonFrinkSouth(8)
% 
% lat1 = latFrinkWest(1)
% lat2 = latFrinkWest(8)


nLHS=7;
geodesic_dist(lonFrinkSouth(1),latFrinkSouth(1),lonFrinkSouth(1+nLHS),latFrinkSouth(1+nLHS))
geodesic_dist(lonFrinkSouth(1+nLHS),latFrinkSouth(1+nLHS),lonFrinkSouth(2+nLHS),latFrinkSouth(2+nLHS))/8

nRHS=6;
geodesic_dist(lonFrinkSouth(end-nRHS),latFrinkSouth(end-nRHS),lonFrinkSouth(end),latFrinkSouth(end))
geodesic_dist(lonFrinkSouth(end-nRHS-1),latFrinkSouth(end-nRHS-1),lonFrinkSouth(end-nRHS),latFrinkSouth(end-nRHS))/8

% A sigmoid function that transitions from 1km to 8km looks like this
%   1 + 7 / (1 + exp(-x) )

% dumX = [-4.5:(3+4.5)/14:3];

% Nudge the intervals for each boundary to make sure the derivative is
% smooth.

aaa=5;

%% South 

myVar   = lonFrinkSouth;

% How many Brian gridpoints to get about 60 km from the LHS?
nLHS=7;     
geodesic_dist(lonFrinkSouth(1),latFrinkSouth(1),lonFrinkSouth(1+nLHS),latFrinkSouth(1+nLHS))

pos1   = myVar(1);
pos8   = myVar(1+nLHS);
pos9   = myVar(1+nLHS+1);

% How many Brian gridpoints to get about 60 km from the RHS?
nRHS=6;
geodesic_dist(lonFrinkSouth(end-nRHS),latFrinkSouth(end-nRHS),lonFrinkSouth(end),latFrinkSouth(end))

posEm7 = myVar(end-nRHS-1);
posEm6 = myVar(end-nRHS);
posE   = myVar(end);

% Build the middle section, which goes from
%   lonFrinkSouth(8) to lonFrinkSouth(end-6)
% Reuse Brian's points and do linear interpolation to get the additional
% points that lie between Brian's points.

middle = [];
for nn=1+nLHS:length(myVar)-nRHS-1
    [myVar(nn):(myVar(nn+1)-myVar(nn))/8:myVar(nn+1)];
    middle = [middle ans(1:end-1)];
    aaa=5;
end;
middle = [middle myVar(nn+1)];


% Build the LHS telescoping section

fullDist = pos8 - pos1
shortDist = middle(2)-middle(1)
slope = (middle(2) - middle(1)) / ( ( middle(1) + middle(2) ) /2 )

dumX = [-4.5:(3+4.5)/14:3];
myIntervals = shortDist + 7*shortDist ./ ( 1 + exp(-dumX)  )


% A = shortDist/myIntervals(1);
% B = (fullDist - A*sum(myIntervals) ) / length(myIntervals);

A = ( shortDist * length(myIntervals) - fullDist ) / ( length(myIntervals) * myIntervals(1) - sum(myIntervals) );
B = ( fullDist * myIntervals(1)  - shortDist * sum(myIntervals) ) / ( length(myIntervals) * myIntervals(1) - sum(myIntervals) );
[A B]

telescope = cumsum (  A*myIntervals + B );
% telescope = [0 telescope(1:end-1)]
myLHS = fliplr( pos8 - telescope )

dum=[myLHS middle(1:10)]

fig(97);clf;plot(dum)
title('the longitudes')

fig(98);clf;
diff(dum) ./ ( ( dum(1:end-1) + dum(2:end) )/2)
plot(( ( dum(1:end-1) + dum(2:end) )/2),ans )
title('South first derivative')

fig(99);clf;
diff(diff(dum)) ./ ( ( dum(1:end-2) + dum(3:end) )/2)
plot(( ( dum(1:end-2) + dum(3:end) )/2),ans )
title('South second derivative')


% Build the RHS telescoping section

fullDist = posE - posEm6
shortDist = middle(end)-middle(end-1)
slope = (middle(end) - middle(end-1)) / ( ( middle(end-1) + middle(end) ) /2 )


myIntervals = shortDist + 7*shortDist ./ ( 1 + exp(-dumX)  )

A = ( shortDist * length(myIntervals) - fullDist ) / ( length(myIntervals) * myIntervals(1) - sum(myIntervals) );
B = ( fullDist * myIntervals(1)  - shortDist * sum(myIntervals) ) / ( length(myIntervals) * myIntervals(1) - sum(myIntervals) );
[A B]


telescope =  cumsum ( A*myIntervals + B) ;dumTel=telescope;
myRHS = posEm6 + telescope   - 0;


% myLonSouth = [myLHS middle myRHS];
myLonSouth = middle;

myLatSouth = interp1(lonFrinkSouth,latFrinkSouth,myLonSouth,'linear');

dum = myLonSouth(end-20:end);
fig(97);clf;plot(dum)
title('the longitudes')

fig(98);clf;
diff(dum) ./ ( ( dum(1:end-1) + dum(2:end) )/2)
plot(( ( dum(1:end-1) + dum(2:end) )/2),ans )
title('South first derivative')

fig(99);clf;
diff(diff(dum)) ./ ( ( dum(1:end-2) + dum(3:end) )/2)
plot(( ( dum(1:end-2) + dum(3:end) )/2),ans )
title('South second derivative')


aaa=5;


%% North 

myVar   = lonFrinkNorth;

nLHS=iStretchLL;     
nRHS=iStretchUR; 

geodesic_dist(lonFrinkNorth(1),latFrinkNorth(1),lonFrinkNorth(1+nLHS),latFrinkNorth(1+nLHS))

pos1   = myVar(1);
pos2   = myVar(2);
pos8   = myVar(1+nLHS);
pos9   = myVar(1+nLHS+1);

% How many Brian gridpoints to get about 60 km from the RHS?
nRHS=iStretchUR;
geodesic_dist(lonFrinkNorth(end-nRHS),latFrinkNorth(end-nRHS),lonFrinkNorth(end),latFrinkNorth(end))

posEm7 = myVar(end-nRHS-1);
posEm6 = myVar(end-nRHS);
posEm6 = myVar(end-nRHS);
posE   = myVar(end);

% Build the middle section, which goes from
%   lonFrinkNorth(8) to lonFrinkNorth(end-6)
% Reuse Brian's points and do linear interpolation to get the additional
% points that lie between Brian's points.

middle = [];
for nn=1+nLHS:length(myVar)-nRHS-1
    [myVar(nn):(myVar(nn+1)-myVar(nn))/8:myVar(nn+1)];
    middle = [middle ans(1:end-1)];
    aaa=5;
end;
middle = [middle myVar(nn+1)];


% Build the LHS telescoping section

fullDist = pos8 - pos1;
longDist = pos2 - pos1;
shortDist = middle(2)-middle(1);
slope = (middle(2) - middle(1)) / ( ( middle(1) + middle(2) ) /2 );

dumX = [-4.5:(3+4.5)/14:3];
myIntervals = shortDist + 7*shortDist ./ ( 1 + exp(-dumX)  )


% A = shortDist/myIntervals(1);
% B = (fullDist - A*sum(myIntervals) ) / length(myIntervals);

A = ( shortDist * length(myIntervals) - fullDist ) / ( length(myIntervals) * myIntervals(1) - sum(myIntervals) );
B = ( fullDist * myIntervals(1)  - shortDist * sum(myIntervals) ) / ( length(myIntervals) * myIntervals(1) - sum(myIntervals) );
[A B]

telescope = cumsum (  A*myIntervals + B );
% telescope = [0 telescope(1:end-1)]
myLHS = fliplr( pos8 - telescope )

dum=[myLHS middle(1:10)]

fig(97);clf;plot(dum)
title('the longitudes')

fig(98);clf;
diff(dum) ./ ( ( dum(1:end-1) + dum(2:end) )/2)
plot(( ( dum(1:end-1) + dum(2:end) )/2),ans )
title('Nouth first derivative')

fig(99);clf;
diff(diff(dum)) ./ ( ( dum(1:end-2) + dum(3:end) )/2)
plot(( ( dum(1:end-2) + dum(3:end) )/2),ans )
title('Nouth second derivative')


% Build the RHS telescoping section

fullDist = posE - posEm6
shortDist = middle(end)-middle(end-1)
slope = (middle(end) - middle(end-1)) / ( ( middle(end-1) + middle(end) ) /2 )


myIntervals = shortDist + 7*shortDist ./ ( 1 + exp(-dumX)  )

A = ( shortDist * length(myIntervals) - fullDist ) / ( length(myIntervals) * myIntervals(1) - sum(myIntervals) );
B = ( fullDist * myIntervals(1)  - shortDist * sum(myIntervals) ) / ( length(myIntervals) * myIntervals(1) - sum(myIntervals) );
[A B]


telescope =  cumsum ( A*myIntervals + B) ;dumTel=telescope;
myRHS = posEm6 + telescope   - 0;


% myLonNorth = [myLHS middle myRHS];
myLonNorth = middle;

myLatNorth = interp1(lonFrinkNorth,latFrinkNorth,myLonNorth,'linear');

dum = myLonNorth(end-20:end);
fig(97);clf;plot(dum)
title('the longitudes')

fig(98);clf;
diff(dum) ./ ( ( dum(1:end-1) + dum(2:end) )/2)
plot(( ( dum(1:end-1) + dum(2:end) )/2),ans )
title('Nouth first derivative')

fig(99);clf;
diff(diff(dum)) ./ ( ( dum(1:end-2) + dum(3:end) )/2)
plot(( ( dum(1:end-2) + dum(3:end) )/2),ans )
title('Nouth second derivative')


aaa=5;



%% West 

myVar   = latFrinkWest;

% How many Brian gridpoints to get about 60 km from the LHS?
nLHS=7;     
geodesic_dist(lonFrinkWest(1),latFrinkWest(1),lonFrinkWest(1+nLHS),latFrinkWest(1+nLHS))

pos1   = myVar(1);
pos8   = myVar(1+nLHS);
pos9   = myVar(1+nLHS+1);

% How many Brian gridpoints to get about 60 km from the RHS?
nRHS=7;
geodesic_dist(lonFrinkWest(end-nRHS),latFrinkWest(end-nRHS),lonFrinkWest(end),latFrinkWest(end))

posEm7 = myVar(end-nRHS-1);
posEm6 = myVar(end-nRHS);
posE   = myVar(end);

% Build the middle section, which goes from
%   lonFrinkWest(8) to lonFrinkWest(end-6)
% Reuse Brian's points and do linear interpolation to get the additional
% points that lie between Brian's points.

middle = [];
for nn=1+nLHS:length(myVar)-nRHS-1
    [myVar(nn):(myVar(nn+1)-myVar(nn))/8:myVar(nn+1)];
    middle = [middle ans(1:end-1)];
    aaa=5;
end;
middle = [middle myVar(nn+1)];


% Build the LHS telescoping section

fullDist = pos8 - pos1
shortDist = middle(2)-middle(1)
slope = (middle(2) - middle(1)) / ( ( middle(1) + middle(2) ) /2 )

dumX = [-4.5:(3+4.5)/14:3];
myIntervals = shortDist + 7*shortDist ./ ( 1 + exp(-dumX)  )


% A = shortDist/myIntervals(1);
% B = (fullDist - A*sum(myIntervals) ) / length(myIntervals);

A = ( shortDist * length(myIntervals) - fullDist ) / ( length(myIntervals) * myIntervals(1) - sum(myIntervals) );
B = ( fullDist * myIntervals(1)  - shortDist * sum(myIntervals) ) / ( length(myIntervals) * myIntervals(1) - sum(myIntervals) );
[A B]

telescope = cumsum (  A*myIntervals + B );
% telescope = [0 telescope(1:end-1)]
myLHS = fliplr( pos8 - telescope )

dum=[myLHS middle(1:10)]

fig(97);clf;plot(dum)
title('the longitudes')

fig(98);clf;
diff(dum) ./ ( ( dum(1:end-1) + dum(2:end) )/2)
plot(( ( dum(1:end-1) + dum(2:end) )/2),ans )
title('West first derivative')

fig(99);clf;
diff(diff(dum)) ./ ( ( dum(1:end-2) + dum(3:end) )/2)
plot(( ( dum(1:end-2) + dum(3:end) )/2),ans )
title('West second derivative')


% Build the RHS telescoping section

fullDist = posE - posEm6
shortDist = middle(end)-middle(end-1)
slope = (middle(end) - middle(end-1)) / ( ( middle(end-1) + middle(end) ) /2 )


myIntervals = shortDist + 7*shortDist ./ ( 1 + exp(-dumX)  )

A = ( shortDist * length(myIntervals) - fullDist ) / ( length(myIntervals) * myIntervals(1) - sum(myIntervals) );
B = ( fullDist * myIntervals(1)  - shortDist * sum(myIntervals) ) / ( length(myIntervals) * myIntervals(1) - sum(myIntervals) );
[A B]


telescope =  cumsum ( A*myIntervals + B) ;dumTel=telescope;
myRHS = posEm6 + telescope   - 0;


% myLatWest = [myLHS middle myRHS];
myLatWest = middle;

myLonWest = interp1(latFrinkWest,lonFrinkWest,myLatWest,'linear');

dum = myLatWest(end-20:end);
fig(97);clf;plot(dum)
title('the longitudes')

fig(98);clf;
diff(dum) ./ ( ( dum(1:end-1) + dum(2:end) )/2)
plot(( ( dum(1:end-1) + dum(2:end) )/2),ans )
title('West first derivative')

fig(99);clf;
diff(diff(dum)) ./ ( ( dum(1:end-2) + dum(3:end) )/2)
plot(( ( dum(1:end-2) + dum(3:end) )/2),ans )
title('West second derivative')


aaa=5;



%% East 

myVar   = latFrinkEast;

% How many Brian gridpoints to get about 60 km from the LHS?
nLHS=7;     
geodesic_dist(lonFrinkEast(1),latFrinkEast(1),lonFrinkEast(1+nLHS),latFrinkEast(1+nLHS))

pos1   = myVar(1);
pos8   = myVar(1+nLHS);
pos9   = myVar(1+nLHS+1);

% How many Brian gridpoints to get about 60 km from the RHS?
nRHS=7;
geodesic_dist(lonFrinkEast(end-nRHS),latFrinkEast(end-nRHS),lonFrinkEast(end),latFrinkEast(end))

posEm7 = myVar(end-nRHS-1);
posEm6 = myVar(end-nRHS);
posE   = myVar(end);

% Build the middle section, which goes from
%   lonFrinkEast(8) to lonFrinkEast(end-6)
% Reuse Brian's points and do linear interpolation to get the additional
% points that lie between Brian's points.

middle = [];
for nn=1+nLHS:length(myVar)-nRHS-1
    [myVar(nn):(myVar(nn+1)-myVar(nn))/8:myVar(nn+1)];
    middle = [middle ans(1:end-1)];
    aaa=5;
end;
middle = [middle myVar(nn+1)];


% Build the LHS telescoping section

fullDist = pos8 - pos1
shortDist = middle(2)-middle(1)
slope = (middle(2) - middle(1)) / ( ( middle(1) + middle(2) ) /2 )

dumX = [-4.5:(3+4.5)/14:3];
myIntervals = shortDist + 7*shortDist ./ ( 1 + exp(-dumX)  )


% A = shortDist/myIntervals(1);
% B = (fullDist - A*sum(myIntervals) ) / length(myIntervals);

A = ( shortDist * length(myIntervals) - fullDist ) / ( length(myIntervals) * myIntervals(1) - sum(myIntervals) );
B = ( fullDist * myIntervals(1)  - shortDist * sum(myIntervals) ) / ( length(myIntervals) * myIntervals(1) - sum(myIntervals) );
[A B]

telescope = cumsum (  A*myIntervals + B );
% telescope = [0 telescope(1:end-1)]
myLHS = fliplr( pos8 - telescope )

dum=[myLHS middle(1:10)]

fig(97);clf;plot(dum)
title('the longitudes')

fig(98);clf;
diff(dum) ./ ( ( dum(1:end-1) + dum(2:end) )/2)
plot(( ( dum(1:end-1) + dum(2:end) )/2),ans )
title('East first derivative')

fig(99);clf;
diff(diff(dum)) ./ ( ( dum(1:end-2) + dum(3:end) )/2)
plot(( ( dum(1:end-2) + dum(3:end) )/2),ans )
title('East second derivative')


% Build the RHS telescoping section

fullDist = posE - posEm6
shortDist = middle(end)-middle(end-1)
slope = (middle(end) - middle(end-1)) / ( ( middle(end-1) + middle(end) ) /2 )


myIntervals = shortDist + 7*shortDist ./ ( 1 + exp(-dumX)  )

A = ( shortDist * length(myIntervals) - fullDist ) / ( length(myIntervals) * myIntervals(1) - sum(myIntervals) );
B = ( fullDist * myIntervals(1)  - shortDist * sum(myIntervals) ) / ( length(myIntervals) * myIntervals(1) - sum(myIntervals) );
[A B]


telescope =  cumsum ( A*myIntervals + B) ;dumTel=telescope;
myRHS = posEm6 + telescope   - 0;


% myLatEast = [myLHS middle myRHS];
myLatEast = middle;

myLonEast = interp1(latFrinkEast,lonFrinkEast,myLatEast,'linear');

dum = myLatEast(end-20:end);
fig(97);clf;plot(dum)
title('the longitudes')

fig(98);clf;
diff(dum) ./ ( ( dum(1:end-1) + dum(2:end) )/2)
plot(( ( dum(1:end-1) + dum(2:end) )/2),ans )
title('East first derivative')

fig(99);clf;
diff(diff(dum)) ./ ( ( dum(1:end-2) + dum(3:end) )/2)
plot(( ( dum(1:end-2) + dum(3:end) )/2),ans )
title('East second derivative')


aaa=5;




%% Double check

fig(99);clf;
plot(myLonWest,myLatWest,'*');hold on
plot(myLonEast,myLatEast,'*');
plot(myLonNorth,myLatNorth,'*');
plot(myLonSouth,myLatSouth,'*');






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

