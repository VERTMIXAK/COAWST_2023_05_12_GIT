file = 'LJ_500m.nc';

dum = nc_varget(file,'mask_rho');
nc_varput(file,'mask_rho',dum*0+1);

dum = nc_varget(file,'mask_psi');
nc_varput(file,'mask_psi',dum*0+1);

dum = nc_varget(file,'mask_u');
nc_varput(file,'mask_u',dum*0+1);

dum = nc_varget(file,'mask_v');
nc_varput(file,'mask_v',dum*0+1);