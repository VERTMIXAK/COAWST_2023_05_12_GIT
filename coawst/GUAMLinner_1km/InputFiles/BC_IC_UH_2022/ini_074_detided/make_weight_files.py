import pycnal


srcgrd = pycnal.grid.get_ROMS_grid('UH_philsea')
dstgrd = pycnal.grid.get_ROMS_grid('GUAMLinner_1km')

pycnal.remapping.make_remap_grid_file(srcgrd)
pycnal.remapping.make_remap_grid_file(srcgrd,Cpos='u')
pycnal.remapping.make_remap_grid_file(srcgrd,Cpos='v')

pycnal.remapping.make_remap_grid_file(dstgrd)
pycnal.remapping.make_remap_grid_file(dstgrd,Cpos='u')
pycnal.remapping.make_remap_grid_file(dstgrd,Cpos='v')

type = ['rho','u','v']

for typ in type:
    for tip in type:
        grid1_file = 'remap_grid_UH_philsea_'+str(typ)+'.nc'
        grid2_file = 'remap_grid_GUAMLinner_1km_'+str(tip)+'.nc'
        interp_file1 = 'remap_weights_UH_philsea_to_GUAMLinner_1km_bilinear_'+str(typ)+'_to_'+str(tip)+'.nc'
        interp_file2 = 'remap_weights_GUAMLinner_1km_to_UH_philsea_bilinear_'+str(tip)+'_to_'+str(typ)+'.nc'
        map1_name = 'UH_philsea to GUAMLinner_1km Bilinear Mapping'
        map2_name = 'GUAMLinner_1km to UH_philsea Bilinear Mapping'
        num_maps = 1
        map_method = 'bilinear'

        print("Making "+str(interp_file1)+"...")

        pycnal.remapping.compute_remap_weights(grid1_file,grid2_file,\
                         interp_file1,interp_file2,map1_name,\
                         map2_name,num_maps,map_method)
