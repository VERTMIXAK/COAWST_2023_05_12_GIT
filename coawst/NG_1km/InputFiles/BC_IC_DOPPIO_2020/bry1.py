import pycnal
import matplotlib
matplotlib.use('Agg')
import subprocess
import pdb
from multiprocessing import Pool

import pycnal
import pycnal_toolbox

src_varname = ['zeta','temp','salt','u_eastward','v_northward']

#irange=(200,600)
#jrange=(250,720)
irange = None
jrange = None

#months = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12']
#months = ['01', '02', '03', '04', '05', '06', '07', '08']
#months = ['08', '09', '10']

# Change src_filename to your directory for the file's containing variable data
#part_filename = '../DOPPIO/DOPPIO'



data_dir = '../DOPPIO/'

dst_dir='./'

myArg = 'ls ' + data_dir + 'run*'
print('myArg = ',myArg)
lst = subprocess.getoutput(myArg )
nfiles = subprocess.getoutput(myArg + "|wc -l")

lst_file = lst.splitlines()
#JGP - do a subset of the list of files, if desired
lst_file = lst_file[0:400]

print('nfiles.split = ',nfiles.split()[0])
print('lst = \n', lst)
print('nfiles = ',nfiles)




wts_file = "./ini_183/remap_weights_DOPPIO_to_NG_1km_bilinear_*"
src_grd = pycnal.grid.get_ROMS_grid('DOPPIO')
dst_grd = pycnal.grid.get_ROMS_grid('NG_1km')
# Outfile is a parameter to allow you to place these created remap files in a different
# directory than the one that is default which is where the file came from.

for file in lst_file:

    print('current working file is   ' + file)

#    src_filename = part_filename + month + '*.nc'

    lcopy = list(src_varname)

#    print('working on file '+src_filename)
# didn't work even with processes=1
#    pdb.set_trace()
    dst_var = pycnal_toolbox.remapping_bound(lcopy, file, \
                     wts_file, src_grd, dst_grd, rotate_uv=True, \
                     irange=irange, jrange=jrange, \
                     uvar='u_eastward', vvar='v_northward', rotate_part=True)

#processes = 4
#p = Pool(processes)
#results = p.map(do_file, months)
