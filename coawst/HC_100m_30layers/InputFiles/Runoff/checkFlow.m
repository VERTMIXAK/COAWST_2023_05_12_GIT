HCgridFile = '../Gridpak/HC_150m.nc';
HCHISFile  = '../BC_IC_HC_2020/ini_123/LO_2020_123_ic_HC_150m.nc';

LOgridFile = '../cas6_v3_lo8b_Source/fullLOgrid/grid_ORIG.nc';
LOHISFile = '../cas6_v3_lo8b_Source/fullLOgrid/ocean_his_0001.nc';

river30 = 'rivers30.nc';
river50 = 'rivers50.nc';



gridLO = roms_get_grid(LOgridFile,LOHISFile,0,1);
gridHC = roms_get_grid(HCgridFile,HCHISFile,0,1);

xLO = nc_varget(river30,'river_Xposition');
yLO = nc_varget(river30,'river_Eposition');



transport30 = nc_varget(river30,'river_transport');
transport50 = nc_varget(river50,'river_transport');

v30 = nc_varget(river30,'river_Vshape');
v50 = nc_varget(river50,'river_Vshape');

transport30

%%

transport30(1,1)









