import pycnal

srcgrd = pycnal.grid.get_ROMS_grid('PALAU_BrianFull')
dstgrd = pycnal.grid.get_ROMS_grid('PALAU_800m')

pycnal.remapping.make_remap_grid_file(srcgrd)
pycnal.remapping.make_remap_grid_file(srcgrd,Cpos='u')
pycnal.remapping.make_remap_grid_file(srcgrd,Cpos='v')

pycnal.remapping.make_remap_grid_file(dstgrd)
pycnal.remapping.make_remap_grid_file(dstgrd,Cpos='u')
pycnal.remapping.make_remap_grid_file(dstgrd,Cpos='v')


type = ['rho','u','v']

for typ in type:
        grid1_file = 'remap_grid_PALAU_BrianFull_'+str(typ)+'.nc'
        grid2_file = 'remap_grid_PALAU_800m_'+str(typ)+'.nc'
        interp_file1 = 'remap_weights_PALAU_BrianFull_to_PALAU_800m_bilinear_'+str(typ)+'_to_'+str(typ)+'.nc'
        interp_file2 = 'remap_weights_PALAU_800m_to_PALAU_BrianFull_bilinear_'+str(typ)+'_to_'+str(typ)+'.nc'
        map1_name = 'PALAU_BrianFull to PALAU_800m Bilinear Mapping'
        map2_name = 'PALAU_800m to PALAU_BrianFull Bilinear Mapping'
        num_maps = 1
        map_method = 'bilinear'
            
        print("Making "+str(interp_file1)+"...")
            
        pycnal.remapping.compute_remap_weights(grid1_file,grid2_file,\
                         interp_file1,interp_file2,map1_name,\
                         map2_name,num_maps,map_method)
