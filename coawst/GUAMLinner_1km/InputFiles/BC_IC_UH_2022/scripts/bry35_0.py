import matplotlib
matplotlib.use('Agg')

import subprocess
import os
import sys
#import commands
import numpy as np

import pycnal
import pycnal_toolbox

src_varname = ['zeta','temp','salt','u','v','ubar','vbar']

wts_file = "ini_074_detided/remap_weights_UH_philsea_to_GUAMLinner_1km_bilinear_*"
src_grd = pycnal.grid.get_ROMS_grid('UH_philsea')
dst_grd = pycnal.grid.get_ROMS_grid('GUAMLinner_1km')

print('wts_file = ',wts_file)


data_dir = '/import/c1/VERTMIX/jgpender/coawst/GUAMLinner_1km/InputFiles/UH_downloads/UH_HIS_tided/'
print(data_dir)

lst_file = []

myArg = 'ls  ' + data_dir + 'phil*08135_0??.nc | tail -n +1'
print('myArg = ', myArg)

lst = subprocess.getoutput(myArg )
nfiles = subprocess.getoutput(myArg + "|wc -l")

print(nfiles.split()[0])


for ii in range(0,int(nfiles.split()[0]) ):
    src_filename = lst.split()[ii]
    print('current working file is   ' + src_filename)
    dst_var = pycnal_toolbox.remapping_bound(src_varname, src_filename,\
                                         wts_file,src_grd,dst_grd,rotate_uv=False)



#for src_filename in lst_file:
#    print('current working file is   ' + src_filename)
#    dst_var = pycnal_toolbox.remapping_bound(src_varname, src_filename,\
#                                         wts_file,src_grd,dst_grd,rotate_uv=False)



