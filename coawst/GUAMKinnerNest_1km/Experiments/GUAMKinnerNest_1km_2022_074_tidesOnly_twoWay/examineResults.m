clear
h2file = 'netcdfOutput/guam_his2_00001.nc'
h2nestfile = 'netcdfOutput/guam_his2_nest_00001.nc'
h3file = 'netcdfOutput/guam_his_00001.nc'
grd=roms_get_grid(h2file);grd2=roms_get_grid(h2nestfile);
temp_surParent = nc_varget(h2file,'temp_sur');
temp_surSubgrid = nc_varget(h2nestfile,'temp_sur');
% dat2 =hls_nc_getall(h2file)
% dat3 =hls_nc_getall(h3file)
%%
bb = [144.25 146.125 13.5 14.75]
figure(1);clf;colormap(gray)
pcolor(grd.lon_rho,grd.lat_rho,gradient(grd.h));shading flat;hold on
contour(grd.lon_rho,grd.lat_rho,(grd.h),16,'k');rect;caxis([-100,100]*2.5);
contour(grd.lon_rho,grd.lat_rho,squeeze(temp_surParent(end,:,:))-squeeze(temp_surParent(1,:,:)),[.25:.25:2],'r');shading flat;colorbar;rect
% hls_plot_bb(grd2.bb,'g--')
% hlim(bb);
pcolor(grd.mask_rho);


%%

fig(99);clf;
pcolor(grd.lon_rho,grd.lat_rho,grd.mask_rho);shading flat;rect

