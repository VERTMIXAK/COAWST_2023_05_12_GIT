import pycnal

#irange=(200,600)
#jrange=(250,720)
irange=None
jrange=None

srcgrd = pycnal.grid.get_ROMS_grid('DOPPIO')
dstgrd = pycnal.grid.get_ROMS_grid('NG_100m')

pycnal.remapping.make_remap_grid_file(srcgrd,irange=irange,jrange=jrange)
pycnal.remapping.make_remap_grid_file(srcgrd,Cpos='u',irange=irange,jrange=jrange)
pycnal.remapping.make_remap_grid_file(srcgrd,Cpos='v',irange=irange,jrange=jrange)

pycnal.remapping.make_remap_grid_file(dstgrd)
pycnal.remapping.make_remap_grid_file(dstgrd,Cpos='u')
pycnal.remapping.make_remap_grid_file(dstgrd,Cpos='v')

type = ['rho','u','v']

for typ in type:
    for tip in type:
        grid1_file = 'remap_grid_DOPPIO_'+str(typ)+'.nc'
        grid2_file = 'remap_grid_NG_100m_'+str(tip)+'.nc'
        interp_file1 = 'remap_weights_DOPPIO_to_NG_100m_bilinear_'+str(typ)+'_to_'+str(tip)+'.nc'
        interp_file2 = 'remap_weights_NG_100m_to_DOPPIO_bilinear_'+str(tip)+'_to_'+str(typ)+'.nc'
        map1_name = 'DOPPIO to NG_100m Bilinear Mapping'
        map2_name = 'NG_100m to DOPPIO Bilinear Mapping'
        num_maps = 1
        map_method = 'bilinear'

        print("Making "+str(interp_file1)+"...")

        pycnal.remapping.compute_remap_weights(grid1_file,grid2_file,\
                         interp_file1,interp_file2,map1_name,\
                         map2_name,num_maps,map_method)
