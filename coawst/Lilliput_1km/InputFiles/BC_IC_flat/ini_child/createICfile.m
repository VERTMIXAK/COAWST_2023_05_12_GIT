sourceFile = 'lake_jersey_ini_a.nc';

oldChildFile = 'CMEMSsource_244_ic_LJ_500m_child.nc';
newChildFile = 'LJ_ic_child.nc';

unix(['cp ',oldChildFile,' ',newChildFile]);

dum = nc_varget(newChildFile,'zeta');
[ny,nx] = size(dum)
dum2 = zeros(1,ny,nx);
dum2(1,:,:) = dum;
nc_varput(newChildFile,'zeta',0*dum2);

dum = nc_varget(newChildFile,'ubar');
[ny,nx] = size(dum)
dum2 = zeros(1,ny,nx);
dum2(1,:,:) = dum;
nc_varput(newChildFile,'ubar',0*dum2);

dum = nc_varget(newChildFile,'vbar');
[ny,nx] = size(dum)
dum2 = zeros(1,ny,nx);
dum2(1,:,:) = dum;
nc_varput(newChildFile,'vbar',0*dum2);

dum = nc_varget(newChildFile,'u');
[nz,ny,nx] = size(dum)
dum2 = zeros(1,nz,ny,nx);
dum2(1,:,:,:) = dum;
nc_varput(newChildFile,'u',0*dum2);

dum = nc_varget(newChildFile,'v');
[nz,ny,nx] = size(dum)
dum2 = zeros(1,nz,ny,nx);
dum2(1,:,:,:) = dum;
nc_varput(newChildFile,'v',0*dum2);


temp = nc_varget(sourceFile,'temp');

dum = nc_varget(newChildFile,'temp');
[nz,ny,nx] = size(dum)
for kk=1:nz
    dum(kk,:,:) = temp(kk,10,10);
end;
dum2 = zeros(1,nz,ny,nx);

dum2(1,:,:,:) = dum;
nc_varput(newChildFile,'temp',dum2);


salt = nc_varget(sourceFile,'salt')

dum = nc_varget(newChildFile,'salt');
[nz,ny,nx] = size(dum)
for kk=1:nz
    dum(kk,:,:) = salt(kk,10,10);
end;
dum2 = zeros(1,nz,ny,nx);

dum2(1,:,:,:) = dum;
nc_varput(newChildFile,'salt',dum2);

dStart = 43829;        % chosen arbitrarily
nc_varput(newChildFile,'ocean_time',dStart);

