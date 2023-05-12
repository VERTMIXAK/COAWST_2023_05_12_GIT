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

wts_file = "ini_wetDry/remap_weights_CAS6_to_HC_100mMEWetDry_bilinear_*"
src_grd = pycnal.grid.get_ROMS_grid('CAS6')
dst_grd = pycnal.grid.get_ROMS_grid('HC_100mMEWetDry')

print('wts_file = ',wts_file)


#data_dir = '../perigeeData/'
#print(data_dir)

lst_file = []

myArg = 'ls  ' + '../perigeeData/HIS2.nc'
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



