adhlon0 = 218;
lon1 = 230;
lon0 = 220-360;
lon1 = 230-360;
lat0 = 54;
lat1 = 59;

bb = [   [lon0;lon1]  [lat0;lat1 ]]

dum = hls_get_wvs(bb);

%%

load('coastCheck.mat')

wvs.lon = wvs.lon + 360;

gridFile = 'SEAK_1km.nc';

lat = nc_varget(gridFile,'lat_rho');
lon = nc_varget(gridFile,'lon_rho');
mask= nc_varget(gridFile,'mask_rho');

% fig(1);clf;
% pcolor(lon,lat,mask);shading flat;hold on
% plot(wvs.lon,wvs.lat)

[ny,nx] = size(lon);

ivec = [1:nx];
jvec = [round(1/2 * ny):ny];
fig(11);clf;
pcolor(lon(jvec,ivec),lat(jvec,ivec),mask(jvec,ivec));shading flat;hold on
plot(wvs.lon,wvs.lat)


ivec = [1:round(nx/5)];
jvec = [round(4/5 * ny):ny];

fig(2);clf;
pcolor(lon(jvec,ivec),lat(jvec,ivec),mask(jvec,ivec));shading flat;hold on
plot(wvs.lon,wvs.lat)


topoFile = '/import/c1/VERTMIX/jgpender/ROMS/BathyData/topo30.Gridpak_SEAK.nc';
topoLat = nc_varget(topoFile,'topo_lat');
topoLon = nc_varget(topoFile,'topo_lon'); 
topo    = nc_varget(topoFile,'topo');

topoPos = topo;
topoPos(topoPos>0) = 0;

%%

topoI =  find(topoLon>lon0+360 & topoLon < lon1+360  );
topoJ =  find(topoLat>lat0 & topoLat < lat1+.5  );



fig(20);clf;
pcolor(topoLon(topoI),topoLat(topoJ)-.01,-topoPos(topoJ,topoI));shading flat;hold on;caxis([0 700])
plot(wvs.lon,wvs.lat,'r')

