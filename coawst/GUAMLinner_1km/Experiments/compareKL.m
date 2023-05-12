tabwindow;

dirK = '/import/c1/VERTMIX/jgpender/coawst/GUAMKinner_1km/Experiments/GUAMKinner_1km_2022_074_meso_CMEMS_GFS/';
dirL = '/import/c1/VERTMIX/jgpender/coawst/GUAMLinner_1km/Experiments/GUAMLinner_1km_2022_074_meso/';

hK   = nc_varget([dirK,'../../InputFiles/Gridpak/GUAMKinner_1km.nc'],'h');
latK = nc_varget([dirK,'../../InputFiles/Gridpak/GUAMKinner_1km.nc'],'lat_rho');
lonK = nc_varget([dirK,'../../InputFiles/Gridpak/GUAMKinner_1km.nc'],'lon_rho');

hL   = nc_varget([dirL,'../../InputFiles/Gridpak/GUAMLinner_1km.nc'],'h');
latL = nc_varget([dirL,'../../InputFiles/Gridpak/GUAMLinner_1km.nc'],'lat_rho');
lonL = nc_varget([dirL,'../../InputFiles/Gridpak/GUAMLinner_1km.nc'],'lon_rho');


fig(1);clf;
pcolorjw(lonK,latK,hK);shading flat;caxis([0 6000])

fig(2);clf;
pcolorjw(lonL,latL,hL);shading flat;caxis([0 6000])

fig(3);clf;
plot( sq(latK(:,1)),sq(hK(:,1)))
hold on;
plot( sq(latL(:,1)),sq(hL(:,1)),'r')

fig(4);clf;
plot( sq(latK(:,end)),sq(hK(:,end)))
hold on;
plot( sq(latL(:,end)),sq(hL(:,end)),'r')

fig(5);clf;
plot( sq(lonK(1,:)),sq(hK(1,:)))
hold on;
plot( sq(lonL(1,:)),sq(hL(1,:)),'r')

fig(6);clf;
plot( sq(lonK(end,:)),sq(hK(end,:)))
hold on;
plot( sq(lonL(end,:)),sq(hL(end,:)),'r')


