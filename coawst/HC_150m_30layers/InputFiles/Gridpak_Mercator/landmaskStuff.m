gridFile = 'HC_125mME.nc';
LOgridFile = '../cas6_v3_lo8b_Source/PS_UW_grid_morePoints.nc';

mask_rho = nc_varget(gridFile,'mask_rho');
% mask_psi = nc_varget(gridFile,'mask_psi');
% mask_u   = nc_varget(gridFile,'mask_u');
% mask_v   = nc_varget(gridFile,'mask_v');

mask_rhoLO = nc_varget(LOgridFile,'mask_rho');

[ny nx] =  size(mask_rho);



aaa=5;
mask_rho = sign( mask_rho + mask_rhoLO);






% fig(1);clf;pcolor(mask_psi(830:end,1:250));shading flat;colorbar
fig(2);clf;pcolor(mask_rho);shading flat

mask_rho(1:100,175:end) = 0;
% mask_psi(1:75,175:end) = 0;
% mask_u(1:75,175:end)   = 0;
% mask_v(1:75,175:end)   = 0;
fig(3);clf;pcolor(mask_rho);shading flat



mask_rho(1:50,140:180) = 0;
% mask_psi(1:75,175:end) = 0;
% mask_u(1:75,175:end)   = 0;
% mask_v(1:75,175:end)   = 0;
fig(3);clf;pcolor(mask_rho);shading flat



%%

% fig(1);clf;pcolor(mask_psi(830:end,1:250));shading flat;colorbar
fig(2);clf;pcolor(mask_rho);shading flat

mask_rho(150:380,270:end) = 0;
% mask_psi(150:390,260:end) = 0;
% mask_u(150:390,260:end)   = 0;
% mask_v(150:390,260:end)   = 0;
fig(3);clf;pcolor(mask_rho);shading flat


mask_rho(150:320,235:279) = 0;
% mask_psi(150:390,260:end) = 0;
% mask_u(150:390,260:end)   = 0;
% mask_v(150:390,260:end)   = 0;
fig(3);clf;pcolor(mask_rho);shading flat


aaa=5;


%%

fig(2);clf;pcolor(mask_rho);shading flat;xlim([290 nx]);ylim([370 410])

mask_rho(375:406,300:end) = 0;


fig(3);clf;pcolor(mask_rho);shading flat







%%

nc_varput(gridFile,'mask_rho',mask_rho);
% nc_varput(gridFile,'mask_psi',mask_psi);
% nc_varput(gridFile,'mask_u',mask_u);
% nc_varput(gridFile,'mask_v',mask_v);
