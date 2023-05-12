close all;
clear;

file = 'GUAMLinner_1km.nc';

x = nc_varget(file,'x_rho');
y = nc_varget(file,'y_rho');

vecX = sq(x(125,:));
vecY = sq(y(:,125));

fig(1);
plot(vecX(2:end),diff(vecX))

fig(2);
plot(vecX(3:end),diff(diff(vecX)))

fig(3);
plot(diff(vecX))

fig(4);
plot(vecX)


fig(10);
plot(vecY)
fig(11);
plot(diff(vecY))

