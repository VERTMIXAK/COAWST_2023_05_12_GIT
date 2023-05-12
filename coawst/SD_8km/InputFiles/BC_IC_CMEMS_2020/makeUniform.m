origFile = 'CMEMS_2020_bdry_SD_8km.nc';
newFile  = 'CMEMS_2020_bdry_SD_8km_uniform.nc';
gridFile = '../Gridpak/SD_8km.nc';
HISFile  = 'HISfile.nc';
INIFile  = 'ini_002/CMEMS_2020_002_ic_SD_8km_uniform.nc';

unix(['cp ',origFile,' ',newFile]);

grd = roms_get_grid(gridFile,HISFile,0,0);

temp = nc_varget(INIFile,'temp');
salt = nc_varget(INIFile,'salt');
u    = nc_varget(INIFile,'u');
v    = nc_varget(INIFile,'v');
ubar = nc_varget(INIFile,'ubar');
vbar = nc_varget(INIFile,'vbar');
zeta = nc_varget(INIFile,'zeta');

nt = length(nc_varget(newFile,'ocean_time'));

%% West

var1 = 'temp_west';
var2 = temp;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:,:) = sq(var2(:,:,1));
end;
nc_varput(newFile,var1,dum);

var1 = 'salt_west';
var2 = salt;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:,:) = sq(var2(:,:,1));
end;
nc_varput(newFile,var1,dum);

var1 = 'u_west';
var2 = u;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:,:) = sq(var2(:,:,1));
end;
nc_varput(newFile,var1,dum);

var1 = 'v_west';
var2 = v;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:,:) = sq(var2(:,:,1));
end;
nc_varput(newFile,var1,dum);

var1 = 'zeta_west';
var2 = zeta;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:) = sq(var2(:,1));
end;
nc_varput(newFile,var1,dum);

var1 = 'ubar_west';
var2 = ubar;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:) = sq(var2(:,1));
end;
nc_varput(newFile,var1,dum);

var1 = 'vbar_west';
var2 = vbar;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:) = sq(var2(:,1));
end;
nc_varput(newFile,var1,dum);

aaa=5;


%% South

var1 = 'temp_south';
var2 = temp;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:,:) = sq(var2(:,1,:));
end;
nc_varput(newFile,var1,dum);

var1 = 'salt_south';
var2 = salt;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:,:) = sq(var2(:,1,:));
end;
nc_varput(newFile,var1,dum);

var1 = 'u_south';
var2 = u;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:,:) = sq(var2(:,1,:));
end;
nc_varput(newFile,var1,dum);

var1 = 'v_south';
var2 = v;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:,:) = sq(var2(:,1,:));
end;
nc_varput(newFile,var1,dum);

var1 = 'zeta_south';
var2 = zeta;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:) = sq(var2(1,:));
end;
nc_varput(newFile,var1,dum);

var1 = 'ubar_south';
var2 = ubar;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:) = sq(var2(1,:));
end;
nc_varput(newFile,var1,dum);

var1 = 'vbar_south';
var2 = vbar;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:) = sq(var2(1,:));
end;
nc_varput(newFile,var1,dum);

aaa=5;



%% North

var1 = 'temp_north';
var2 = temp;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:,:) = sq(var2(:,end,:));
end;
nc_varput(newFile,var1,dum);

var1 = 'salt_north';
var2 = salt;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:,:) = sq(var2(:,end,:));
end;
nc_varput(newFile,var1,dum);

var1 = 'u_north';
var2 = u;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:,:) = sq(var2(:,end,:));
end;
nc_varput(newFile,var1,dum);

var1 = 'v_north';
var2 = v;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:,:) = sq(var2(:,end,:));
end;
nc_varput(newFile,var1,dum);

var1 = 'zeta_north';
var2 = zeta;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:) = sq(var2(end,:));
end;
nc_varput(newFile,var1,dum);

var1 = 'ubar_north';
var2 = ubar;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:) = sq(var2(end,:));
end;
nc_varput(newFile,var1,dum);

var1 = 'vbar_north';
var2 = vbar;
dum = nc_varget(newFile,var1);
for tt=1:nt
    dum(tt,:) = sq(var2(end,:));
end;
nc_varput(newFile,var1,dum);


