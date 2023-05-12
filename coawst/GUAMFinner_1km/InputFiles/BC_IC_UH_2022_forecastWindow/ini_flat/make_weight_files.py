import pycnal

srcgrd = pycnal.grid.get_ROMS_grid('GUAM_Brian')
dstgrd = pycnal.grid.get_ROMS_grid('GUAMFinner_1km')

pycnal.remapping.make_remap_grid_file(srcgrd)
pycnal.remapping.make_remap_grid_file(srcgrd,Cpos='u')
pycnal.remapping.make_remap_grid_file(srcgrd,Cpos='v')

pycnal.remapping.make_remap_grid_file(dstgrd)
pycnal.remapping.make_remap_grid_file(dstgrd,Cpos='u')
pycnal.remapping.make_remap_grid_file(dstgrd,Cpos='v')


type = ['rho','u','v']

for typ in type:
        grid1_file = 'remap_grid_GUAM_Brian_'+str(typ)+'.nc'
        grid2_file = 'remap_grid_GUAMFinner_1km_'+str(typ)+'.nc'
        interp_file1 = 'remap_weights_GUAM_Brian_to_GUAMFinner_1km_bilinear_'+str(typ)+'_to_'+str(typ)+'.nc'
        interp_file2 = 'remap_weights_GUAMFinner_1km_to_GUAM_Brian_bilinear_'+str(typ)+'_to_'+str(typ)+'.nc'
        map1_name = 'GUAM_Brian to GUAMFinner_1km Bilinear Mapping'
        map2_name = 'GUAMFinner_1km to GUAM_Brian Bilinear Mapping'
        num_maps = 1
        map_method = 'bilinear'
            
        print("Making "+str(interp_file1)+"...")
            
        pycnal.remapping.compute_remap_weights(grid1_file,grid2_file,\
                         interp_file1,interp_file2,map1_name,\
                         map2_name,num_maps,map_method)
