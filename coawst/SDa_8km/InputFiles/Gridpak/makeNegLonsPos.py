import numpy as np
import netCDF4
import sys

ncfile = sys.argv[1]
nc = netCDF4.Dataset(ncfile, 'a', format='NETCDF3_CLASSIC')

lon = nc.variables['lon_rho'][:,:]
lon = (lon+360) % 360
nc.variables['lon_rho'][:,:] = lon

lon = nc.variables['lon_psi'][:,:]
lon = (lon+360) % 360
nc.variables['lon_psi'][:,:] = lon

lon = nc.variables['lon_u'][:,:]
lon = (lon+360) % 360
nc.variables['lon_u'][:,:] = lon

lon = nc.variables['lon_v'][:,:]
lon = (lon+360) % 360
nc.variables['lon_v'][:,:] = lon

nc.close()
