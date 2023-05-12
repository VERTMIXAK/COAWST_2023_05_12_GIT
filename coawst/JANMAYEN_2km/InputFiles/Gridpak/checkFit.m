close all;

barentsFile = '/import/c1/VERTMIX/jgpender/ROMS/Barents/NORSE_2022_SA/data_Barents/barents_eps_zdepth_2022-10-01.nc';
% barentsFile = '/import/VERTMIX/NORSE2022_SA/barents_eps_zdepth_surface/barents_eps_zdepth_2022-11-04_surface.nc';
gridFile    = 'JANMAYEN_2km.nc';

maskB = nc_varget(barentsFile,'sea_mask');
latB = nc_varget(barentsFile,'lat');
lonB = nc_varget(barentsFile,'lon');

fig(1);clf;
pcolor(lonB,latB,maskB);shading flat
hold on;
plot(-13.2,72.92,'*r')
plot(-11.95,69.49,'*r')
plot(2.21,69.49,'*r')
plot(2.27,72.92,'*r')






