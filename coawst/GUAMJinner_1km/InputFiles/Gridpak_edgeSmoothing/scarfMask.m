oldFile = '/import/c1/VERTMIX/jgpender/coawst/GUAMDinner_1km/InputFiles/Gridpak/GUAMDinner_1km.nc';

newFile = 'GUAMEinner_1km.nc';

dum = nc_varget(oldFile,'mask_rho');
nc_varput(newFile,'mask_rho',dum);


dum = nc_varget(oldFile,'mask_psi');
nc_varput(newFile,'mask_psi',dum);

dum = nc_varget(oldFile,'mask_u');
nc_varput(newFile,'mask_u',dum);

dum = nc_varget(oldFile,'mask_v');
nc_varput(newFile,'mask_v',dum);
