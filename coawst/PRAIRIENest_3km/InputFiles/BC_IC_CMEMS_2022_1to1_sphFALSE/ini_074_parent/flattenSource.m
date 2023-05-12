sourceFile = 'CMEMSsource_074.nc';
newFile    = 'CMEMSsource_074_flat.nc';
unix(['cp ',sourceFile,' ',newFile]);

dum = nc_varget(newFile,'ssh');
[ny,nx] = size(dum);
dum2 = zeros(1,ny,nx);
nc_varput(newFile,'ssh',dum2)
dum = nc_varget(newFile,'u');
[nz,ny,nx] = size(dum);
dum2 = zeros(1,nz,ny,nx);
nc_varput(newFile,'u',dum2);

dum = nc_varget(newFile,'v');
[nz,ny,nx] = size(dum);
dum2 = zeros(1,nz,ny,nx);
nc_varput(newFile,'v',dum2);

% My grid has h thresholded at 6000 m, so pick a lat/lon in that area.

myLon = 145.932;
myLat = 12.86;

lat = nc_varget(newFile,'lat1d');
lon = nc_varget(newFile,'lon1d');

dumLat = abs(lat-myLat);
dumLon = abs(lon-myLon);

[lat0,~] = find(dumLat == min(dumLat));lat0=lat0(1);
[lon0,~] = find(dumLon == min(dumLon));

%% Use the profile at lat0/lon0

%  temp

myLat = lat0;
myLon = lon0;

temp = nc_varget(newFile,'temp');
[nz,ny,nx] = size(temp);
for kk=1:nz
    temp(kk,:,:) = temp(kk,myLat,myLon);
end;
temp(end,:,:) = temp(end-1,:,:);

dum2 = zeros(1,nz,ny,nx);
dum2(1,:,:,:) = temp;
nc_varput(newFile,'temp',dum2);

salt = nc_varget(newFile,'salt');
[nz,ny,nx] = size(salt);

for kk=1:nz
    salt(kk,:,:) = salt(kk,myLat,myLon);
end;
salt(end,:,:) = salt(end-1,:,:);

dum2 = zeros(1,nz,ny,nx);
dum2(1,:,:,:) = salt;
nc_varput(newFile,'salt',dum2);


