import numpy as np
import netCDF4
import sys

ncfile = sys.argv[1]
nc = netCDF4.Dataset(ncfile, 'a', format='NETCDF3_CLASSIC')


rain = nc.variables['rain'][:,:,:]
Tair = rain / 3.6

nc.variables['rain'][:,:,:] = rain

nc.close()
