UHFile = 'UH-03-15.nc';

UHTemp = nc_varget(UHFile,'temp');
UHSalt = nc_varget(UHFile,'salt');
Z      = nc_varget(UHFile,'z');
lon    = nc_varget(UHFile,'lon1d');
lat    = nc_varget(UHFile,'lat1d');

fig(1);clf;
pcolor(sq(UHSalt(end,:,:)));shading flat


%%

myI=43;myJ=23;
lon(myI)
lat(myJ)

mySalt = sq(UHSalt(:,myJ,myI));
myTemp = sq(UHTemp(:,myJ,myI));
myDen  = sw_pden(mySalt,myTemp,Z,0);


fig(2);clf;
plot(Z,mySalt);title('Salt')

fig(3);clf;
plot(Z,myTemp);title('Temp')

fig(4);clf;
plot(Z,myDen);title('density')

fig(5);clf;
plot(Z(1:10),myDen(1:10));title('density')

fig(6);clf;
plot(diff(myDen(1:10)));title('diff density')


diff(myDen);min(ans(:))


%%


myI=43;myJ=23;
myI=60;myJ=70;

mySalt = sq(UHSalt(:,myJ,myI));
myTemp = sq(UHTemp(:,myJ,myI));
myDen  = sw_pden(mySalt,myTemp,Z,0);


fig(2);clf;
plot(Z,mySalt);title('Salt')

fig(3);clf;
plot(Z,myTemp);title('Temp')

fig(4);clf;
plot(Z,myDen);title('density')

fig(5);clf;
plot(Z(1:10),myDen(1:10));title('density')

fig(6);clf;
plot(diff(myDen(1:10)));title('diff density')
