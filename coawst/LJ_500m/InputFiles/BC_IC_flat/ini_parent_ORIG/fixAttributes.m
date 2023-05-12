file = 'LJ_ic_parent.nc';

nc_attadd(file,'coordinates','lon_rho lat_rho ocean_time','zeta')
nc_attadd(file,'coordinates','lon_u lat_u ocean_time','ubar')
nc_attadd(file,'coordinates','lon_v lat_v ocean_time','vbar')
nc_attadd(file,'coordinates','lon_rho lat_rho s_rho ocean_time','temp')
nc_attadd(file,'coordinates','lon_rho lat_rho s_rho ocean_time','salt')
