tabwindow; clear;

UHfile = 'surf_Jan.nc'

dirUW = '/import/c1/VERTMIX/jgpender/coawst/GlobalDataFiles/GFS_PALAU/GFS_'
dirMERRA = '/import/c1/VERTMIX/jgpender/coawst/GlobalDataFiles/MERRA_PALAU/MERRA_'

latUH = nc_varget(UHfile,'lat');
lonUH = nc_varget(UHfile,'lon');

latUW = nc_varget([dirUW,'swrad_2022.nc'],'lat');
lonUW = nc_varget([dirUW,'swrad_2022.nc'],'lon');

latMERRA = nc_varget([dirMERRA,'swrad_2021.nc'],'lat');
lonMERRA = nc_varget([dirMERRA,'swrad_2021.nc'],'lon');


%% swrad

var = 'swrad';
varUH = nc_varget(UHfile,var);
varUW = nc_varget([dirUW,var,'_2022.nc'],var);
varMERRA = nc_varget([dirMERRA,var,'_2021.nc'],var);

fig(1);clf
pcolor(lonUH,latUH,sq(varUH( 1,:,:)));shading flat;colorbar
title(['UH - ',var])
caxis([0 800])

fig(2);clf
pcolor(lonUW,latUW,sq(varUW(1,:,:)));shading flat;colorbar
title(['UW - ',var])
caxis([0 800])

fig(3);clf
pcolor(lonMERRA,latMERRA,sq(varMERRA(1,:,:)));shading flat;colorbar
title(['MERRA - ',var])
caxis([0 800])

%% Uwind

var = 'Uwind';
varUH = nc_varget(UHfile,var);
varUW = nc_varget([dirUW,var,'_2022.nc'],var);
varMERRA = nc_varget([dirMERRA,var,'_2021.nc'],var);

fig(1);clf
pcolor(lonUH,latUH,sq(varUH( 1,:,:)));shading flat;colorbar
caxis([-15 10])
title(['UH - ',var])

fig(2);clf
pcolor(lonUW,latUW,sq(varUW(1,:,:)));shading flat;colorbar
caxis([-15 10])
title(['UW - ',var])

fig(3);clf
pcolor(lonMERRA,latMERRA,sq(varMERRA(1,:,:)));shading flat;colorbar
caxis([-15 10])
title(['MERRA - ',var])
