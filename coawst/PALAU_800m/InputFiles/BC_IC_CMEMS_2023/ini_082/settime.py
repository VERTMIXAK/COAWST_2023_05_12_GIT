import numpy as np
import netCDF4
import sys

ncfile = sys.argv[1]
nc = netCDF4.Dataset(ncfile, 'a', format='NETCDF3_CLASSIC')


time = nc.variables['ocean_time'][:]
print('time ', time)
#time = time / 24 - 18262 + 36524
#time = 44723
time = 44573
print('new time ', time) 

nc.variables['ocean_time'][:] = time

nc.close()
