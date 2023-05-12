file = 'GUAMFinner_1km_tides.nc';
newfile = 'GUAMFinner_1km_tides_zeroed.nc';

unix(['cp ',file,' ',newfile])

dum = nc_varget(file,'tide_Eamp');
nc_varput(newfile,'tide_Eamp',0*dum);

dum = nc_varget(file,'tide_Cmax');
nc_varput(newfile,'tide_Cmax',0*dum);

dum = nc_varget(file,'tide_Cmin');
nc_varput(newfile,'tide_Cmin',0*dum);
