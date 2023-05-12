icFile = 'ini_074_flat/UH_074_flat_ic_GUAMFinner_1km.nc';
bcFile = 'Flat_bdry_GUAMFinner_1km.nc';

icTemp = nc_varget(icFile,'temp');
icSalt = nc_varget(icFile,'salt');

HISfile = '../../Experiments/GUAMFinner_1km_2022_074_deadStill/netcdfOutput_ORIG/guam_his_00001.nc';
gridFile = '../Gridpak/GUAMFinner_1km.nc';

grd = roms_get_grid(gridFile,HISfile,0,1);


myI=275;myJ=50;
fig(1);clf;
plot(sq(grd.z_r(:,myJ,myI)),sq(icSalt(:,myJ,myI)));title('Salt')

myI=275;myJ=50;
fig(2);clf;
plot(sq(grd.z_r(:,myJ,myI)),sq(icTemp(:,myJ,myI)));title('Temp')




bcTemp = nc_varget(bcFile,'temp_north');
bcSalt = nc_varget(bcFile,'salt_north');

dum = sq(bcTemp(1,:,:)) - sq(icTemp(:,end,:));
max(dum(:))
min(dum(:))

dum = sq(bcSalt(1,:,:)) - sq(icSalt(:,end,:));
max(dum(:))
min(dum(:))



bcTemp = nc_varget(bcFile,'temp_south');
bcSalt = nc_varget(bcFile,'salt_south');

dum = sq(bcTemp(1,:,:)) - sq(icTemp(:,1,:));
max(dum(:))
min(dum(:))

dum = sq(bcSalt(1,:,:)) - sq(icSalt(:,1,:));
max(dum(:))
min(dum(:))

%%

fig(3);clf
pcolor(grd.h);shading flat

% iBay=237;jBay=313;
iBay=275;jBay=50;
iBay=286;jBay=40;

mySalt = sq(icSalt(:,jBay,iBay));
myTemp = sq(icTemp(:,jBay,iBay));
myZ    = sq(grd.z_r(:,jBay,iBay));
grd.h(jBay,iBay)

fig(10);clf;
plot(myZ,mySalt);title('salt')

fig(11);clf;
plot(myZ,myTemp);title('temp')

pden = sw_pden(mySalt,myTemp,myZ,0);
fig(12);clf;
plot(myZ,pden);title('density')


fig(20);clf;
plot(myZ(end-10:end),mySalt(end-10:end));title('salt')

fig(21);clf;
plot(myZ(end-10:end),myTemp(end-10:end));title('temp')

pden = sw_pden(mySalt,myTemp,myZ,0);
fig(22);clf;
plot(myZ(end-10:end),pden(end-10:end));title('density')




