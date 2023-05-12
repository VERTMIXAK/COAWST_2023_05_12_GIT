import numpy as np
from datetime import datetime
import netCDF4 as netCDF
import pdb

import pycnal
import pycnal_toolbox


##  create NWGOA remap file for scrip
#print 'Create remap grid file for NWGOA grid'
#dstgrd = pycnal.grid.get_ROMS_grid('NWGOA')
#dstgrd.hgrid.mask_rho = np.ones(dstgrd.hgrid.mask_rho.shape)
#pycnal.remapping.make_remap_grid_file(dstgrd, Cpos='rho')
#
#
### compute remap weights
print('compute remap weights using scrip')
# input namelist variables for conservative remapping at rho points
grid1_file = 'remap_grid_runoff.nc'
grid2_file = 'remap_grid_NWGOA_rivers.nc'
interp_file1 = 'remap_weights_runoff_to_NWGOA_conservative_nomask.nc'
interp_file2 = 'remap_weights_NWGOA_to_runoff_conservative_nomask.nc'
map1_name = 'runoff to NWGOA conservative Mapping'
map2_name = 'NWGOA to runoff conservative Mapping'
num_maps = 1
map_method = 'conservative'

#pdb.set_trace()
pycnal.remapping.compute_remap_weights(grid1_file, grid2_file, \
              interp_file1, interp_file2, map1_name, \
              map2_name, num_maps, map_method)
