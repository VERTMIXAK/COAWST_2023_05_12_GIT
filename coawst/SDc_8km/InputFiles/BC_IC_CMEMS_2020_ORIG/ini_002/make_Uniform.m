origFile  = 'CMEMS_2020_002_ic_SD_8km_flat.nc';
newFile  = 'CMEMS_2020_002_ic_SD_8km_flat_uniform.nc';
gridFile = '../../Gridpak/SD_8km_flat.nc';

unix(['cp ',origFile,' ',newFile]);

grd = roms_get_grid(gridFile,origFile,0,1);

% roms_get_grid isn't working for some reason
z = [         -1771.38557054073,
         -1688.21976215237,
         -1597.84948218199,
         -1502.35776092036,
         -1403.89776532457,
          -1304.5281264427,
         -1206.09357025597,
         -1110.15222781434,
         -1017.94406547156,
         -930.391424398649,
           -848.1218687824,
         -771.504430705369,
         -700.692055133384,
         -635.664982455657,
         -576.271593053728,
         -522.264703931398,
         -473.332404987773,
         -429.123278690587,
         -389.266321752198,
         -353.386149307944,
         -321.114174125393,
          -292.09646740861,
         -265.998963195645,
         -242.510593201156,
         -221.344851963067,
         -202.240205003072,
         -184.959672063108,
         -169.289846582951,
         -155.039552506581,
         -142.038290012706,
         -130.134581919899,
         -119.194301066325,
         -109.099034579884,
         -99.7445223703255,
         -91.0391932551792,
         -82.9028118995803,
          -75.265242390716,
         -68.0653291148159,
          -61.249892124746,
         -54.7728319581208,
         -48.5943375614092,
         -42.6801903425594,
         -37.0011572215598,
         -31.5324657312863,
         -26.2533546335013,
         -21.1466940793559,
         -16.1986700047136,
         -11.3985281693206,
         -6.73837399918095,
          -2.2130251566774];



temp = nc_varget(newFile,'temp');
salt = nc_varget(newFile,'salt');
u    = nc_varget(newFile,'u');
v    = nc_varget(newFile,'v');
ubar = nc_varget(newFile,'ubar');
vbar = nc_varget(newFile,'vbar');
zeta = nc_varget(newFile,'zeta');

dum=nc_varget(newFile,'temp');
size(dum)

aaa=5;


[nz,ny,nx] = size(temp);
for ii=1:nx; for jj=1:ny; for kk=1:nz
    temp(kk,jj,ii) = 13/4000*z(kk) + 15;     
end;end;end
dum = zeros(1,nz,ny,nx);
dum(1,:,:,:) = temp;
nc_varput(newFile,'temp',dum);


[nz,ny,nx] = size(salt);
salt = 0*salt + 33;
dum = zeros(1,nz,ny,nx);
dum(1,:,:,:) = salt;
nc_varput(newFile,'salt',dum);


[nz,ny,nx] = size(u);
u = 0*u ;
dum = zeros(1,nz,ny,nx);
dum(1,:,:,:) = u;
nc_varput(newFile,'u',dum);


[nz,ny,nx] = size(v);
v = 0*v;
dum = zeros(1,nz,ny,nx);
dum(1,:,:,:) = v;
nc_varput(newFile,'v',dum);


[ny,nx] = size(ubar);
ubar = 0*ubar ;
dum = zeros(1,ny,nx);
dum(1,:,:) = ubar;
nc_varput(newFile,'ubar',dum);

[ny,nx] = size(vbar);
vbar = 0*vbar ;
dum = zeros(1,ny,nx);
dum(1,:,:) = vbar;
nc_varput(newFile,'vbar',dum);

[ny,nx] = size(zeta);
zeta = 0*zeta ;
dum = zeros(1,ny,nx);
dum(1,:,:) = zeta;
nc_varput(newFile,'zeta',dum);



