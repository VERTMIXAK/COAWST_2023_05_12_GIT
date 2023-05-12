file = 'NG_runoff_2020.nc';

lon = nc_varget(file,'lon');
lat = nc_varget(file,'lat');
flow = nc_varget(file,'friver');




% fig(1);clf
% temp = sq(flow(1,700:950,200:500));
% pcolor(temp);shading flat;colorbar


fig(2);clf
temp = sq(flow(1,790:810,440:460));
pcolor(temp);shading flat;colorbar




%% ... assuming you've got the final forcing file

jraFile  = 'JRA-1.4_NG_rivers_2020.nc';

myI = nc_varget(jraFile,'river_Xposition');
myJ = nc_varget(jraFile,'river_Eposition');


flow(isnan(flow)) = 0;

myN = length(myI);

iRange=[1:nx];
jRange=[1:ny];
iRange=[1:nx];
jRange=[1:ny];

fig(2);clf
temp = sq(flow(1,790:810,440:460));
pcolor(flow);shading flat;colorbar
hold on;
plot(myI,myJ)








