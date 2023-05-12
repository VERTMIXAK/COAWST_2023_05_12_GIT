gridFile = 'GUAMLinnerNest_1km.nc';

dum = nc_varget(gridFile,'visc_factor');
dum = 0*dum + 1;
nc_varput(gridFile,'visc_factor',dum);

dum = nc_varget(gridFile,'diff_factor');
dum = 0*dum + 1;
nc_varput(gridFile,'diff_factor',dum);