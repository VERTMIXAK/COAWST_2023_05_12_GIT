oldFile = 'Flat_2022_bdry_PRAIRIEinner_1km.nc';
newFile = 'Flat_2022_bdry_PRAIRIEinner_1km_constTS.nc';
unix(['cp ',oldFile,' ',newFile]);

dum = nc_varget(newFile,'salt_north');
dum = 34.5 + 0.*dum;
nc_varput(newFile,'salt_north',dum);
dum = 20. + 0.*dum;
nc_varput(newFile,'temp_north',dum);

dum = nc_varget(newFile,'salt_south');
dum = 34.5 + 0.*dum;
nc_varput(newFile,'salt_south',dum);
dum = 20. + 0.*dum;
nc_varput(newFile,'temp_south',dum);

dum = nc_varget(newFile,'salt_east');
dum = 34.5 + 0.*dum;
nc_varput(newFile,'salt_east',dum);
dum = 20. + 0.*dum;
nc_varput(newFile,'temp_east',dum);

dum = nc_varget(newFile,'salt_west');
dum = 34.5 + 0.*dum;
nc_varput(newFile,'salt_west',dum);
dum = 20. + 0.*dum;
nc_varput(newFile,'temp_west',dum);



oldFile = 'ini_074/Flat_2022_074_ic_PRAIRIEinner_1km.nc';
newFile = 'ini_074/Flat_2022_074_ic_PRAIRIEinner_1km_constTS.nc';
unix(['cp ',oldFile,' ',newFile]);

dum = nc_varget(newFile,'salt');
dum = 34.5 + 0.*dum;
[nz,ny,nx] = size(dum);
dum2 = zeros(1,nz,ny,nx);
dum2(1,:,:,:) = dum;
nc_varput(newFile,'salt',dum2);
dum2 = 20. + 0.*dum2;
nc_varput(newFile,'temp',dum2);

oldFile = 'ini_074_nest/Flat_2022_074_ic_PRAIRIEinnerNest_1km.nc';
newFile = 'ini_074_nest/Flat_2022_074_ic_PRAIRIEinnerNest_1km_constTS.nc';
unix(['cp ',oldFile,' ',newFile]);

dum = nc_varget(newFile,'salt');
dum = 34.5 + 0.*dum;
[nz,ny,nx] = size(dum);
dum2 = zeros(1,nz,ny,nx);
dum2(1,:,:,:) = dum;
nc_varput(newFile,'salt',dum2);
dum2 = 20. + 0.*dum2;
nc_varput(newFile,'temp',dum2);

