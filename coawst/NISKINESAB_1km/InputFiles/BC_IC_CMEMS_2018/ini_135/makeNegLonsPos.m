clear;

icFileNegLons  = 'CMEMS_2018_146_ic_NISKINE_SA_1km.nc_negLons';
icFile         = 'CMEMS_2018_146_ic_NISKINE_SA_1km.nc';

unix(['cp ',icFileNegLons,' ',icFile]);


lon_u   = nc_varget(icFile,'lon_u');
lon_v   = nc_varget(icFile,'lon_v');
lon_rho = nc_varget(icFile,'lon_rho');
lon_psi = nc_varget(icFile,'lon_psi');

lon_u   = mod(lon_u   + 360,360);
lon_v   = mod(lon_v   + 360,360);
lon_rho = mod(lon_rho + 360,360);
lon_psi = mod(lon_psi + 360,360);

nc_varput(icFile,'lon_u'  ,lon_u)
nc_varput(icFile,'lon_v'  ,lon_v)
nc_varput(icFile,'lon_rho',lon_rho)
nc_varput(icFile,'lon_psi',lon_psi)
