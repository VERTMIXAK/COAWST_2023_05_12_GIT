unix('\rm *.nc');

sourceDir = '../../lake_jersey_download_2022_09_30/Data/';

file = 'lake_jersey_ngc_2g_ab.nc';
unix(['cp ',sourceDir,file,' .']);

file = 'lake_jersey_grd_b.nc';
unix(['cp ',sourceDir,file,' .']);

file = 'lake_jersey_grd_a.nc';
unix(['cp ',sourceDir,file,' .']);

dum = nc_varget(file,'mask_rho');
dum = 0 * dum + 1;
% dum(1,:)   = 0;
% dum(end,:) = 0;
nc_varput(file,'mask_rho',dum);

dum = nc_varget(file,'mask_psi');
dum = 0 * dum + 1;
% dum(1,:)   = 0;
% dum(end,:) = 0;
nc_varput(file,'mask_psi',dum);

dum = nc_varget(file,'mask_u');
dum = 0 * dum + 1;
% dum(1,:)   = 0;
% dum(end,:) = 0;
nc_varput(file,'mask_u',dum);

dum = nc_varget(file,'mask_v');
dum = 0 * dum + 1;
% dum(1,:)   = 0;
% dum(end,:) = 0;
nc_varput(file,'mask_v',dum);
