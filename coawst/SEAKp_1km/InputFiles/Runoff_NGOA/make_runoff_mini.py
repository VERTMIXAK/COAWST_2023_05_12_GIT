import numpy as np
import netCDF4 as netCDF
from datetime import datetime

import pycnal
import pycnal_toolbox


# load 2-dimentional interannual discharge data
# from 1948-2007. See Dai and Trenberth (2002) and Dai et al. (2009)
print('Load interannual discharge data')
#nc_data = netCDF.Dataset('runoff_2008_2009a.nc', 'r')
#runoff_file =       'NGOA_runoff_2008_2009.nc'
nc_data = netCDF.Dataset('runoff_2014a.nc', 'r')
runoff_file =       'MINI_runoff_2014.nc'
time = nc_data.variables['time'][:]
data = nc_data.variables['runoff'][:]

## time: cyclic year (365.25 days)
#time = np.array([15.21875, 45.65625, 76.09375, 106.53125, 136.96875, 167.40625, \
#    197.84375, 228.28125, 258.71875, 289.15625, 319.59375, 350.03125])


# load MINI grid object
grd = pycnal.grid.get_ROMS_grid('MINI')


# define some variables
wts_file = 'remap_weights_runoff_to_MINI_conservative_nomask.nc'
nt = data.shape[0]
Mp, Lp = grd.hgrid.mask_rho.shape
#spval = -1e30
spval = -9999.
runoff_raw = np.zeros((Mp,Lp))
runoff = np.zeros((Mp,Lp))

# create runoff file
#runoff_file = 'runoff_MINI_daitren_inter_annual_2002-2004.nc'
nc = netCDF.Dataset(runoff_file, 'w', format='NETCDF3_64BIT')
nc.Description = 'Hill & Beamer monthly climatology river discharge'
nc.Author = 'make_runoff_clim.py'
nc.Created = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
nc.title = 'Hill & Beamer river discharge'

# create dimensions and variables
nc.createDimension('xi_rho', np.size(grd.hgrid.mask_rho,1))
nc.createDimension('eta_rho', np.size(grd.hgrid.mask_rho,0))
nc.createDimension('runoff_time', None)
#nc.createDimension('runoff_time', (365))

nc.createVariable('lon_rho', 'f8', ('eta_rho', 'xi_rho'))
nc.variables['lon_rho'].long_name = 'longitude of RHO-points'
nc.variables['lon_rho'].units = 'degree_east'
nc.variables['lon_rho'].field = 'lon_rho, scalar'
nc.variables['lon_rho'][:] = grd.hgrid.lon_rho

nc.createVariable('lat_rho', 'f8', ('eta_rho', 'xi_rho'))
nc.variables['lat_rho'].long_name = 'latitude of RHO-points'
nc.variables['lat_rho'].units = 'degree_north'
nc.variables['lat_rho'].field = 'lat_rho, scalar'
nc.variables['lat_rho'][:] = grd.hgrid.lat_rho

nc.createVariable('runoff_time', 'f8', ('runoff_time'))
nc.variables['runoff_time'].long_name = 'time'
nc.variables['runoff_time'].units = 'days since 1900-01-01 00:00:00'
#nc.variables['runoff_time'].cycle_length = 365.25

nc.createVariable('Runoff_raw', 'f8', ('runoff_time', 'eta_rho', 'xi_rho'), fill_value=spval)
nc.variables['Runoff_raw'].long_name = 'Dai_Trenberth River Runoff raw'
nc.variables['Runoff_raw'].units = 'kg/s/m^2'

nc.createVariable('Runoff', 'f8', ('runoff_time', 'eta_rho', 'xi_rho'), fill_value=spval)
nc.variables['Runoff'].long_name = 'Dai_Trenberth River Runoff'
nc.variables['Runoff'].units = 'kg/s/m^2'


# get littoral (here just 1 cell wide, no diagonals)
width = 1
idx = []
idy = []
maskl = grd.hgrid.mask_rho.copy()
for w in range(width):
    lit = pycnal_toolbox.get_littoral2(maskl)
    idx.extend(lit[0])
    idy.extend(lit[1])
    maskl[lit] = 0

littoral_idx = (np.array(idx), np.array(idy))
maskl = np.zeros(grd.hgrid.mask_rho.shape)
maskl[littoral_idx] = 1

mask_idx = np.where(grd.hgrid.mask_rho == 0)

for t in range(nt):
    flow = np.sum(data[t,:,:])
    print('Remapping runoff for time %f' %time[t])
    # conservative horizontal interpolation using scrip
    runoff_raw = pycnal.remapping.remap(data[t,:,:], wts_file, \
                                           spval=spval)
    nflow = np.sum(runoff_raw)
    print('time', t, flow, nflow)
    runoff_raw = runoff_raw*flow/nflow
    idx = np.where(runoff_raw != 0)
    runoff = pycnal_toolbox.move_runoff(runoff_raw, \
                  np.array(idx).T + 1, np.array(littoral_idx).T + 1, maskl, \
                  grd.hgrid.x_rho, grd.hgrid.y_rho, grd.hgrid.dx, grd.hgrid.dy)

# write data in destination file
    nc.variables['Runoff'][t] = runoff
    nc.variables['Runoff_raw'][t] = runoff_raw
    nc.variables['runoff_time'][t] = time[t]

    if t==5:
        print('Sum 3', np.sum(runoff_raw))
        print('Sum 4', np.sum(runoff))

nc.close()
