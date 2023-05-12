file = 'GUAMLinnerNest_1km.nc';

h = nc_varget(file,'h');
fig(1);pcolorjw(h);shading flat

myMin = 50   % the GUAMLinner_1km.nc has a 50m minimum threshold.

h(h<myMin) = myMin;

min(h(:))

fig(2);pcolorjw(h);shading flat

nc_varput(file,'h',h);