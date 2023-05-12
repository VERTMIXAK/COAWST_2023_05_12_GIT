import numpy as np
import netCDF4
import sys

ncfile = sys.argv[1]

nc = netCDF4.Dataset(ncfile,    'a', format='NETCDF3_CLASSIC')

albedo = nc.variables['albedo'][:,:,:]
albedo = 0.06

nc.variables['albedo'][:,:,:] = albedo

nc.close()
