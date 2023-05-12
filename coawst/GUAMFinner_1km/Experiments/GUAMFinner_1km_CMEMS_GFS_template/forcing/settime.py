import numpy as np
import netCDF4
import sys

ncfile   = sys.argv[1]
timeVar  = sys.argv[2]
baseDays = sys.argv[3]

print('ncfile  ',ncfile)
print('timeVar ',timeVar)


nc = netCDF4.Dataset(ncfile, 'a', format='NETCDF3_CLASSIC')

time = nc.variables[timeVar][:]
#time = nc.variables['ocean_time'][:]
print('time ', time)
time = float(baseDays) + time/24

print('new time ', time) 

nc.variables[timeVar][:] = time

nc.close()
