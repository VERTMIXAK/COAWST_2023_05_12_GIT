clear;

bcFileNegLons  = 'CMEMS_2018_bdry_NISKINE_SA_1km.nc_negLons';
bcFile         = 'CMEMS_2018_bdry_NISKINE_SA_1km.nc';

unix(['cp ',bcFileNegLons,' ',bcFile]);


lon_u   = nc_varget(bcFile,'lon_u');
lon_v   = nc_varget(bcFile,'lon_v');
lon_rho = nc_varget(bcFile,'lon_rho');
lon_psi = nc_varget(bcFile,'lon_psi');

lon_u   = mod(lon_u   + 360,360);
lon_v   = mod(lon_v   + 360,360);
lon_rho = mod(lon_rho + 360,360);
lon_psi = mod(lon_psi + 360,360);

nc_varput(bcFile,'lon_u'  ,lon_u)
nc_varput(bcFile,'lon_v'  ,lon_v)
nc_varput(bcFile,'lon_rho',lon_rho)
nc_varput(bcFile,'lon_psi',lon_psi)
