clear;

gridFile  = 'NORSEa_4km_posLons.nc';

lon_u   = nc_varget(gridFile,'lon_u');
lon_v   = nc_varget(gridFile,'lon_v');
lon_rho = nc_varget(gridFile,'lon_rho');
lon_psi = nc_varget(gridFile,'lon_psi');

lon_u   = mod(lon_u   + 360,360);
lon_v   = mod(lon_v   + 360,360);
lon_rho = mod(lon_rho + 360,360);
lon_psi = mod(lon_psi + 360,360);

nc_varput(gridFile,'lon_u'  ,lon_u)
nc_varput(gridFile,'lon_v'  ,lon_v)
nc_varput(gridFile,'lon_rho',lon_rho)
nc_varput(gridFile,'lon_psi',lon_psi)