import subprocess
import os
#import commands
import numpy as np
import matplotlib
matplotlib.use('Agg')

import pycnal
import pycnal_toolbox

from remap import remap
from remap_uv import remap_uv

# JGP !!!  This file is where you choose the start day for the IC. 
file = '/import/c1/VERTMIX/jgpender/ROMS/CMEMS/SO_2017/data_PHY/CMEMS_PHY_2017_347.nc'
dst_dir='./'

print('Build IC file from the following file:')
print(file)
print(' ')

# JGP this is the grid file 1 directory up from the HYCOM files

src_grd_file = '/import/c1/VERTMIX/jgpender/ROMS/CMEMS/SO_2017/CMEMS_SO_grid.nc'
print('src_grd_file is ', src_grd_file)


src_grd = pycnal_toolbox.Grid_HYCOM.get_nc_Grid_HYCOM(src_grd_file)


# JGP this points to my expt grid (generated using gridpak)
dst_grd = pycnal.grid.get_ROMS_grid('SO_1km')

# remap
print('about to do zeta')
zeta = remap(file, 'ssh', src_grd, dst_grd, dst_dir=dst_dir)
dst_grd = pycnal.grid.get_ROMS_grid('SO_1km', zeta=zeta)


remap(file, 'temp', src_grd, dst_grd, dst_dir=dst_dir)
remap(file, 'salt', src_grd, dst_grd, dst_dir=dst_dir)
remap_uv(file, src_grd, dst_grd, dst_dir=dst_dir)

# merge file
ic_file = dst_dir + file.rsplit('/')[-1][:-3] + '_ic_' + dst_grd.name + '.nc'

out_file = dst_dir + file.rsplit('/')[-1][:-3] + '_ssh_ic_' + dst_grd.name + '.nc'
command = ('ncks', '-a', '-O', out_file, ic_file) 
print(command)
subprocess.check_call(command)
os.remove(out_file)
out_file = dst_dir + file.rsplit('/')[-1][:-3] + '_temp_ic_' + dst_grd.name + '.nc'
command = ('ncks', '-a', '-A', out_file, ic_file) 
print(command)
subprocess.check_call(command)
os.remove(out_file)
out_file = dst_dir + file.rsplit('/')[-1][:-3] + '_salt_ic_' + dst_grd.name + '.nc'
command = ('ncks', '-a', '-A', out_file, ic_file) 
print(command)
subprocess.check_call(command)
os.remove(out_file)
out_file = dst_dir + file.rsplit('/')[-1][:-3] + '_u_ic_' + dst_grd.name + '.nc'
command = ('ncks', '-a', '-A', out_file, ic_file) 
print(command)
subprocess.check_call(command)
os.remove(out_file)
out_file = dst_dir + file.rsplit('/')[-1][:-3] + '_v_ic_' + dst_grd.name + '.nc'
command = ('ncks', '-a', '-A', out_file, ic_file) 
print(command)
subprocess.check_call(command)
os.remove(out_file)
