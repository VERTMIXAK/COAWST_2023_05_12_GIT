close all

jraFile = '/import/AKWATERS/kshedstrom/JRA55-flooded/runoff_JRA55-do-1-4-0_2018.nc';

friver = nc_varget(jraFile,'friver');
lat = nc_varget(jraFile,'lat');
lon = nc_varget(jraFile,'lon');
size(friver)





% fig(1);clf;
% pcolor(sq(friver(1,:,:)));shading flat
% xlim([1155 1165]);
% ylim([525 530]);
% caxis([0 .001])

jRange = [524:528];
iRange = [1153:1157];
fig(2);clf;
pcolor(lon(iRange),lat(jRange),sq(friver(1,jRange,iRange)));shading flat
colorbar

% The dominant pixel is at
myJ = 526;
myI = 1155;

dx = geodesic_dist(lon(myI),lat(myJ),lon(myI+1),lat(myJ));
dy = geodesic_dist(lon(myI),lat(myJ),lon(myI),lat(myJ+1));



Area = dx*dy;
friver(1,myJ,myI) * Area


