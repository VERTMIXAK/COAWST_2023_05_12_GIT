oldFile = '../../BC_IC/ini_a/lake_jersey_ini_a.nc';
newFile =             'lake_jersey_ini_a.nc';

unix(['cp ',oldFile,' ',newFile]);

current = .03;

dum = nc_varget(newFile,'ubar');
[ny,nx] = size(dum)
dum2 = zeros(1,ny,nx);
dum2(1,:,:) = 0*dum2 + current;

nc_varput(newFile,'ubar',dum2);

% dum = nc_varget(newFile,'zeta');
% [ny,nx] = size(dum)
% dum2 = zeros(1,ny,nx);
% dum2(1,:,:) = 0*dum2;
% nc_varput(newFile,'zeta',dum2);
% 
% dum = nc_varget(newFile,'vbar');
% [ny,nx] = size(dum)
% dum2 = zeros(1,ny,nx);
% dum2(1,:,:) = 0*dum2;
% nc_varput(newFile,'vbar',dum2);



dum = nc_varget(newFile,'u');
[nz,ny,nx] = size(dum)
dum2 = zeros(1,nz,ny,nx);
dum2(1,:,:,:) = 0*dum2 + current;
nc_varput(newFile,'u',dum2);

% dum = nc_varget(newFile,'v');
% [nz,ny,nx] = size(dum)
% dum2 = zeros(1,nz,ny,nx);
% dum2(1,:,:,:) = 0*dum2;
% nc_varput(newFile,'v',dum2);
% 
% dum = nc_varget(newFile,'temp');
% [nz,ny,nx] = size(dum)
% dum2 = zeros(1,nz,ny,nx);
% for kk = 1:nz
%     dum2(1,kk,:,:) = dum(kk,10,10);
% end;
% nc_varput(newFile,'temp',dum2);
% 
% dum = nc_varget(newFile,'salt');
% [nz,ny,nx] = size(dum)
% dum2 = zeros(1,nz,ny,nx);
% for kk = 1:nz
%     dum2(1,kk,:,:) = dum(kk,10,10);
% end;
% nc_varput(newFile,'salt',dum2);

%% get rid of mask

% dum = nc_varget(newFile,'mask_rho');
% dum = 0*dum + 1;
% dum(1,:)   = 0;
% dum(end,:) = 0;
% nc_varput(newFile,'mask_rho',dum);
% 
% dum = nc_varget(newFile,'mask_psi');
% dum = 0*dum + 1;
% dum(1,:)   = 0;
% dum(end,:) = 0;
% nc_varput(newFile,'mask_psi',dum);
% 
% dum = nc_varget(newFile,'mask_u');
% dum = 0*dum + 1;
% dum(1,:)   = 0;
% dum(end,:) = 0;
% nc_varput(newFile,'mask_u',dum);
% 
% dum = nc_varget(newFile,'mask_v');
% dum = 0*dum + 1;
% dum(1,:)   = 0;
% dum(end,:) = 0;
% nc_varput(newFile,'mask_v',dum);

















