import numpy as np
import netCDF4
import sys

oldncfile = sys.argv[1]
ncfile = sys.argv[2]

oldnc = netCDF4.Dataset(oldncfile, 'a', format='NETCDF3_CLASSIC')
nc    = netCDF4.Dataset(ncfile,    'a', format='NETCDF3_CLASSIC')


dum1 = oldnc.variables['msnswrf'][:,:,:]
dum2 = oldnc.variables['msdwswrf'][:,:,:]
albedo = 1 - dum1 / dum2

nc.variables['albedo'][:,:,:] = albedo

oldnc.close()
nc.close()
