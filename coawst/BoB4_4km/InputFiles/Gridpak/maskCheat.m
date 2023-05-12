file = 'BoB4_4km.nc';
oldFile = '../../../BoB3_4km/InputFiles/Gridpak/BoB3_4km.nc';

lat = nc_varget(file,'lat_rho');
lon = nc_varget(file,'lon_rho');

mask = nc_varget(file,'mask_rho');
oldMask = nc_varget(oldFile,'mask_rho');

fig(1);clf
pcolor(lon,lat,mask);shading flat;hold on
plot(90,15,'*g')

%%

fig(2);clf;
pcolor(mask);shading flat

fig(3);clf;
pcolor(oldMask);shading flat

mask(end-181:end,:) = oldMask;

fig(4);clf;
pcolor(mask);shading flat

nc_varput(file,'mask_rho',mask);