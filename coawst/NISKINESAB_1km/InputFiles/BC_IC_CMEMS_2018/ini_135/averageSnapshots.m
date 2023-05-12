file1 = 'CMEMS_PHY_135.5_ic_NISKINESAB_1km.nc';
file2 = 'CMEMS_PHY_134.5_ic_NISKINESAB_1km.nc';
outFile = 'CMEMS_2018_135_ic_NISKINESAB_1km.nc';

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
temp = zeros(1,ny,nx);
temp(1,:,:) = dum;
nc_varput(outFile,var,temp);


var = 'temp';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
[nz,ny,nx] = size(dum);
temp = zeros(1,nz,ny,nx);
temp(1,:,:,:) = dum;
nc_varput(outFile,var,temp);


var = 'salt';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
[nz,ny,nx] = size(dum);
temp = zeros(1,nz,ny,nx);
temp(1,:,:,:) = dum;
nc_varput(outFile,var,temp);


var = 'u';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
[nz,ny,nx] = size(dum);
temp = zeros(1,nz,ny,nx);
temp(1,:,:,:) = dum;
nc_varput(outFile,var,temp);


var = 'ubar';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
[ny,nx] = size(dum);
temp = zeros(1,ny,nx);
temp(1,:,:) = dum;
nc_varput(outFile,var,temp);


var = 'v';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
[nz,ny,nx] = size(dum);
temp = zeros(1,nz,ny,nx);
temp(1,:,:,:) = dum;
nc_varput(outFile,var,temp);


var = 'vbar';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
[ny,nx] = size(dum);
temp = zeros(1,ny,nx);
temp(1,:,:) = dum;
nc_varput(outFile,var,temp);

