gridFile = '../Gridpak/LJ_500m.nc';
hisFile  = '../../Experiments/LJ_500m_2020_001_nesting_oneWay/netcdfOutput/lj_his_parent_00001.nc';

sourceFile = 'CMEMSsource_2021_244.nc';

grd = roms_get_grid(gridFile,hisFile,0,1);


oldZ = nc_varget(sourceFile,'z');
oldZ'

newZ = flipud( (-grd.z_r(:,10,10) )  );
newZ'

oldT = nc_varget(sourceFile,'temp');
[nz,ny,nx] = size(oldT);
newTmat = nc_varget(hisFile,'temp');
size(newTmat);
newTvec = fliplr(sq(newTmat(10,:,10,10)))

oldS = nc_varget(sourceFile,'salt');
[nz,ny,nx] = size(oldS);
newSmat = nc_varget(hisFile,'salt');
size(newSmat);
newSvec = fliplr(sq(newSmat(10,:,10,10)))

newT = zeros(1,nz,ny,nx);
newS = zeros(1,nz,ny,nx);


for jj=1:ny; for ii=1:nx
    newT(1,:,jj,ii) = newTvec;
    newS(1,:,jj,ii) = newSvec;
end;end;

nc_varput(sourceFile,'z',newZ);
nc_varput(sourceFile,'temp',newT);
nc_varput(sourceFile,'salt',newS);

dum = nc_varget(sourceFile,'ssh');
[ny,nx] = size(dum);
dum2 = zeros(1,ny,nx);
nc_varput(sourceFile,'ssh',dum2);

dum = nc_varget(sourceFile,'u');
[nz,ny,nx] = size(dum);
dum2 = zeros(1,nz,ny,nx);
nc_varput(sourceFile,'u',dum2);

dum = nc_varget(sourceFile,'v');
[nz,ny,nx] = size(dum);
dum2 = zeros(1,nz,ny,nx);
nc_varput(sourceFile,'v',dum2);


%% fix grid file

gFile = 'LARRY_grid.nc';
dum = nc_varget(gFile,'z');
nc_varput(gFile,'z',newZ);





