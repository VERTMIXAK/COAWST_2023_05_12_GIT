sourceFile = 'lake_jersey_ini_a.nc';

oldParentFile = 'CMEMSsource_244_ic_LJ_500m_parent.nc';
newParentFile = 'LJ_ic_parent.nc';

unix(['cp ',oldParentFile,' ',newParentFile]);

dum = nc_varget(newParentFile,'zeta');
[ny,nx] = size(dum)
dum2 = zeros(1,ny,nx);
dum2(1,:,:) = dum;
nc_varput(newParentFile,'zeta',0*dum2);

dum = nc_varget(newParentFile,'ubar');
[ny,nx] = size(dum)
dum2 = zeros(1,ny,nx);
dum2(1,:,:) = dum;
nc_varput(newParentFile,'ubar',0*dum2);

dum = nc_varget(newParentFile,'vbar');
[ny,nx] = size(dum)
dum2 = zeros(1,ny,nx);
dum2(1,:,:) = dum;
nc_varput(newParentFile,'vbar',0*dum2);

dum = nc_varget(newParentFile,'u');
[nz,ny,nx] = size(dum)
dum2 = zeros(1,nz,ny,nx);
dum2(1,:,:,:) = dum;
nc_varput(newParentFile,'u',0*dum2);

dum = nc_varget(newParentFile,'v');
[nz,ny,nx] = size(dum)
dum2 = zeros(1,nz,ny,nx);
dum2(1,:,:,:) = dum;
nc_varput(newParentFile,'v',0*dum2);


temp = nc_varget(sourceFile,'temp');

dum = nc_varget(newParentFile,'temp');
[nz,ny,nx] = size(dum)
for kk=1:nz
    dum(kk,:,:) = temp(kk,10,10);
end;
dum2 = zeros(1,nz,ny,nx);

dum2(1,:,:,:) = dum;
nc_varput(newParentFile,'temp',dum2);


salt = nc_varget(sourceFile,'salt')

dum = nc_varget(newParentFile,'salt');
[nz,ny,nx] = size(dum)
for kk=1:nz
    dum(kk,:,:) = salt(kk,10,10);
end;
dum2 = zeros(1,nz,ny,nx);

dum2(1,:,:,:) = dum;
nc_varput(newParentFile,'salt',dum2);


dStart = 43829;     % chosen arbitrarily
nc_varput(newParentFile,'ocean_time',dStart);

