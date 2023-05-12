import pycnal
import pycnal_toolbox

src_varname = ['zeta','temp','salt','u','v','ubar','vbar']

# Change src_filename to your directory for the file's containing variable data
src_filename = '/import/c1/VERTMIX/jgpender/coawst/GUAMLinner_1km/InputFiles/UH_downloads/UH_HIS_detided/philsea4_his_08107_048.nc'
wts_file = "./remap_weights_UH_philsea_to_GUAMLinner_1km_bilinear_*"
src_grd = pycnal.grid.get_ROMS_grid('UH_philsea')
dst_grd = pycnal.grid.get_ROMS_grid('GUAMLinner_1km')
# Outfile is a parameter to allow you to place these created remap files in a different
# directory than the one that is default which is where the file came from.

print(' ')
print('in ini script')
print(' ')

dst_var = pycnal_toolbox.remapping(src_varname, src_filename,\
                                   wts_file,src_grd,dst_grd,rotate_uv=False)

print('done with ini')


