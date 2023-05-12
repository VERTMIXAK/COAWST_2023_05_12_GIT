gridFile = 'HC_100mME.nc';

mask_rho = nc_varget(gridFile,'mask_rho');

[ny nx] =  size(mask_rho);

aaa=5;






% fig(1);clf;pcolor(mask_psi(830:end,1:250));shading flat;colorbar
fig(2);clf;pcolor(mask_rho);shading flat

mask_rho(1:200,250:end) = 0;
mask_rho(1:50,150:300) = 0;
fig(3);clf;pcolor(mask_rho);shading flat

aaa=5;

mask_rho(200:500,350:end) = 0;
fig(3);clf;pcolor(mask_rho);shading flat


aaa=5;


mask_rho(550:630,440:end) = 0;
fig(3);clf;pcolor(mask_rho);shading flat


aaa=5;








%%

nc_varput(gridFile,'mask_rho',mask_rho);