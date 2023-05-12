oldGrid = 'GUAMFinner_1km.nc';
newGrid = 'GUAMFinner_1km_6000m.nc'; 

unix(['cp ',oldGrid,' ',newGrid]);

h = nc_varget(newGrid,'h');

h = 0*h + 6000;

nc_varput(newGrid,'h',h);
