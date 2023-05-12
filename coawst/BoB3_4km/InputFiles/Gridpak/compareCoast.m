clear; 

hisFile = ('palau_his_00001.nc');
% grdp = roms_get_grid('../Gridpak/PALAU_120B.nc',hisFile,0,1)
grdp = roms_get_grid('PALAU_400m.nc')

load('/import/c1/VERTMIX/jgpender/ROMS/BathyData/Palau_5_100_130.00_140.00_2.00_11_merge_100m_07-Feb-2019.mat')

figure(1);clf;colormap(flipud(jet))
%pcolor(merge.lon,merge.lat,merge.D);shading flat;hold on
contour(merge.lon,merge.lat,merge.D,[50 50],'k');hold on
contour(grdp.lon_rho,grdp.lat_rho,grdp.mask_rho,[1 1],'r')
xlim([134 135])
ylim([6.5 8.75])
daspect([1 cosd(7.5) 1])
h=legend('topo 50m isobath','PALAU_120C rho land mask');set(h,'interpreter','none')


% figure(2);clf;colormap(flipud(jet))
% %pcolor(merge.lon,merge.lat,merge.D);shading flat;hold on
% contour(merge.lon,merge.lat,merge.D,[50 50],'k');hold on
% contour(grdp.lon_psi,grdp.lat_psi,grdp.mask_psi,[1 1],'r')
% xlim([134 135])
% ylim([6.5 8.75])
% daspect([1 cosd(7.5) 1])
% h=legend('topo 50m isobath','PALAU_120C psi land mask');set(h,'interpreter','none')


figure(3);clf;colormap(flipud(jet))
%pcolor(merge.lon,merge.lat,merge.D);shading flat;hold on
contour(merge.lon,merge.lat,merge.D,[50 50],'k');hold on
contour(grdp.lon_rho,grdp.lat_rho,grdp.h,[50 50],'r')
xlim([134 135])
ylim([6.5 8.75])
daspect([1 cosd(7.5) 1])
h=legend('topo 50m isobath','PALAU_400m rho land mask');set(h,'interpreter','none')






%%

% sourceFile = '/u1/uaf/jpender/ROMS/BathyData/Palau_Harper_gridpak.nc'
% sourceTopo = nc_varget(sourceFile,'topo');
% sourceLat = nc_varget(sourceFile,'topo_lat');
% sourceLon = nc_varget(sourceFile,'topo_lon');
% 
% figure(20);clf;colormap(flipud(jet))
% %pcolor(merge.lon,merge.lat,merge.D);shading flat;hold on
% contour(merge.lon,merge.lat,merge.D,[50 50],'k');hold on
% contour(sourceLon,sourceLat,sourceTopo,[-50 -50],'r')
% xlim([134 135])
% ylim([6.5 8.75])
% daspect([1 cosd(7.5) 1])
% h=legend('topo 50m isobath','gridpak source land mask');set(h,'interpreter','none')

