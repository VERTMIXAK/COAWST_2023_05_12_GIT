file = 'netcdfOutput/ng_his2_00001.nc'

mask = nc_varget(file,'wetdry_mask_rho');
zeta = nc_varget(file,'zeta');

min(zeta(:))

[nt,ny,nx] = size(zeta);

%% zeta(end) with and without masking

myTime = 6;

fig(1);clf
pcolor(sq(zeta(myTime,:,:)));shading flat;colorbar

fig(2);clf
pcolor(sq(mask(myTime,:,:)) .* sq(zeta(end,:,:)));shading flat;colorbar



%% the land masks evolve

fig(3);clf

pcolor(sq(mask(myTime,:,:) - mask(1,:,:)));shading flat;colorbar


