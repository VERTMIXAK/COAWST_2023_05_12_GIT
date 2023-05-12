unix('\rm *.nc');

sourceDir = '../../../lake_jersey_download_2022_09_30/Data/';

file = 'lake_jersey_ini_a.nc';
unix(['cp ',sourceDir,file,' .']);

dum = nc_varget(file,'zeta');
[ny,nx] = size(dum);
dum = zeros(1,ny,nx);
nc_varput(file,'zeta',dum);

dum = nc_varget(file,'ubar');
[ny,nx] = size(dum);
dum = zeros(1,ny,nx);
nc_varput(file,'ubar',dum);

dum = nc_varget(file,'vbar');
[ny,nx] = size(dum);
dum = zeros(1,ny,nx);
nc_varput(file,'vbar',dum);

dum = nc_varget(file,'u');
[nz,ny,nx] = size(dum);
dum = zeros(1,nz,ny,nx);
nc_varput(file,'u',dum);

dum = nc_varget(file,'v');
[nz,ny,nx] = size(dum);
dum = zeros(1,nz,ny,nx);
nc_varput(file,'v',dum);

dum = nc_varget(file,'temp');
[nz,ny,nx] = size(dum);
dum2 = zeros(1,nz,ny,nx);
for kk=1:nz
    dum2(1,kk,:,:) = dum(kk,3,3);
end;
nc_varput(file,'temp',dum2);

dum = nc_varget(file,'salt');
[nz,ny,nx] = size(dum);
dum2 = zeros(1,nz,ny,nx);
for kk=1:nz
    dum2(1,kk,:,:) = dum(kk,3,3);
end;
nc_varput(file,'salt',dum2);
