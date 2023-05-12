origFile  = 'CMEMS_2020_002_ic_SDa_8km_flat.nc';
newFile  = 'CMEMS_2020_002_ic_SDa_8km_flat_uniform.nc';
gridFile = '../../../../SDa_8km/InputFiles/Gridpak/SDa_8km.nc';
HISfile = '../HISfile.nc';

unix(['cp ',origFile,' ',newFile]);

grd = roms_get_grid(gridFile,HISfile,0,1);

abs(grd.h - 1945);
indices = find(abs(grd.h - 1945) == min(ans(:)));
[myJ,myI] = ind2sub(size(grd.h),indices);


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


[nz,ny,nx] = size(salt);
for ii=1:nx; for jj=1:ny; for kk=1:nz
    salt(kk,jj,ii) = -1/2000*grd.z_r(kk,myJ(1),myI(1)) + 33;     
end;end;end
dum = zeros(1,nz,ny,nx);
dum(1,:,:,:) = salt;
nc_varput(newFile,'salt',dum);


[nz,ny,nx] = size(temp);
temp = 0*temp + 15;
dum = zeros(1,nz,ny,nx);
dum(1,:,:,:) = temp;
nc_varput(newFile,'temp',dum);


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



