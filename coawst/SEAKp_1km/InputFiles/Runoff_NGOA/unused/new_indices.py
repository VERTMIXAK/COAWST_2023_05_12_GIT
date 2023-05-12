import matplotlib.pyplot as plt
#import cartopy.crs as ccrs
import numpy as np
import xarray as xr
import xesmf as xe
import netCDF4 as netCDF
from scipy import spatial
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
                     'lat': xr.DataArray(dstgrd.hgrid.lat_rho),
                     'mask': xr.DataArray(dstgrd.hgrid.mask_rho)})
#dstgrd.hgrid.mask_rho = np.ones(dstgrd.hgrid.mask_rho.shape)

#def regrid(ds_in, ds_out, dr_in, method):
#    """Convenience function for one-time regridding"""
#    regridder = xe.Regridder(ds_in, ds_out, method, periodic=False)
#    dr_out = regridder(dr_in)
#    regridder.clean_weight_file()
#    return dr_out

it = 0

ii = xr.DataArray(np.zeros(len(river_data.timeSeries)))
jj = xr.DataArray(np.zeros(len(river_data.timeSeries)))
lon2 = xr.DataArray(np.zeros(len(river_data.timeSeries)))
lat2 = xr.DataArray(np.zeros(len(river_data.timeSeries)))

#From Fred

#lon = np.linspace(0,360,361)
#lat = np.linspace(-90,90,181)
#lon2d, lat2d = np.meshgrid(lon, lat)

#ii, jj = np.meshgrid(range(len(lon)), range(len(lat)))

lon2d = dstgrd.hgrid.lon_rho
lat2d = dstgrd.hgrid.lat_rho
Mm, Ll = lat2d.shape

ii, jj = np.meshgrid(range(Ll), range(Mm))
grd = list( zip(np.ravel(lon2d), np.ravel(lat2d)) )
idx = list( zip(np.ravel(ii), np.ravel(jj)) )
#
#pts = ([60.4, 45.1], [275.3, -34.8])
pts = list( zip(np.ravel(river_data.lon + 360.), np.ravel(river_data.lat)) )
#
distance, index = spatial.KDTree(grd).query(pts)
#
#pts_coord = np.asarray(grd)[index]
#pts_idx = np.asarray(idx)[index]



for it in range(len_river_data.timeSeries)):
    lat1 = river_data.lat[it]
    lon1 = river_data.lon[it] + 360.

indices = xr.Dataset({'i': (['timeSeries'], ii), 'j': (['timeSeries'], jj), 'lon': (['timeSeries'], lon2),
                    'lat': (['timeSeries'], lat2)})
indices.to_netcdf('indices.nc')

method = 'nearest_d2s'

#regridder = xe.Regridder(nc_data, ds_out, method, periodic=False)
#for day in range(len(river_data.day)):
