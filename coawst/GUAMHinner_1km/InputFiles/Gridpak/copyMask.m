oldFile = '/import/c1/VERTMIX/jgpender/coawst/GUAMDinner_1km/InputFiles/Gridpak/GUAMDinner_1km.nc';
newFile = 'GUAMFinner_1km.nc';
copyFile = 'GUAMFinner_1km.nc_ORIG';
unix(['cp ',copyFile,' ',newFile]);

oldMask = nc_varget(oldFile,'mask_rho');
newMask = nc_varget(newFile,'mask_rho');
size(newMask)
[ny,nx]=size(oldMask);
newMask(1:ny,:) = oldMask(:,1:end-1);
size(newMask)
nc_varput(newFile,'mask_rho',newMask);


oldMask = nc_varget(oldFile,'mask_psi');
newMask = nc_varget(newFile,'mask_psi');
size(newMask)
[ny,nx]=size(oldMask);
newMask(1:ny,:) = oldMask(:,1:end-1);
size(newMask)
nc_varput(newFile,'mask_psi',newMask);


oldMask = nc_varget(oldFile,'mask_u');
newMask = nc_varget(newFile,'mask_u');
size(newMask)
[ny,nx]=size(oldMask);
newMask(1:ny,:) = oldMask(:,1:end-1);
size(newMask)
nc_varput(newFile,'mask_u',newMask);


oldMask = nc_varget(oldFile,'mask_v');
newMask = nc_varget(newFile,'mask_v');
size(newMask)
[ny,nx]=size(oldMask);
newMask(1:ny,:) = oldMask(:,1:end-1);
size(newMask)
nc_varput(newFile,'mask_v',newMask);


% range=[180:200,170:200];
% fig(1);pcolor(oldMask(180:200,170:200));shading flat
% fig(2);pcolor(newMask(180:200,170:200));shading flat
