gridFile    = 'BoB4_4km.nc';
oldGridFile = 'BoB4_4km.nc_ORIG';

unix(['cp ',oldGridFile,' ',gridFile]);

wtype = nc_varget(gridFile,'wtype_grid');

wtype = 0*wtype + 2;

nc_varput(gridFile,'wtype_grid',wtype);