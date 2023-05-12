file = 'MERRA_Vwind_3hours_2020_SD.nc'
var = 'Vwind';
dum = nc_varget(file,var);
dum = 0*dum;
nc_varput(file,var,dum);

file = 'MERRA_Uwind_3hours_2020_SD.nc'
var = 'Uwind';
dum = nc_varget(file,var);
dum = 0*dum;
nc_varput(file,var,dum);

file = 'MERRA_Tair_3hours_2020_SD.nc'
var = 'Tair';
dum = nc_varget(file,var);
dum = 0*dum + 15;
nc_varput(file,var,dum);

file = 'MERRA_swrad_3hours_2020_SD.nc'
var = 'swrad';
dum = nc_varget(file,var);
dum = 0*dum;
nc_varput(file,var,dum);

file = 'MERRA_rain_3hours_2020_SD.nc'
var = 'rain';
dum = nc_varget(file,var);
dum = 0*dum ;
nc_varput(file,var,dum);

file = 'MERRA_Qair_3hours_2020_SD.nc'
var = 'Qair';
dum = nc_varget(file,var);
dum = 0*dum + .01;
nc_varput(file,var,dum);

file = 'MERRA_Pair_3hours_2020_SD.nc'
var = 'Pair';
dum = nc_varget(file,var);
dum = 0*dum +101500;
nc_varput(file,var,dum);

file = 'MERRA_lwrad_down_3hours_2020_SD.nc'
var = 'lwrad_down';
dum = nc_varget(file,var);
dum = 0*dum + 300;
nc_varput(file,var,dum);