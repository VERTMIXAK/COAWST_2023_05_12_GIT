file = 'PRAIRIEinner_1km.nc';

x = nc_varget(file,'x_psi');
y = nc_varget(file,'y_psi');

lon = nc_varget(file,'lon_psi');
lat = nc_varget(file,'lat_psi');




%%  east-west

myY = 150;

fig(1);clf;
plot( ( x(myY,1:end-1) + x(myY,2:end) )/2 , diff(sq(x(myY,:))))
fig(2);clf;
plot(( x(myY,1:end-2) + x(myY,3:end) )/2, diff(diff(sq(x(myY,:)))))

fig(3);clf;
plot(( lon(myY,1:end-1) + lon(myY,2:end) )/2 ,diff(sq(lon(myY,:))))
fig(4);clf;
plot(( lon(myY,1:end-2) + lon(myY,3:end) )/2 ,diff(diff(sq(lon(myY,:)))))




%% north-south

myX = 150;

fig(1);clf;
plot( ( y(1:end-1,myX) + y(2:end,myX) )/2 , diff(sq(y(:,myX))))
fig(2);clf;
plot(( y(1:end-2,myX) + y(3:end,myX) )/2, diff(diff(sq(y(:,myX)))))

fig(3);clf;
plot(( lat(1:end-1,myX) + lat(2:end,myX) )/2 ,diff(sq(lat(:,myX))))
fig(4);clf;
plot(( lat(1:end-2,myX) + lat(3:end,myX) )/2 ,diff(diff(sq(lat(:,myX)))))