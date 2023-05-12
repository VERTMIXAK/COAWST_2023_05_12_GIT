file = 'UH_074_flat_ic_GUAMIinner_1km.nc';

salt = nc_varget(file,'salt');
temp = nc_varget(file,'temp');

[nt,ny,nx] = size(salt);

for ii=1:6
    salt(:,:,ii) = salt(:,:,7);
    temp(:,:,ii) = temp(:,:,7);
end;

dum = ones(1,nt,ny,nx);
dum(1,:,:,:) = salt;
nc_varput(file,'salt',dum);

dum(1,:,:,:) = temp;
nc_varput(file,'temp',dum);

