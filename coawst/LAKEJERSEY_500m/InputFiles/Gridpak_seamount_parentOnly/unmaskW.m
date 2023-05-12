close all;clear;tabwindow;

oldFile = '../Gridpak/lake_jersey_grd_a.nc';
newFile =            'lake_jersey_grd_a.nc';

unix(['cp ',oldFile,' ',newFile]);


dum = nc_varget(newFile,'mask_rho');
dum = 0*dum + 1;
dum(1,:)   = 0;
dum(end,:) = 0;
nc_varput(newFile,'mask_rho',dum);

dum = nc_varget(newFile,'mask_psi');
dum = 0*dum + 1;
dum(1,:)   = 0;
dum(end,:) = 0;
nc_varput(newFile,'mask_psi',dum);

dum = nc_varget(newFile,'mask_u');
dum = 0*dum + 1;
dum(1,:)   = 0;
dum(end,:) = 0;
nc_varput(newFile,'mask_u',dum);

dum = nc_varget(newFile,'mask_v');
dum = 0*dum + 1;
dum(1,:)   = 0;
dum(end,:) = 0;
nc_varput(newFile,'mask_v',dum);






