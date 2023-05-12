chinook> ipython --matplotlib

 
pycnalEnv> ipython --matplotlib
Python 3.6.2 |Continuum Analytics, Inc.| (default, Jul 20 2017, 13:51:32) 
Type 'copyright', 'credits' or 'license' for more information
IPython 6.1.0 -- An enhanced Interactive Python. Type '?' for help.
Using matplotlib backend: Qt5Agg

In [1]: import pycnal

In [2]: import pycnal_toolbox

!!!In [3]: from mpl_toolkits.basemap import Basemap, shiftgrid

In [4]: from numpy import loadtxt

In [5]: import netCDF4

In [6]: grd = pycnal.grid.get_ROMS_grid('HC_150m')
Load geographical grid from file

In [7]: m = Basemap(projection='lcc',lat_1=47.5, lat_2=48.733333, lon_0=-123, lat_0=48.11667,width=5000000,height=5000000,resolution='h')

In [8]: coast = pycnal.utility.get_coast_from_map(m)

coast = loadtxt("../psdem_fromJM_ORIG/coastLonLat.csv",delimiter=",",unpack=False)

In [9]: pycnal.grid.edit_mask_mesh_ij(grd.hgrid, coast=coast)



#pycnal.grid.edit_mask_mesh(grd.hgrid, proj=m)
# this one was uncommented.  It's for writing the edited land mask to file
#pycnal.grid.write_ROMS_grid(grd, filename='temp.nc')
# This command is typed on the command line 
# ncks -v mask_rho,mask_u,mask_v,mask_psi grid_py.nc NI*.nc
# or simply copy temp.nc to PALAU_800m.nc
