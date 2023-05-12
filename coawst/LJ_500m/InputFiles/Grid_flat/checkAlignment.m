clear;
tabwindow;

fileP = 'LJ_500m_parent.nc';
fileC = 'LJ_500m_child.nc';

grdP = roms_get_grid(fileP);
grdC = roms_get_grid(fileC);

jMin = 12;
jMax = 45;
iMin = 9;
iMax = 31;

%% check psi grid

fig(1);clf;
plot(grdC.lon_psi,grdC.lat_psi,'.')

fig(2);clf;
plot(grdP.lon_psi(jMin:jMax,iMin:iMax),grdP.lat_psi(jMin:jMax,iMin:iMax),'O')

fig(3);clf;
plot(grdC.lon_psi,grdC.lat_psi,'.');
hold on
plot(grdP.lon_psi(jMin:jMax,iMin:iMax),grdP.lat_psi(jMin:jMax,iMin:iMax),'O')


%% check rho grid

fig(11);clf;
plot(grdC.lon_rho,grdC.lat_rho,'.')

fig(12);clf;
plot(grdP.lon_rho(jMin:jMax,iMin:iMax),grdP.lat_rho(jMin:jMax,iMin:iMax),'O')

fig(13);clf;
plot(grdC.lon_rho,grdC.lat_rho,'.');
hold on
plot(grdP.lon_rho(jMin:jMax+1,iMin:iMax+1),grdP.lat_rho(jMin:jMax+1,iMin:iMax+1),'O')

%% h on eastern edge

fig(21);clf;
plot(grdC.lat_rho(:,end-2),sq(grdC.h(:,end-2)));

fig(22);clf;
plot(grdP.lon_rho(jMin:jMax,iMax-1),grdP.h(jMin:jMax,iMax-1),'O')



fig(99);clf;
plot(grdP.lon_rho(jMin:jMax,iMax-1))




