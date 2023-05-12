import pycnal
import pycnal_toolbox
import numpy as np
import xarray as xr
from scipy import spatial

grd = pycnal.grid.get_ROMS_grid('SEAKp_1km')

lon2 = xr.DataArray(grd.hgrid.lon_psi)
ds_out = xr.Dataset({'lon': xr.DataArray(grd.hgrid.lon_psi), 'lat':xr.DataArray(grd.hgrid.lat_psi)})


river_data = xr.open_dataset('/import/c1/VERTMIX/jgpender/roms-kate_svn/SEAKp_1km/InputFiles/Runoff_NGOA/sourceData/goa_dischargex_09012017_08312018.nc')
runoff_file = 'runoff_NGOA_09012017_08312018.nc'




print(len(river_data.year))


river_data.lon[0:10]+360, river_data.lat[0:10]


print(len(river_data.timeSeries))


lon2d = grd.hgrid.lon_psi
lat2d = grd.hgrid.lat_psi
Mm, Ll = lat2d.shape


ii, jj = np.meshgrid(range(Ll), range(Mm))
grd2 = list( zip(np.ravel(lon2d), np.ravel(lat2d)) )
idx = list( zip(np.ravel(ii), np.ravel(jj)) )


pts = list( zip(np.ravel(river_data.lon + 360.), np.ravel(river_data.lat)) )


distance, index = spatial.KDTree(grd2).query(pts)
print(distance, max(distance))


print('jgp flag1')

pts_coord = np.asarray(grd2)[index]
pts_idx = np.asarray(idx)[index]




indices = xr.Dataset({'i': (['river'], pts_idx[:,0]), 'j': (['river'], pts_idx[:,1])})


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



import netCDF4 as netCDF
from datetime import datetime
nt = len(river_data.time)
Mp, Lp = grd.hgrid.mask_rho.shape
spval = -9999.
runoff_raw = np.zeros((Mp,Lp))
runoff = np.zeros((Mp,Lp))

nc = netCDF.Dataset(runoff_file, 'w', format='NETCDF3_64BIT')
nc.Description = 'Hill & Beamer monthly climatology river discharge'
nc.Author = 'make_runoff_clim.py'
nc.Created = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
nc.title = 'Hill & Beamer river discharge'

nc.createDimension('xi_rho', np.size(grd.hgrid.mask_rho,1))
nc.createDimension('eta_rho', np.size(grd.hgrid.mask_rho,0))
nc.createDimension('runoff_time', None)

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

nc.createVariable('Runoff_raw', 'f8', ('runoff_time', 'eta_rho', 'xi_rho'), fill_value=spval)
nc.variables['Runoff_raw'].long_name = 'Dai_Trenberth River Runoff raw'
nc.variables['Runoff_raw'].units = 'kg/s/m^2'

nc.createVariable('Runoff', 'f8', ('runoff_time', 'eta_rho', 'xi_rho'), fill_value=spval)
nc.variables['Runoff'].long_name = 'Dai_Trenberth River Runoff'
nc.variables['Runoff'].units = 'kg/s/m^2'


import datetime
date1 = datetime.date(1900, 1, 1)


print(river_data.q)



for t in range(nt):
    flow = np.sum(river_data.q[t,:])
    dater = datetime.date(river_data.year[t], river_data.month[t], river_data.day[t])
    time = (dater - date1).days
    print('Remapping runoff for time %f' %time)
    runoff_raw = np.zeros((Mp,Lp))
    runoff = np.zeros((Mp,Lp))
    for ri in range(len(river_data.timeSeries)):
        i = indices.i[ri]
        j = indices.j[ri]
        if (i > 323 or j == 0):
            continue
        runoff_raw[j,i] += float(river_data.q[t,ri])

    nflow = np.sum(runoff_raw)
    print('time', t, flow/nflow)
    idx = np.where(runoff_raw != 0)
    runoff = pycnal_toolbox.move_runoff(runoff_raw,                \
           np.array(idx).T + 1, np.array(littoral_idx).T + 1, maskl,      \
           grd.hgrid.x_rho, grd.hgrid.y_rho, grd.hgrid.dx, grd.hgrid.dy)

    nc.variables['Runoff'][t] = runoff
    nc.variables['Runoff_raw'][t] = runoff_raw
    nc.variables['runoff_time'][t] = time

    if t==5:
        print('Sum 3', np.sum(runoff_raw))
        print('Sum 4', np.sum(runoff))

nc.close()

