file1 = 'CMEMS_PHY_2017_353.5_ic_SO_1km.nc';
file2 = 'CMEMS_PHY_2017_354.5_ic_SO_1km.nc';
outFile = 'CMEMS_2017_354_ic_SO_1km.nc';

unix(['cp ',file1,' ',outFile]);

var = 'ocean_time';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
nc_varput(outFile,var,dum);


var = 'zeta';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
[ny,nx] = size(dum);
dum2 = zeros(1,ny,nx);dum2(1,:,:) = dum;
nc_varput(outFile,var,dum2);


var = 'temp';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
[nz,ny,nx] = size(dum);
dum2 = zeros(1,nz,ny,nx);dum2(1,:,:,:) = dum;
nc_varput(outFile,var,dum2);


var = 'salt';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
[nz,ny,nx] = size(dum);
dum2 = zeros(1,nz,ny,nx);dum2(1,:,:,:) = dum;
nc_varput(outFile,var,dum2);


var = 'u';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
[nz,ny,nx] = size(dum);
dum2 = zeros(1,nz,ny,nx);dum2(1,:,:,:) = dum;
nc_varput(outFile,var,dum2);


var = 'ubar';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
[ny,nx] = size(dum);
dum2 = zeros(1,ny,nx);dum2(1,:,:) = dum;
nc_varput(outFile,var,dum2);


var = 'v';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
[nz,ny,nx] = size(dum);
dum2 = zeros(1,nz,ny,nx);dum2(1,:,:,:) = dum;
nc_varput(outFile,var,dum2);


var = 'vbar';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
[ny,nx] = size(dum);
dum2 = zeros(1,ny,nx);dum2(1,:,:) = dum;
nc_varput(outFile,var,dum2);

