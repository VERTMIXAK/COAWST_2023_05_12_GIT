file = 'rivers.nc';

rivDir = nc_varget(file,'river_direction');
rivTr  = nc_varget(file,'river_transport');

