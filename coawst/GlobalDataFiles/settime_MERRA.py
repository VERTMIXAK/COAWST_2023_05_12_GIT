import numpy as np
import netCDF4
import sys

ncfile = sys.argv[1]
timeName = sys.argv[2]

print('timeName  ',timeName)

nc = netCDF4.Dataset(ncfile, 'a', format='NETCDF3_CLASSIC')

time = nc.variables[timeName][:]
print(timeName,' ', time)
time = time / 24. /60.

print('new time ', time) 

nc.variables[timeName][:] = time

nc.close()
