gridFile = 'PS_UW_grid.nc';

latRho = nc_varget(gridFile,'lat_rho');
lonRho = nc_varget(gridFile,'lon_rho');
maskRho = nc_varget(gridFile,'mask_rho');

fig(1);clf;
pcolor(lonRho,latRho,maskRho);shading flat


fig(2);clf;
pcolor(maskRho);shading flat

x0 =38;
x1 = 130;
y0 = 75;
y1 = 207;

Lm = (x1 - x0)*4
Mm = (y1 - y0)*4

fig(3);clf;

pcolor(maskRho);shading flat;xlim([x0 x1]);ylim([y0 y1])


maskRho = nc_varget(gridFile,'mask_rho');
fig(4);clf;
pcolor(maskRho);shading flat;xlim([x0 x1]);ylim([y0 y1])

[latRho(y1,x0),lonRho(y1,x0)]
[latRho(y0,x0),lonRho(y0,x0)]
[latRho(y0,x1),lonRho(y0,x1)]
[latRho(y1,x1),lonRho(y1,x1)]


%% 




