clear; 

hisFile = ('palau_his_00001.nc');
grdp = roms_get_grid('PALAU_800m.nc',hisFile,0,1)

load('/import/c1/VERTMIX/jgpender/dataDir/Palau/Palau_4_250_130.00_140.00_2.00_15_merge_250m_20-Feb-2016.mat')
% load('/import/c1/VERTMIX/jgpender/ROMS/BathyData/Palau_5_250_130.00_140.00_2.00_11_merge_250m_21-Oct-2016.mat')

figure(1);clf;colormap(flipud(jet))
%pcolor(merge.lon,merge.lat,merge.D);shading flat;hold on
contour(merge.lon,merge.lat,merge.D,[50 50],'k');hold on
contour(grdp.lon_rho,grdp.lat_rho,grdp.mask_rho,[1 1],'r')
xlim([134 135])
ylim([6.5 8.75])
daspect([1 cosd(7.5) 1])
h=legend('topo 50m isobath','PALAU_800m rho land mask');set(h,'interpreter','none')

figure(3);clf;colormap(flipud(jet))
%pcolor(merge.lon,merge.lat,merge.D);shading flat;hold on
contour(merge.lon,merge.lat,merge.D,[50 50],'k');hold on
contour(grdp.lon_rho,grdp.lat_rho,grdp.h,[50 50],'r')
xlim([134 135])
ylim([6.5 8.75])
daspect([1 cosd(7.5) 1])
h=legend('topo 50m isobath','PALAU_120C 50m contour');set(h,'interpreter','none')


%% Now do the UH stuff

UHfile = '../frinkiacNew/singleSnapshots/fleat_5929.000.nc';

grdUH.lon_rho  = nc_varget(UHfile, 'lon_rho');
grdUH.lat_rho  = nc_varget(UHfile, 'lat_rho');
grdUH.mask_rho = nc_varget(UHfile, 'mask_rho');
grdUH.h        = nc_varget(UHfile, 'h');



figure(11);clf;colormap(flipud(jet))
%pcolor(merge.lon,merge.lat,merge.D);shading flat;hold on
contour(merge.lon,merge.lat,merge.D,[50 50],'k');hold on
contour(grdUH.lon_rho,grdUH.lat_rho,grdUH.mask_rho,[1 1],'r')
xlim([134 135])
ylim([6.5 8.75])
daspect([1 cosd(7.5) 1])
h=legend('topo 50m isobath','UH rho land mask');set(h,'interpreter','none')

figure(13);clf;colormap(flipud(jet))
%pcolor(merge.lon,merge.lat,merge.D);shading flat;hold on
contour(merge.lon,merge.lat,merge.D,[50 50],'k');hold on
contour(grdUH.lon_rho,grdUH.lat_rho,grdUH.h,[50 50],'r')
xlim([134 135])
ylim([6.5 8.75])
daspect([1 cosd(7.5) 1])
h=legend('topo 50m isobath','UH rho 50m contour');set(h,'interpreter','none')

