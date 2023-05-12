file = 'GUAMDinner_1km.nc';

x = nc_varget(file,'x_rho');
y = nc_varget(file,'y_rho');

vecX = sq(x(125,:));
vecY = sq(y(125,:));

plot(vecX(2:end),diff(vecX))
plot(vecX(3:end),diff(diff(vecX)))


plot(diff(diff(vecX)))

