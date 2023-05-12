import numpy as np
import netCDF4
import sys

# NOTE: modified to ignore southern boundary 


ncfile = sys.argv[1]
nc = netCDF4.Dataset(ncfile, 'a', format='NETCDF3_CLASSIC')


spval = 1.e30




nc.createDimension('dye_time', 1)
nc.createVariable('dye_time', 'f8', ('dye_time'))
nc.variables['dye_time'].units = 'days'
nc.variables['dye_time'][:] = 0.0


# null - create fields for dye and dye_age

west  = 0.0
east  = 0.0
north = 0.0
south = 0.0

nc.createVariable('dye_east_01', 'f8', ('dye_time', 's_rho', 'eta_rho'), fill_value=spval)
nc.variables['dye_east_01'].long_name = 'Eastern boundary condition for dye_01.'
nc.variables['dye_east_01'].units = 'N/A'
nc.variables['dye_east_01'].time = 'dye_time'
nc.variables['dye_east_01'][:] = east

nc.createVariable('dye_west_01', 'f8', ('dye_time', 's_rho', 'eta_rho'), fill_value=spval)
nc.variables['dye_west_01'].long_name = 'Western boundary condition for dye_01.'
nc.variables['dye_west_01'].units = 'N/A'
nc.variables['dye_west_01'].time = 'dye_time'
nc.variables['dye_west_01'][:] = west

nc.createVariable('dye_south_01', 'f8', ('dye_time', 's_rho', 'xi_rho'), fill_value=spval)
nc.variables['dye_south_01'].long_name = 'Southern boundary condition for dye_01.'
nc.variables['dye_south_01'].units = 'N/A'
nc.variables['dye_south_01'].time = 'dye_time'
nc.variables['dye_south_01'][:] = south

nc.createVariable('dye_north_01', 'f8', ('dye_time', 's_rho', 'xi_rho'), fill_value=spval)
nc.variables['dye_north_01'].long_name = 'Northern boundary condition for dye_01.'
nc.variables['dye_north_01'].units = 'N/A'
nc.variables['dye_north_01'].time = 'dye_time'
nc.variables['dye_north_01'][:] = north




nc.createVariable('dye_east_02', 'f8', ('dye_time', 's_rho', 'eta_rho'), fill_value=spval)
nc.variables['dye_east_02'].long_name = 'Eastern boundary condition for dye_01'
nc.variables['dye_east_02'].units = 'N/A'
nc.variables['dye_east_02'].time = 'dye_time'
nc.variables['dye_east_02'][:] = 0.0

nc.createVariable('dye_west_02', 'f8', ('dye_time', 's_rho', 'eta_rho'), fill_value=spval)
nc.variables['dye_west_02'].long_name = 'Western boundary condition for dye_01.'
nc.variables['dye_west_02'].units = 'N/A'
nc.variables['dye_west_02'].time = 'dye_time'
nc.variables['dye_west_02'][:] = 0.0

nc.createVariable('dye_south_02', 'f8', ('dye_time', 's_rho', 'xi_rho'), fill_value=spval)
nc.variables['dye_south_02'].long_name = 'Southern boundary condition for dye_01.'
nc.variables['dye_south_02'].units = 'N/A'
nc.variables['dye_south_02'].time = 'dye_time'
nc.variables['dye_south_02'][:] = 0.0

nc.createVariable('dye_north_02', 'f8', ('dye_time', 's_rho', 'xi_rho'), fill_value=spval)
nc.variables['dye_north_02'].long_name = 'Northern boundary condition for dye_01.'
nc.variables['dye_north_02'].units = 'N/A'
nc.variables['dye_north_02'].time = 'dye_time'
nc.variables['dye_north_02'][:] = 0.0




nc.close()




