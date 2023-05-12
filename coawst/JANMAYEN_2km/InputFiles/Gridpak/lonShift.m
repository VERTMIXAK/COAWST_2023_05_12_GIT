myFile='NORSEa_2km.nc'


lon=nc_varget(myFile,'lon_psi');
nc_varput(myFile,'lon_psi',lon+100);
lon=nc_varget(myFile,'lon_rho');
nc_varput(myFile,'lon_rho',lon+100);
lon=nc_varget(myFile,'lon_u');
nc_varput(myFile,'lon_u',lon+100);
lon=nc_varget(myFile,'lon_v');
nc_varput(myFile,'lon_v',lon+100);

