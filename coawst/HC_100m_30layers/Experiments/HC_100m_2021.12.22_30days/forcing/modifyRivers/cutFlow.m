legitFile = 'rivers.nc_LEGIT';
newFile   = 'rivers.nc';

unix(['cp ',legitFile,' ',newFile]);
riv = nc_varget(newFile,'river_transport');

fig(1);clf;
plot(riv)

riv(:,4) = 0 * riv(:,4);

fig(2);clf;
plot(riv)

nc_varput(newFile,'river_transport',riv);