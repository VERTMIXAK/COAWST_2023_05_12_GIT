import numpy as np
import pandas as pd
import xarray as xr
import xesmf as xe

ds = xr.open_dataset('../psdem_2000/psdem_LatLon.nc')
ds_out = xr.open_dataset('../makeMerc/forXesmf.nc')

dr = ds['topo']

regridder = xe.Regridder(ds, ds_out, 'bilinear')
dr_out = regridder(dr)

dr_out.to_netcdf('psdem2000_arrayLatLon.nc','w')

