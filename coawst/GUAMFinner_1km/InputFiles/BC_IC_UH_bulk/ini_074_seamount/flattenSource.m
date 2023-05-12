sourceFile = 'UH-03-15.nc';
newFile    = 'UH_074_flat.nc';
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

% myLon = 145.932;
% myLat = 12.86;

myLon = 144.8538;
myLat = 12.4326;

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

z = nc_varget(newFile,'z');

temp = nc_varget(newFile,'temp');
[nz,ny,nx] = size(temp);
for kk=1:nz; for ii=1:nx; for jj=1:ny
    if ~isnan( temp(kk,jj,ii) )
        temp(kk,jj,ii) = temp(kk,myLat,myLon);
    end;
end;end;end;
temp(end,:,:) = temp(end-1,:,:);

dum2 = zeros(1,nz,ny,nx);
dum2(1,:,:,:) = temp;
nc_varput(newFile,'temp',dum2);

salt = nc_varget(newFile,'salt');
[nz,ny,nx] = size(salt);
for kk=1:nz for ii=1:nx; for jj=1:ny
    if ~isnan( salt(kk,jj,ii) )
        salt(kk,jj,ii) = salt(kk,myLat,myLon);
    end;
end;end;end;
salt(end,:,:) = salt(end-1,:,:);

dum2 = zeros(1,nz,ny,nx);
dum2(1,:,:,:) = salt;
nc_varput(newFile,'salt',dum2);

%% Double check

saltOld = nc_varget(sourceFile,'salt');
saltNew = nc_varget(newFile,'salt');

fig(1);clf
plot(z,sq(sq(saltOld(:,lat0,lon0))))

fig(2);clf
plot(z,sq(sq(saltOld(:,50,50))))


fig(3);clf
plot(z,sq(sq(saltNew(:,50,50))))


