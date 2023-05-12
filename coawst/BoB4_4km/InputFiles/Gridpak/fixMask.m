savedFile = 'BoB3_4km.nc_save';
newFile   = 'BoB3_4km.nc';

old = nc_varget(savedFile,'mask_rho');
nc_varput(newFile,'mask_rho',old);

old = nc_varget(savedFile,'mask_psi');
nc_varput(newFile,'mask_psi',old);

old = nc_varget(savedFile,'mask_u');
nc_varput(newFile,'mask_u',old);

old = nc_varget(savedFile,'mask_v');
nc_varput(newFile,'mask_v',old);