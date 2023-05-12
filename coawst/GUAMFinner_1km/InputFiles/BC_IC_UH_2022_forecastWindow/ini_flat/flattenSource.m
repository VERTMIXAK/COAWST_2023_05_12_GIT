sourceFile = 'Flat_243.nc_ORIG';
newFile    = 'Flat_243.nc';
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

% Locate the middle of my grid on the MERCATOR source file

lat = nc_varget(newFile,'lat1d');
lon = nc_varget(newFile,'lon1d');

dumLat = abs(lat-70.875);
dumLon = abs(lon+7);

[lat0,~] = find(dumLat == min(dumLat));lat0=lat0(1);
[lon0,~] = find(dumLon == min(dumLon))

%% find deepest local spot

%  temp

temp = nc_varget(newFile,'temp');
fig(1);clf;pcolor(lon,lat,sq(temp(end-21,:,:)));shading flat
fig(2);clf;pcolor(lon(lon0-10:lon0+10),lat(lat0-10:lat0+10),sq(temp(end-6,lat0-10:lat0+10,lon0-10:lon0+10)))

myLat = lat0+3;
myLon = lon0+6;

[nz,ny,nx] = size(temp);
for kk=1:nz
    temp(kk,:,:) = temp(kk,myLat,myLon);
end;

dum2 = zeros(1,nz,ny,nx);
dum2(1,:,:,:) = temp;
nc_varput(newFile,'temp',dum2);

salt = nc_varget(newFile,'salt');
[nz,ny,nx] = size(salt);

for kk=1:nz
    salt(kk,:,:) = salt(kk,myLat,myLon);
end;

dum2 = zeros(1,nz,ny,nx);
dum2(1,:,:,:) = salt;
nc_varput(newFile,'salt',dum2);

