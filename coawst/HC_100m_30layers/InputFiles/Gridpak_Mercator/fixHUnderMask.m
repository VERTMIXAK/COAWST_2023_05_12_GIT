file = 'HC_100mME.nc';

h = nc_varget(file,'h');
mask = nc_varget(file,'mask_rho');

%%


fig(1);clf;pcolor(h);shading flat;colorbar

fig(2);clf;pcolor(mask);shading flat;colorbar

h = h .* mask;
h(h == 0) = 4;

nc_varput(file,'h',h);


%% WET_DRY version

wetDryFile = 'HC_100mME_wetDry.nc';
unix(['cp ',file,' ',wetDryFile]);

h = h .* mask;
h(h == 0) = -5;

fig(4);clf;pcolor(h);shading flat
h(1,1)


nc_varput(wetDryFile,'h',h);