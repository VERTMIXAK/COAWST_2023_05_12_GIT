oldMaskFile = 'safeDir/SEAK_1km_narrower.nc';
newGridFile = 'SEAKp_1km.nc';

mask_rho = nc_varget(oldMaskFile,'mask_rho');
mask_psi = nc_varget(oldMaskFile,'mask_psi');
mask_u   = nc_varget(oldMaskFile,'mask_u');
mask_v   = nc_varget(oldMaskFile,'mask_v');

nc_varput(newGridFile,'mask_rho',mask_rho);
nc_varput(newGridFile,'mask_psi',mask_psi);
nc_varput(newGridFile,'mask_u'  ,mask_u);
nc_varput(newGridFile,'mask_v'  ,mask_v);