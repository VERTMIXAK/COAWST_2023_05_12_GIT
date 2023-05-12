clear; close all
tabwindow;

% dir = 'Gridpak_normal/';
dir = 'Grid_3to1_modified/';

fileP =[dir, 'PRAIRIENest_3km_parent.nc'];
fileC =[dir, 'PRAIRIENest_3km_child.nc'];

grdP = roms_get_grid(fileP);
grdC = roms_get_grid(fileC);

jMin = 55;
jMax = 88;
iMin = 101;
iMax = 120;

% Check the grid spacing
grdP.pm(jMin:jMax+1,iMin:iMax+1) - 1/3000;max(abs(ans(:)))
grdC.pm - 1/1000;max(abs(ans(:)))

grdP.pn(jMin:jMax+1,iMin:iMax+1) - 1/3000;max(abs(ans(:)))
grdC.pn - 1/1000;max(abs(ans(:)))

% Verify that every third child psi grid point sits exactly on a parent psi
% grid point
grdP.x_psi(jMin:jMax,iMin:iMax)-grdC.x_psi(1:3:end,1:3:end);max(abs(ans(:)))
grdP.y_psi(jMin:jMax,iMin:iMax)-grdC.y_psi(1:3:end,1:3:end);max(abs(ans(:)))

%% check psi grid

% fig(1);clf;
% plot(grdC.lon_psi,grdC.lat_psi,'.')
% 
% fig(2);clf;
% plot(grdP.lon_psi(jMin:jMax,iMin:iMax),grdP.lat_psi(jMin:jMax,iMin:iMax),'O')

fig(1);clf;
plot(grdP.lon_psi(jMin:jMax,iMin:iMax),grdP.lat_psi(jMin:jMax,iMin:iMax),'O')
hold on
plot(grdC.lon_psi,grdC.lat_psi,'.');
xlim([152.95 153.55])
title('psi grid, child and parent')

%% Check h on rho grid

fig(2);clf;
plot(grdP.x_rho(jMin+1,iMin:iMax),grdP.h(jMin+1,iMin:iMax),'r')
hold on
plot(grdP.x_rho(jMin+1,iMin:iMax),grdP.h(jMin+1,iMin:iMax),'Or')
plot(grdC.x_rho(3,:),grdC.h(3,:),'.');
title('southern edge, h on rho grid, child and parent')

fig(3);clf;
plot(grdP.x_rho(jMax,iMin:iMax),grdP.h(jMax,iMin:iMax),'r')
hold on
plot(grdP.x_rho(jMax,iMin:iMax),grdP.h(jMax,iMin:iMax),'Or')
plot(grdC.x_rho(end-2,:),grdC.h(end-2,:),'.');
title('northern edge, h on rho grid, child and parent')

fig(4);clf;
plot(grdP.y_rho(jMin:jMax,iMin+1),grdP.h(jMin:jMax,iMin+1),'r')
hold on
plot(grdP.y_rho(jMin:jMax,iMin+1),grdP.h(jMin:jMax,iMin+1),'Or')
plot(grdC.y_rho(:,3),grdC.h(:,3),'.');
title('western edge, h on rho grid, child and parent')

fig(5);clf;
plot(grdP.y_rho(jMin:jMax,iMax),grdP.h(jMin:jMax,iMax),'r')
hold on
plot(grdP.y_rho(jMin:jMax,iMax),grdP.h(jMin:jMax,iMax),'Or')
plot(grdC.y_rho(:,end-2),grdC.h(:,end-2),'.');
title('western edge, h on rho grid, child and parent')


%% Put h on the psi grid

% note that every rho-grid cell has a psi-grid point in its center. So do a
% 4-corner average of every rho grid cell

% parent grid first
[ny,nx] = size(grdP.mask_psi);
HonPsiP = zeros(ny,nx);
for jj=1:ny; for ii=1:nx
    HonPsiP(jj,ii) = .25*( grdP.h(jj,ii) + grdP.h(jj,ii+1) + grdP.h(jj+1,ii) + grdP.h(jj+1,ii+1) );
end;end;

% now child grid
[ny,nx] = size(grdC.mask_psi);
HonPsiC = zeros(ny,nx);
for jj=1:ny; for ii=1:nx
    HonPsiC(jj,ii) = .25*( grdC.h(jj,ii) + grdC.h(jj,ii+1) + grdC.h(jj+1,ii) + grdC.h(jj+1,ii+1) );
end;end;



fig(10);clf
plot(grdC.y_psi(:,1),HonPsiC(:,1),'.r')
hold on
plot(grdP.y_psi(jMin:jMax,iMin),HonPsiP(jMin:jMax,iMin),'Ob')
title('h on psi grid - western boundary')

fig(11);clf
plot(grdC.y_psi(:,end),HonPsiC(:,end),'.r')
hold on
plot(grdP.y_psi(jMin:jMax,iMax),HonPsiP(jMin:jMax,iMax),'Ob')
title('h on psi grid - eastern boundary')

fig(12);clf
plot(grdC.x_psi(1,:),HonPsiC(1,:),'.r')
hold on
plot(grdP.x_psi(jMin,iMin:iMax),HonPsiP(jMin,iMin:iMax),'Ob')
title('h on psi grid - southern boundary')

fig(13);clf
plot(grdC.x_psi(end,:),HonPsiC(end,:),'.r')
hold on
plot(grdP.x_psi(jMax,iMin:iMax),HonPsiP(jMax,iMin:iMax),'Ob')
title('h on psi grid - northern boundary')

fig(14);clf
plot(grdC.x_psi(end-6,:),HonPsiC(end-6,:),'.r')
hold on
plot(grdP.x_psi(jMax-2,iMin:iMax),HonPsiP(jMax-2,iMin:iMax),'Ob')
title('h on psi grid - northern boundary minus 2 parent grid rows')



aaa=5;


%% Western edge


[ny,nx] = size(grdC.h)

% set up the for loop index to correspond to the rho grid points that need
% fixing

for jj=3:3:ny
    oldSum = grdC.h(jj,1) + grdC.h(jj,2);
    sum1 = ( 8*HonPsiC(jj-2,1) + 4*HonPsiC(jj+1,1) - 3*( grdC.h(jj-1,1) + grdC.h(jj-1,1 ) ) )/ 3;
    sum2 = ( 4*HonPsiC(jj-2,1) + 8*HonPsiC(jj+1,1) - 3*( grdC.h(jj+1,1) + grdC.h(jj+1,1 ) ) )/ 3;
    newSum = ( sum1 + sum2 ) /2;    % average of sum1 and sum2
    difference = newSum - oldSum ;
    grdC.h(jj,1) = grdC.h(jj,1) + difference/2;
    grdC.h(jj,2) = grdC.h(jj,2) + difference/2;
end
