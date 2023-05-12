import pycnal

srcgrd = pycnal.grid.get_ROMS_grid('CAS6')
dstgrd = pycnal.grid.get_ROMS_grid('HC_100mMEWetDry')

pycnal.remapping.make_remap_grid_file(srcgrd)
pycnal.remapping.make_remap_grid_file(srcgrd,Cpos='u')
pycnal.remapping.make_remap_grid_file(srcgrd,Cpos='v')

pycnal.remapping.make_remap_grid_file(dstgrd)
pycnal.remapping.make_remap_grid_file(dstgrd,Cpos='u')
pycnal.remapping.make_remap_grid_file(dstgrd,Cpos='v')


type = ['rho','u','v']

for typ in type:
        grid1_file = 'remap_grid_CAS6_'+str(typ)+'.nc'
        grid2_file = 'remap_grid_HC_100mMEWetDry_'+str(typ)+'.nc'
        interp_file1 = 'remap_weights_CAS6_to_HC_100mMEWetDry_bilinear_'+str(typ)+'_to_'+str(typ)+'.nc'
        interp_file2 = 'remap_weights_HC_100mMEWetDry_to_CAS6_bilinear_'+str(typ)+'_to_'+str(typ)+'.nc'
        map1_name = 'CAS6 to HC_100mMEWetDry Bilinear Mapping'
        map2_name = 'HC_100mMEWetDry to CAS6 Bilinear Mapping'
        num_maps = 1
        map_method = 'bilinear'
            
        print("Making "+str(interp_file1)+"...")
            
        pycnal.remapping.compute_remap_weights(grid1_file,grid2_file,\
                         interp_file1,interp_file2,map1_name,\
                         map2_name,num_maps,map_method)
