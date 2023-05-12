oldFile = 'UH_074_flat_ic_GUAMHinner_1km.nc';
sourceHIS = 'altHIS.nc';
sourceHIS2 = 'altHIS2.nc';
newFile = 'altStart.nc';

unix(['cp ',oldFile,' ',newFile]);

dum = nc_varget(sourceHIS,'u');
[nz,ny,nx] = size(dum);
dum2 = ones(1,nz,ny,nx);
dum2(1,:,:,:) = dum;
nc_varput(newFile,'u',dum2);

dum = nc_varget(sourceHIS,'v');
[nz,ny,nx] = size(dum);
dum2 = ones(1,nz,ny,nx);
dum2(1,:,:,:) = dum;
nc_varput(newFile,'v',dum2);


dum = nc_varget(sourceHIS,'temp');
[nz,ny,nx] = size(dum);
dum2 = ones(1,nz,ny,nx);
dum2(1,:,:,:) = dum;
nc_varput(newFile,'temp',dum2);

dum = nc_varget(sourceHIS,'salt');
[nz,ny,nx] = size(dum);
dum2 = ones(1,nz,ny,nx);
dum2(1,:,:,:) = dum;
nc_varput(newFile,'salt',dum2);

dum = nc_varget(sourceHIS2,'zeta');
[ny,nx] = size(dum);
dum2 = ones(1,ny,nx);
dum2(1,:,:) = dum;
nc_varput(newFile,'zeta',dum2);

dum = nc_varget(sourceHIS2,'ubar');
[ny,nx] = size(dum);
dum2 = ones(1,ny,nx);
dum2(1,:,:) = dum;
nc_varput(newFile,'ubar',dum2);

dum = nc_varget(sourceHIS2,'vbar');
[ny,nx] = size(dum);
dum2 = ones(1,ny,nx);
dum2(1,:,:) = dum;
nc_varput(newFile,'vbar',dum2);

