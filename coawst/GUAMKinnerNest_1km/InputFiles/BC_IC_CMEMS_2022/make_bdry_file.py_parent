import matplotlib
matplotlib.use('Agg')

import subprocess
import os
import sys
#import commands
import numpy as np
#import pdb; pdb.set_trace()

#increase the maximum number of open files allowed
#import resource
#resource.setrlimit(resource.RLIMIT_NOFILE, (3000,-1))

import pycnal
import pycnal_toolbox

from remap_bdry import remap_bdry
from remap_bdry_uv import remap_bdry_uv

# jgp quit screwing around with year
#lst_year = sys.argv[1:]
#print('lst_year = ',lst_year)

data_dir = '/import/c1/VERTMIX/jgpender/ROMS/CMEMS/GUAM_2022/data_PHY/'

dst_dir='./'

myArg = 'ls ' + data_dir + 'G*'
#print('myArg = ',myArg)
lst = subprocess.getoutput(myArg )
nfiles = subprocess.getoutput(myArg + "|wc -l")

lst_file = lst.splitlines()

#JGP - do a subset of the list of files, if desired
lst_file = lst_file[60:135]

print('nfiles.split = ',nfiles.split()[0])
print('lst = \n', lst)
print('nfiles = ',nfiles)
#exit()

print('Build OBC file from the following file list:')
print(lst_file)
print(' ')

src_grd_file = data_dir + '../GUAM_grid.nc'
print('src_grd_file is ' + src_grd_file)

src_grd = pycnal_toolbox.Grid_HYCOM.get_nc_Grid_HYCOM(src_grd_file)
print('finished with src_grd')

dst_grd = pycnal.grid.get_ROMS_grid('GUAMKinner_1km')
print('finished with dst_grd')

for file in lst_file:

    print('current working file is   ' + file)


    #print('bada-boom')
    zeta = remap_bdry(file, 'ssh', src_grd, dst_grd, dst_dir=dst_dir)
    #print('step 1 - just did the ssh run')
 
    dst_grd = pycnal.grid.get_ROMS_grid('GUAMKinner_1km', zeta=zeta)
    #print('step 2 - about to start the temp run')

    remap_bdry(file, 'temp', src_grd, dst_grd, dst_dir=dst_dir)
    remap_bdry(file, 'salt', src_grd, dst_grd, dst_dir=dst_dir)
    remap_bdry_uv(file, src_grd, dst_grd, dst_dir=dst_dir)

    # merge file
    bdry_file = dst_dir + file.rsplit('/')[-1][:-3] + '_bdry_' + dst_grd.name + '.nc'

    out_file = dst_dir + file.rsplit('/')[-1][:-3] + '_ssh_bdry_' + dst_grd.name + '.nc'
    command = ('ncks', '-a', '-O', out_file, bdry_file) 
    subprocess.check_call(command)
    os.remove(out_file)
    out_file = dst_dir + file.rsplit('/')[-1][:-3] + '_temp_bdry_' + dst_grd.name + '.nc'
    command = ('ncks', '-a', '-A', out_file, bdry_file) 
    subprocess.check_call(command)
    os.remove(out_file)
    out_file = dst_dir + file.rsplit('/')[-1][:-3] + '_salt_bdry_' + dst_grd.name + '.nc'
    command = ('ncks', '-a', '-A', out_file, bdry_file) 
    subprocess.check_call(command)
    os.remove(out_file)
    out_file = dst_dir + file.rsplit('/')[-1][:-3] + '_u_bdry_' + dst_grd.name + '.nc'
    command = ('ncks', '-a', '-A', out_file, bdry_file) 
    subprocess.check_call(command)
    os.remove(out_file)
    out_file = dst_dir + file.rsplit('/')[-1][:-3] + '_v_bdry_' + dst_grd.name + '.nc'
    command = ('ncks', '-a', '-A', out_file, bdry_file) 
    subprocess.check_call(command)
    os.remove(out_file)



#ncrcat  HYCOM*  HYCOM_Bdry_TS_2018.nc
