import numpy as np
import netCDF4
import sys

ncfile = sys.argv[1]
nc = netCDF4.Dataset(ncfile, 'a', format='NETCDF3_CLASSIC')


time = nc.variables['river_time'][:]
print('time ', time)


# this converts seconds since 1/1/1970 to days since 1/1/1900
timeShift = 2208988800 
time = time + timeShift
time = time / 86400

print('new time ', time)


nc.variables['river_time'][:] = time

nc.close()
