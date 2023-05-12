import numpy as np
import netCDF4
import sys

ncfile = sys.argv[1]
nc = netCDF4.Dataset(ncfile, 'a', format='NETCDF3_CLASSIC')


dum = nc.variables['spherical'][:]
print('spherical ', dum)
dum = 0

print('new spherical ', dum) 

nc.variables['spherical'][:] = dum

nc.close()
