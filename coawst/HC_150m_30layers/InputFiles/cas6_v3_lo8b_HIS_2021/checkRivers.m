riverFile = 'rivers.nc';
gridFile = 'grid_ORIG.nc';

x = nc_varget(riverFile,'river_Xposition');
y = nc_varget(riverFile,'river_Eposition');

mask = nc_varget(gridFile,'mask_rho');

fig(1);clf;
pcolor(mask);shading flat;hold on
plot(x,y)





