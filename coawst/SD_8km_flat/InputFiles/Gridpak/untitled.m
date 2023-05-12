file = 'SD_8km.nc';

h = nc_varget(file,'h');
h(h>20)=1800;
pcolor(h)
