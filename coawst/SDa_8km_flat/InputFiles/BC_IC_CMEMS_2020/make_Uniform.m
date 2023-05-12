origFile = 'CMEMS_2020_bdry_SDa_8km_flat.nc';
newFile  = 'CMEMS_2020_bdry_SDa_8km_flat_uniform.nc';
% gridFile = '../Gridpak/SDa_8km_flat.nc';
iniFile  = 'ini_002/CMEMS_2020_002_ic_SDa_8km_flat_uniform.nc';

unix(['cp ',origFile,' ',newFile]);

% grd = roms_get_grid(gridFile,iniFile,0,0);

temp = nc_varget(iniFile,'temp');
salt = nc_varget(iniFile,'salt');
u    = nc_varget(iniFile,'u');
v    = nc_varget(iniFile,'v');
ubar = nc_varget(iniFile,'ubar');
vbar = nc_varget(iniFile,'vbar');
zeta = nc_varget(iniFile,'zeta');

[nt,~,~] = size(nc_varget(newFile,'temp_west'));

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

aaa=5;


