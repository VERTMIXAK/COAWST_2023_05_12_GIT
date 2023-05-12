import numpy as np
import numpy.ma as ma
import netCDF4
#import sys

#ncfile = sys.argv[1]
maskfile = "../coast_cells.nc"
infile = "../new/discharge_1980_1981.nc"
outfile =          "runoff_1980_1981.nc"
nc = netCDF4.Dataset(infile, 'r', format='NETCDF3_64BIT')
mc = netCDF4.Dataset(maskfile, 'r', format='NETCDF3_64BIT')
out = netCDF4.Dataset(outfile, 'w', format='NETCDF3_64BIT')
#out = netCDF4.Dataset(outfile, 'w', format='NETCDF4_CLASSIC')

#slow = nc.variables['slow'][:]
#fast = nc.variables['fast'][:]
discharge = nc.variables['q'][:]
days = nc.variables['time'][:]
mask = mc.variables['coast_cells'][0,:,:]
print(days.shape)
print(days[:])

print(discharge.shape)
ntime, numy, numx = discharge.shape

out.createDimension('x', numx)
out.createDimension('y', numy)
out.createDimension('time', ntime)

out.createVariable('time', 'f8', ('time'))
out.variables['time'].units = 'days since 1900-01-01'
out.createVariable('runoff', 'f4', ('time', 'y', 'x'), fill_value=-9999.)
#out.createVariable('runoff', 'f4', ('time', 'y', 'x'), fill_value=-9999., zlib=True)

for it in np.arange(ntime):
# Now has leap days! and units of days!
    time = days[it] + 25567

    runoff = discharge[it,:,:]
    runoff = ma.masked_where((mask < -100.), runoff)
    out.variables['time'][it] = time
    out.variables['runoff'][it,:,:] = runoff

nc.close()
mc.close()
out.close()
