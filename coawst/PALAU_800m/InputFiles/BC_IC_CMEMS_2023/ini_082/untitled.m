file = 'CMEMSsource_002_flat.nc';
time = nc_varget(file,'ocean_time') 

aaa=5;

nc_varput(file,'ocean_time',time + .5);