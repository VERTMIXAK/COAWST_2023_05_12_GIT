origFile = 'CMEMS_2020_002_ic_SD_8km.nc';
newFile  = 'CMEMS_2020_002_ic_SD_8km_uniform.nc';
gridFile = '../../Gridpak/SD_8km.nc';
HISFile  = '../HISfile.nc';

unix(['cp ',origFile,' ',newFile]);

grd = roms_get_grid(gridFile,HISFile,0,1);

temp = nc_varget(newFile,'temp');
salt = nc_varget(newFile,'salt');
u    = nc_varget(newFile,'u');
v    = nc_varget(newFile,'v');
ubar = nc_varget(newFile,'ubar');
vbar = nc_varget(newFile,'vbar');
zeta = nc_varget(newFile,'zeta');


aaa=5;


[nz,ny,nx] = size(temp);
for ii=1:nx; for jj=1:ny; for kk=1:nz
    temp(kk,jj,ii) = 13/4000*grd.z_r(kk,jj,ii) + 15;     
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



