import pycnal
import pycnal_toolbox

src_varname = ['u_eastward','v_northward','zeta','temp','salt']
irange = None
jrange = None

# Need to pick up ubar/vbar and uice/vice later

# Change src_filename to your directory for the file's containing variable data
src_filename = './sourceData.nc'
#src_filename = '../../DOPPIO/runs_History_RUN_2020-07-01T00:00:00Z.nc'
wts_file = "./remap_weights_DOPPIO_to_NG_1km_bilinear_*"
src_grd = pycnal.grid.get_ROMS_grid('DOPPIO')
dst_grd = pycnal.grid.get_ROMS_grid('NG_1km')
# Outfile is a parameter to allow you to place these created remap files in a different
# directory than the one that is default which is where the file came from.
dst_var = pycnal_toolbox.remapping(src_varname, src_filename, wts_file, \
                src_grd, dst_grd, rotate_uv=True, irange=irange, jrange=jrange, \
                uvar='u_eastward', vvar='v_northward', rotate_part=True)
