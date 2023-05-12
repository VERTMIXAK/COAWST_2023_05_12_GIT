sourceFile = '../Grid_1to1_sphTRUE/PRAIRIENest_3km_child.nc';
localFile = 'PRAIRIENest_3km_child.nc';

var = 'lat_rho';
dum = nc_varget(sourceFile,var);
nc_varput(localFile,var,dum);

var = 'lon_rho';
dum = nc_varget(sourceFile,var);
nc_varput(localFile,var,dum);

var = 'lat_psi';
dum = nc_varget(sourceFile,var);
nc_varput(localFile,var,dum);

var = 'lon_psi';
dum = nc_varget(sourceFile,var);
nc_varput(localFile,var,dum);

var = 'lat_u';
dum = nc_varget(sourceFile,var);
nc_varput(localFile,var,dum);

var = 'lon_u';
dum = nc_varget(sourceFile,var);
nc_varput(localFile,var,dum);

var = 'lat_v';
dum = nc_varget(sourceFile,var);
nc_varput(localFile,var,dum);

var = 'lon_v';
dum = nc_varget(sourceFile,var);
nc_varput(localFile,var,dum);
