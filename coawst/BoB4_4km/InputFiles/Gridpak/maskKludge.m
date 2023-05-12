oldMaskFile = '../Gridpak_ORIG/BoB3_4km.nc';
newGridFile = 'BoB3_4km.nc';

mask_rhoOld = nc_varget(oldMaskFile,'mask_rho');
mask_psiOld = nc_varget(oldMaskFile,'mask_psi');
mask_uOld   = nc_varget(oldMaskFile,'mask_u');
mask_vOld   = nc_varget(oldMaskFile,'mask_v');

mask_rhoNew = nc_varget(newGridFile,'mask_rho');
mask_psiNew = nc_varget(newGridFile,'mask_psi');
mask_uNew   = nc_varget(newGridFile,'mask_u');
mask_vNew   = nc_varget(newGridFile,'mask_v');

%% rho

% fig(1);clf;pcolor(mask_rhoOld);shading flat
% fig(2);clf;pcolor(mask_rhoNew);shading flat

[oldJ,oldI] = size(mask_rhoOld)
[newJ,newI] = size(mask_rhoNew)

myJ = min(oldJ,newJ) - 1;
myI = min(oldI,newI) - 1;

mask_rhoNew(end-myJ:end,end-myI:end) = mask_rhoOld(end-myJ:end,end-myI:end);

% fig(3);clf;pcolor(mask_rhoNew);shading flat

nc_varput(newGridFile,'mask_rho',mask_rhoNew);


%% psi

% fig(1);clf;pcolor(mask_rhoOld);shading flat
% fig(2);clf;pcolor(mask_rhoNew);shading flat

[oldJ,oldI] = size(mask_psiOld)
[newJ,newI] = size(mask_psiNew)

myJ = min(oldJ,newJ) - 1;
myI = min(oldI,newI) - 1;

mask_psiNew(end-myJ:end,end-myI:end) = mask_psiOld(end-myJ:end,end-myI:end);

% fig(3);clf;pcolor(mask_rhoNew);shading flat

nc_varput(newGridFile,'mask_psi',mask_psiNew);


%% u

% fig(1);clf;pcolor(mask_rhoOld);shading flat
% fig(2);clf;pcolor(mask_rhoNew);shading flat

[oldJ,oldI] = size(mask_uOld)
[newJ,newI] = size(mask_uNew)

myJ = min(oldJ,newJ) - 1;
myI = min(oldI,newI) - 1;

mask_uNew(end-myJ:end,end-myI:end) = mask_uOld(end-myJ:end,end-myI:end);

% fig(3);clf;pcolor(mask_rhoNew);shading flat

nc_varput(newGridFile,'mask_u',mask_uNew);




%% v

% fig(1);clf;pcolor(mask_rhoOld);shading flat
% fig(2);clf;pcolor(mask_rhoNew);shading flat

[oldJ,oldI] = size(mask_vOld)
[newJ,newI] = size(mask_vNew)

myJ = min(oldJ,newJ) - 1;
myI = min(oldI,newI) - 1;

mask_vNew(end-myJ:end,end-myI:end) = mask_vOld(end-myJ:end,end-myI:end);

% fig(3);clf;pcolor(mask_rhoNew);shading flat

nc_varput(newGridFile,'mask_v',mask_vNew);


