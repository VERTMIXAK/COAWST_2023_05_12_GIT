file = 'GUAMKinnerNest_1km.nc';

h = nc_varget(file,'h');
fig(1);pcolorjw(h);shading flat

min(h(:))

h(h<50) = 50;

min(h(:))

fig(2);pcolorjw(h);shading flat

nc_varput(file,'h',h);