oldRiver = 'Runoff_redoOldStyle/JRA-1.4_SEAKp_rivers_2017.nc';
newRiver = 'Runoff_proto/SEAKp_rivers_09012016_08312017.nc';

old2DFile = 'Runoff_redoOldStyle/SEAKp_runoff_2017.nc';
new2DFile = 'Runoff_proto/runoffData/runoff_NGOA_09012016_08312017.nc';

sourceFile = 'Runoff_proto/sourceData/goa_dischargex_09012016_08312017.nc';


%% The 'transport' variable appears in the ROMS input files, coast only

transportOld = nc_varget(oldRiver,'river_transport');
transportNew = nc_varget(newRiver,'river_transport');

timesOld = nc_varget(oldRiver,'river_time');
timesNew = nc_varget(newRiver,'river_time');

transportOld - transportNew;

ntOld = 1;
ntNew = 1+122;

ntOld = 182;
ntNew = ntOld + 122;

[timesOld(ntOld) timesNew(ntNew)]

fig(1);clf;plot(sq(transportOld(ntOld,:)));ylim([-50 50]);title(['transport using JRA at ',num2str(timesOld(ntOld))])
fig(2);clf;plot(sq(transportNew(ntNew,:)));ylim([-50 50]);title(['transport using Hill at ',num2str(timesNew(ntNew))])


fig(3);clf;plot(sq(transportNew(ntNew,:)));title(['transport using Hill at ',num2str(timesNew(ntNew))])

sq(transportOld(ntOld,:));sum(ans(:))
sq(transportNew(ntNew,:));sum(ans(:))

sq(transportOld(ntOld,:));abs(ans(:));sum(ans(:))
sq(transportNew(ntNew,:));abs(ans(:));sum(ans(:))

aaa=5;

%% The intermediate files are 2D, on my ROMS grid
%   The JRA version ("Old") uses friver
%   The Hill version ("New") uses Runoff


  
friverOld    = nc_varget(old2DFile,'friver');
runoffRawNew = nc_varget(new2DFile,'Runoff_raw');
runoffNew    = nc_varget(new2DFile,'Runoff');

time2DOld    = nc_varget(old2DFile,'time');
time2DNew    = nc_varget(new2DFile,'runoff_time');

latOld       = nc_varget(old2DFile,'lat');
lonOld       = nc_varget(old2DFile,'lon');

latNew       = nc_varget(new2DFile,'lat_rho');
lonNew       = nc_varget(new2DFile,'lon_rho');

latSource    = nc_varget(sourceFile,'lat');
lonSource    = nc_varget(sourceFile,'lon')+360;
q            = nc_varget(sourceFile,'q');


lonOld(1:3,1:3) - lonNew(2:4,2:4)
latOld(1:3,1:3) - latNew(2:4,2:4)

lonOld(end-2:end,end-2:end) - lonNew(end-3:end-1,end-3:end-1)
latOld(end-2:end,end-2:end) - latNew(end-3:end-1,end-3:end-1)


% ntOld = 1;
% ntNew = 123;

[time2DOld(ntOld) time2DNew(ntNew)]    

friverOldZeros = friverOld;
friverOldZeros(isnan(friverOldZeros)) = 0;

fig(11);clf;pcolor(sq(friverOldZeros(ntOld,:,:)));shading flat;colorbar;caxis([0 0.005]);title(['friver from JRA at ',num2str(timesOld(ntOld))])
fig(12);clf;pcolor(sq(runoffNew(ntNew,2:end-1,2:end-1)));shading flat;colorbar;caxis(86400*[0 0.005]);title(['runoff from Hill at ',num2str(timesNew(ntNew))])
fig(13);clf;pcolor(sq(runoffRawNew(ntNew,2:end-1,2:end-1)));shading flat;colorbar;caxis(86400*[0 0.005]);title(['runoff-Raw from Hill at ',num2str(timesNew(ntNew))])

fig(22);clf;pcolor(sq(runoffNew(ntNew,2:end-1,2:end-1)/86400));shading flat;colorbar;caxis([0 0.005]);title(['runoff from Hill at ',num2str(timesNew(ntNew))])




