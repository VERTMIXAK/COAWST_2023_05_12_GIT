clear; close all
tabwindow;

% dir = 'Gridpak_normal/';
dir = 'Gridpak_noSphere/';

fileP =[dir, 'LJ_500m_parent.nc'];
fileC =[dir, 'LJ_500m_child.nc'];

grdP = roms_get_grid(fileP);
grdC = roms_get_grid(fileC);

jMin = 12;
jMax = 45;
iMin = 9;
iMax = 31;

%% check psi grid

% fig(1);clf;
% plot(grdC.lon_psi,grdC.lat_psi,'.')
% 
% fig(2);clf;
% plot(grdP.lon_psi(jMin:jMax,iMin:iMax),grdP.lat_psi(jMin:jMax,iMin:iMax),'O')

fig(3);clf;
plot(grdC.lon_psi,grdC.lat_psi,'.');
hold on
plot(grdP.lon_psi(jMin:jMax,iMin:iMax),grdP.lat_psi(jMin:jMax,iMin:iMax),'O')
title('psi grid')


%% check rho grid

% fig(11);clf;
% plot(grdC.lon_rho,grdC.lat_rho,'.')
% 
% fig(12);clf;
% plot(grdP.lon_rho(jMin:jMax,iMin:iMax),grdP.lat_rho(jMin:jMax,iMin:iMax),'O')

fig(13);clf;
plot(grdC.lon_rho,grdC.lat_rho,'.');
hold on
plot(grdP.lon_rho(jMin:jMax+1,iMin:iMax+1),grdP.lat_rho(jMin:jMax+1,iMin:iMax+1),'O')
title('rho grid')

%% h on eastern edge

% make sure there is agreement as to the value of x_rho

grdC.x_rho(20,end-2)
grdP.x_rho(20,iMax)


% fig(21);clf;
% plot(grdC.y_rho(:,end-2),grdC.h(:,end-2));
% 
% fig(22);clf;
% plot(grdP.y_rho(jMin:jMax,iMax),grdP.h(jMin:jMax,iMax))

fig(23);clf;
plot(grdC.y_rho(:,end-2),grdC.h(:,end),'.');
hold on;
plot(grdP.y_rho(jMin:jMax,iMax-1),grdP.h(jMin:jMax,iMax),'O')

fig(24);clf;
plot(grdC.x_rho(:,end-2),grdC.y_rho(:,end-2),'.');
hold on;
plot(grdP.x_rho(jMin:jMax,iMax),grdP.y_rho(jMin:jMax,iMax-1),'O')
title('h near western boundary of child grid')


%% try interp2

hTrial = interp2(grdP.x_rho(30,:),grdP.y_rho(:,30),grdP.h,grdC.x_rho(1,:),grdC.y_rho(:,1));

fig(33);clf;
plot(grdC.y_rho(:,end-2),hTrial(:,end),'.');
hold on;
plot(grdP.y_rho(jMin:jMax,iMax-1),grdP.h(jMin:jMax,iMax),'O')
