clear;close all


pFile  = 'Gridpak_sphFALSE/PRAIRIENest_3km_sphFALSE_parent.nc';
cFile1 = 'Grid_3to1_sphFALSE/PRAIRIENest_3km_child.nc_QCfalse';
cFile2 = 'Grid_3to1_sphFALSE/PRAIRIENest_3km_child.nc_QCtrue';

iMin = 101;
iMax = 120;
jMin = 55;
jMax = 88;

pmP  = nc_varget(pFile ,'pm');
pmC1 = nc_varget(cFile1,'pm');
pmC2 = nc_varget(cFile2,'pm');

% myLimits = 10^-4 * [3.33 3.34];
myLimits = 10^-3 * [.999 1.002];

fig(1);clf
pcolor(pmP(jMin:jMax+1,iMin:iMax+1));shading flat;colorbar
% caxis(myLimits)
title('pm on parent grid (spherical = true)')

fig(2);clf
pcolor(pmC1);shading flat ;colorbar
caxis(myLimits)
title('pm on child grid (QC false, spherical = true)')

fig(3);clf
pcolor(pmC2);shading flat ;
caxis(myLimits)
title('pm on parent grid (spherical = true)')
title('pm on child grid (QC true, spherical = true)')

fig(4);clf;
pcolor(pmP);shading flat;colorbar;
hold on
plot([iMin iMax],[jMin jMin])
plot([iMin iMax],[jMax jMax])
plot([iMin iMin],[jMin jMax])
plot([iMax iMax],[jMin jMax])