fig(31);clf;colormap(jet)
pcolor(lonOld,latOld,log(sq(friverOldZeros(ntOld,:,:))));shading flat;caxis([-10 -3]);colorbar;title(['ln(friver) from JRA at ',num2str(timesOld(ntOld))])
% fig(32);clf;pcolor(log(sq(runoffNew(ntNew,2:end-1,2:end-1))));shading flat;% ntOld = 1;
% ntNew = 123;
colorbar;title(['ln(runoff) from Hill at ',num2str(timesNew(ntNew))])

fig(33);clf;pcolor(lonNew(2:end-1,2:end-1),latNew(2:end-1,2:end-1),log(sq(runoffNew(ntNew,2:end-1,2:end-1)/86400)));caxis([-10 -3]);shading flat;colorbar;title(['ln(runoff-Raw/86400) from Hill at ',num2str(timesNew(ntNew))])



sq(friverOldZeros(ntOld,:,:)); totJRA = sum(ans(:))
sq(runoffNew(ntNew,2:end-1,2:end-1)); totHill = sum(ans(:))/86400

sq(friverOldZeros(ntOld,:,:)); totJRA = sum(abs(ans(:)))
sq(runoffNew(ntNew,2:end-1,2:end-1)); totHill = sum(abs(ans(:)))/86400


%% Look for that river spike in the source data

gridFile = 'Gridpak/SEAKp_1km.nc';

xposNew = nc_varget(newRiver,'river_Xposition');
yposNew = nc_varget(newRiver,'river_Eposition');

lat_rho = nc_varget(gridFile,'lat_rho');
lon_rho = nc_varget(gridFile,'lon_rho');


dum = sq(transportNew(ntNew,:));
fig(99);clf;plot(dum)

[a,nSpike] = ind2sub(size(dum),find(dum==min(dum)) )

[yposNew(nSpike), xposNew(nSpike)]


fig(95);clf;
plot(sq(transportNew(ntNew,nSpike-10:nSpike+10)) )

latSpike = lat_rho(yposNew(nSpike), xposNew(nSpike) );
lonSpike = lon_rho(yposNew(nSpike), xposNew(nSpike) );
[latSpike, lonSpike]

d = sqrt( (latSource-latSpike).^2 + (lonSource-lonSpike).^2   );
dMin = min(d(:));
[a,~] = find(d == dMin)

[lonSpike,latSpike]
[lonSource(a),latSource(a)]


temp = [a-10:a+10];
[lonSource(temp),latSource(temp),sq(q(ntNew,temp))']


fig(40);clf;pcolor(lonNew(2:end-1,2:end-1),latNew(2:end-1,2:end-1),log(sq(runoffNew(ntNew,2:end-1,2:end-1)/86400)));caxis([3 5]);shading flat;colorbar;title(['ln(runoff-Raw/86400) from Hill at ',num2str(timesNew(ntNew))]);

aaa=5;


%% proto

% nPoints=5;
% myX = rand(nPoints,1);
% myY = rand(nPoints,1);
% myVal = sqrt(myX.^2 + myY.^2);
% 
% [myX,myY,myVal]
% 
% fig(100);clf;
% pcolor([0:1],[0:1],zeros(2,2))
% hold on;
% plot(myX,myY,'*')
% 
% fig(101);clf;
% pcolor([0:1],[0:1],zeros(2,2))
% hold on;
% scatter(myX,myY,[],100*myVal,'*')

%%

fig(200);clf;clf;pcolor(lonNew(2:end-1,2:end-1),latNew(2:end-1,2:end-1),log(sq(runoffNew(ntNew,2:end-1,2:end-1)/86400)));caxis([-10 -3]);shading flat;colorbar;title(['ln(runoff-Raw/86400) from Hill at ',num2str(timesNew(ntNew))])



% pcolor(lonNew,latNew,zeros(size(lonNew)));shading flat
% hold on
scatter(lonSource,latSource,sq(q(ntNew,:))/500000,'.');ylim([54 59.5]);xlim([221 229])
title(['Hill source data ',num2str(timesNew(ntNew))]);

caxis(86400*[0 0.005]);


%%

fig(33);clf;pcolor(lonNew(2:end-1,2:end-1),latNew(2:end-1,2:end-1),sq(runoffNew(ntNew,2:end-1,2:end-1)/86400));shading flat;colorbar;title(['ln(runoff-Raw/86400) from Hill at ',num2str(timesNew(ntNew))]);caxis([0 30000])













