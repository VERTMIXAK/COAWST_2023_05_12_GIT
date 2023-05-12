import numpy as np
import netCDF4
import sys

ncfile = sys.argv[1]
timeName = sys.argv[2]

nc = netCDF4.Dataset(ncfile, 'a', format='NETCDF3_CLASSIC')


time = nc.variables[timeName][:]
print('time ', time)
time = (time + 3155673600)/86400

print('new time ', time) 

nc.variables[timeName][:] = time

nc.close()
