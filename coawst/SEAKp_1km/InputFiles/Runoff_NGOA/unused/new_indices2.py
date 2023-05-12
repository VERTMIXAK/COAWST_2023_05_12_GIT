import matplotlib.pyplot as plt
#import cartopy.crs as ccrs
import numpy as np
import xarray as xr
import xesmf as xe
import netCDF4 as netCDF
import pyroms

##  load 2-dimentional interannual discharge data
print('Load lat_lon')
nc_data = xr.open_dataset('lat_lon.nc')

river_data = xr.open_dataset('../new_2019/goa_dischargex_09012013_08312014.nc')

lon = nc_data.lon
lat = nc_data.lat
mask = nc_data.coast_cells[0,:,:]
#mask = np.where(np.isnan(mask), 0, mask)
Mp, Lp = lon.shape
print(lon.shape)

#  create NWGOA remap file for scrip
print('Create remap grid file for NWGOA grid')
dstgrd = pyroms.grid.get_ROMS_grid('SEAKp_1km')
ds_out = xr.Dataset({'lon': xr.DataArray(dstgrd.hgrid.lon_rho),
                     'lat':xr.DataArray(dstgrd.hgrid.lat_rho),
                     'mask':xr.DataArray(dstgrd.hgrid.mask_rho)})
#dstgrd.hgrid.mask_rho = np.ones(dstgrd.hgrid.mask_rho.shape)

#def regrid(ds_in, ds_out, dr_in, method):
#    """Convenience function for one-time regridding"""
#    regridder = xe.Regridder(ds_in, ds_out, method, periodic=False)
#    dr_out = regridder(dr_in)
#    regridder.clean_weight_file()
#    return dr_out

it = 0
lat1 = river_data.lat[it]
lon1 = river_data.lon[it] + 360.

ii = xr.DataArray(np.zeros(len(river_data.timeSeries)))
jj = xr.DataArray(np.zeros(len(river_data.timeSeries)))
lon2 = xr.DataArray(np.zeros(len(river_data.timeSeries)))
lat2 = xr.DataArray(np.zeros(len(river_data.timeSeries)))

for j in range(Mp):
    for i in range(Lp):
        if (np.isnan(mask[j,i])): continue
        lon2[it] = lon[j,i]
        lat2[it] = lat[j,i]
        if (abs(lon1 - lon2) < .01 and abs(lat1 - lat2) < .01):
            print("Lined up!", i, j, lon1, lon2, lat1, lat2)
            ii[it] = i
            jj[it] = j
            it += 1
            lat1 = river_data.lat[it]
            lon1 = river_data.lon[it] + 360.
        else:
            print("Didn't line up right", i, j, lon1, lon2, lat1, lat2)
#           break

indices = xr.Dataset({'i': (['timeSeries'], ii), 'j': (['timeSeries'], jj), 'lon': (['timeSeries'], lon2),
                    'lat': (['timeSeries'], lat2)})
indices.to_netcdf('indices2.nc')

method = 'nearest_d2s'

#regridder = xe.Regridder(nc_data, ds_out, method, periodic=False)
#for day in range(len(river_data.day)):
