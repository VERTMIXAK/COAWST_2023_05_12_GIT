clear; close all
tabwindow;

% dir = 'Gridpak_normal/';
dir = 'Grid_3to1_modified/';

fileP =[dir, 'PRAIRIENest_3km_parent.nc'];
fileC =[dir, 'PRAIRIENest_3km_child.nc'];

grdP = roms_get_grid(fileP);
grdC = roms_get_grid(fileC);

% jMin = 55;
% jMax = 57;
% iMin = 101;
% iMax = 104;

iMin = 101;
iMax = 120;
jMin = 55;
jMax = 88;

% Check the grid spacing
grdP.pm(jMin:jMax+1,iMin:iMax+1) - 1/3000;max(abs(ans(:)))
grdC.pm - 1/1000;max(abs(ans(:)))

grdP.pn(jMin:jMax+1,iMin:iMax+1) - 1/3000;max(abs(ans(:)))
grdC.pn - 1/1000;max(abs(ans(:)))

% Verify that every third child psi grid point sits exactly on a parent psi
% grid point
% grdP.x_psi(jMin:jMax,iMin:iMax)-grdC.x_psi(1:3:end,1:3:end);max(abs(ans(:)))
% grdP.y_psi(jMin:jMax,iMin:iMax)-grdC.y_psi(1:3:end,1:3:end);max(abs(ans(:)))

%% check psi grid

% fig(1);clf;
% plot(grdC.x_psi,grdC.y_psi,'.')
% 
% fig(2);clf;
% plot(grdP.x_psi(jMin:jMax,iMin:iMax),grdP.y_psi(jMin:jMax,iMin:iMax),'O')

fig(101);clf;
plot(grdP.x_psi(jMin:jMax,iMin:iMax),grdP.y_psi(jMin:jMax,iMin:iMax),'O')
hold on
plot(grdC.x_psi,grdC.y_psi,'.');
% xlim([152.95 153.55])
title('psi grid, child and parent')

fig(102);clf;
plot(grdC.x_rho,grdC.y_rho,'.');
hold on
plot(grdP.x_rho(jMin:jMax+1,iMin:iMax+1),grdP.y_rho(jMin:jMax+1,iMin:iMax+1),'O')
title('rho grid')


% fig(103);clf;
% plot(grdC.x_u,grdC.y_u,'.');
% hold on
% plot(grdP.x_u(jMin:jMax,iMin:iMax),grdP.y_u(jMin:jMax,iMin:iMax),'O')
% % xlim([152.95 153.55])
% title('u grid')
% 
% 
% fig(104);clf;
% plot(grdC.x_v,grdC.y_v,'.');
% hold on
% plot(grdP.x_v(jMin:jMax,iMin:iMax),grdP.y_v(jMin:jMax,iMin:iMax),'O')
% title('v grid')

aaa=5;

%% Some plots

% northern rho cell boundary
fig(90);clf;
plot(grdP.x_rho(jMin+1,iMin:iMin+1),grdP.h(jMin+1,iMin:iMin+1),'r')
hold on;
plot(grdC.x_rho(3,1:3),grdC.h(3,1:3),'.b')
title('Northern rho cell boundary')

% Eastern rho cell boundary
fig(91);clf;
plot(grdP.y_rho(jMin:jMin+1,iMin+1),grdP.h(jMin:jMin+1,iMin+1),'r')
hold on;
plot(grdC.y_rho(1:3,3),grdC.h(1:3,3),'.b')
title('Eastern rho cell boundary')

% rising cell diagonal
dumx = [grdC.x_rho(1,1) grdC.x_rho(2,2) grdC.x_rho(3,3) ];
dumh = [grdC.h(1,1)     grdC.h(2,2)     grdC.h(3,3) ];
fig(92);clf;
plot([grdP.x_rho(jMin,iMin) grdP.x_rho(jMin+1,iMin+1)],[grdP.h(jMin,iMin) grdP.h(jMin+1,iMin+1)],'r')
hold on;
plot(dumx,dumh,'.b')
title('rising cell diagonal')

% falling cell diagonal
dumx = [grdC.x_rho(2,1) grdC.x_rho(1,2)  ];
dumh = [grdC.h(2,1)     grdC.h(1,2)      ];
fig(93);clf;
plot([grdP.x_rho(jMin+1,iMin) grdP.x_rho(jMin,iMin+1)],[grdP.h(jMin+1,iMin) grdP.h(jMin,iMin+1)],'r')
hold on;
plot(dumx,dumh,'.b')
title('falling rho cell diagonal')


% northern rho cell boundary in interior
fig(90);clf;
plot(grdP.x_rho(jMin+1,iMin:iMin+1),grdP.h(jMin+1,iMin:iMin+1),'r')
hold on;
plot(grdC.x_rho(3,1:3),grdC.h(3,1:3),'.b')
title('Northern rho cell boundary')

aaa=5;

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
plot(grdC.y_psi(:,1),HonPsiC(:,1),'r.')
hold on
plot(grdP.y_psi(jMin:jMax,iMin),HonPsiP(jMin:jMax,iMin),'Ob')
plot(grdP.y_psi(jMin:jMax,iMin),HonPsiP(jMin:jMax,iMin),'b')
title('h on psi grid - western boundary')

fig(11);clf
plot(grdC.y_psi(:,end),HonPsiC(:,end),'r.')
hold on
plot(grdP.y_psi(jMin:jMax,iMax),HonPsiP(jMin:jMax,iMax),'Ob')
plot(grdP.y_psi(jMin:jMax,iMax),HonPsiP(jMin:jMax,iMax),'b')
title('h on psi grid - eastern boundary')

fig(12);clf
plot(grdC.x_psi(1,:),HonPsiC(1,:),'r.')
hold on
plot(grdP.x_psi(jMin,iMin:iMax),HonPsiP(jMin,iMin:iMax),'Ob')
plot(grdP.x_psi(jMin,iMin:iMax),HonPsiP(jMin,iMin:iMax),'b')
title('h on psi grid - southern boundary')

fig(13);clf
plot(grdC.x_psi(end,:),HonPsiC(end,:),'r.')
hold on
plot(grdP.x_psi(jMax,iMin:iMax),HonPsiP(jMax,iMin:iMax),'Ob')
plot(grdP.x_psi(jMax,iMin:iMax),HonPsiP(jMax,iMin:iMax),'b')
title('h on psi grid - northern boundary')

% fig(14);clf
% plot(grdC.x_psi(end-6,:),HonPsiC(end-6,:),'.r')
% hold on
% plot(grdP.x_psi(jMax-2,iMin:iMax),HonPsiP(jMax-2,iMin:iMax),'Ob')
% title('h on psi grid - northern boundary minus 2 parent grid rows')



aaa=5;

%% check rho grid

% fig(11);clf;
% plot(grdC.x_rho,grdC.y_rho,'.')
% 
% fig(12);clf;
% plot(grdP.x_rho(jMin:jMax,iMin:iMax),grdP.y_rho(jMin:jMax,iMin:iMax),'O')

% fig(13);clf;
% plot(grdC.x_rho,grdC.y_rho,'.');
% hold on
% plot(grdP.x_rho(jMin:jMax+1,iMin:iMax+1),grdP.y_rho(jMin:jMax+1,iMin:iMax+1),'O')
% title('rho grid')

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
plot(grdC.y_rho(:,end-2),grdC.h(:,end-2),'.');
hold on;
plot(grdP.y_rho(jMin:jMax,iMax),grdP.h(jMin:jMax,iMax),'O')
title('h near western boundary of child grid')
xlabel('y-rho (m)');ylabel('h (m)')

% fig(24);clf;
plot(grdC.y_rho(:,end-5),grdC.h(:,end-5),'.r');
hold on;
plot(grdP.y_rho(jMin:jMax,iMax-1),grdP.h(jMin:jMax,iMax-1),'Or')
title('h near eastern boundary of child grid')

% fig(29);clf;
% plot(grdC.x_rho(:,end-2),grdC.y_rho(:,end-2),'.');
% hold on;
% plot(grdP.x_rho(jMin:jMax,iMax),grdP.y_rho(jMin:jMax,iMax),'O')

%% h on western edge

% make sure there is agreement as to the value of x_rho

grdC.x_rho(20,3)
grdP.x_rho(20,iMin+1)


% fig(21);clf;
% plot(grdC.y_rho(:,end-2),grdC.h(:,end-2));
% 
% fig(22);clf;
% plot(grdP.y_rho(jMin:jMax,iMax),grdP.h(jMin:jMax,iMax))

fig(33);clf;
plot(grdC.y_rho(:,3),grdC.h(:,3),'.');
hold on;
plot(grdP.y_rho(jMin:jMax,iMin+1),grdP.h(jMin:jMax,iMin+1),'O')
title('h near western boundary of child grid')
xlabel('y-rho (m)');ylabel('h (m)')

plot(grdC.y_rho(:,6),grdC.h(:,6),'.r');
hold on;
plot(grdP.y_rho(jMin:jMax,iMin+2),grdP.h(jMin:jMax,iMin+2),'Or')

% fig(29);clf;
% plot(grdC.x_rho(:,end-2),grdC.y_rho(:,end-2),'.');
% hold on;
% plot(grdP.x_rho(jMin:jMax,iMax),grdP.y_rho(jMin:jMax,iMax),'O')

%% h on southern edge

% make sure there is agreement as to the value of x_rho

grdC.y_rho(3,20)
grdP.y_rho(jMin+1,20)


fig(43);clf;
plot(grdC.x_rho(3,:),grdC.h(3,:),'.');
hold on;
plot(grdP.x_rho(jMin+1,iMin:iMax+1),grdP.h(jMin+1,iMin:iMax+1),'O')
title('h near southern boundary of child grid')
xlabel('x-rho (m)');ylabel('h (m)')

plot(grdC.x_rho(6,:),grdC.h(6,:),'.r');
hold on;
plot(grdP.x_rho(jMin+2,iMin:iMax+1),grdP.h(jMin+2,iMin:iMax+1),'Or')


% fig(99);clf;plot(grdP.h(jMin,:));hold on;plot(grdP.h(jMin+1,:),'r');plot(grdP.h(jMin+2,:),'g')

% fig(29);clf;
% plot(grdC.x_rho(:,end-2),grdC.y_rho(:,end-2),'.');
% hold on;
% plot(grdP.x_rho(jMin:jMax,iMax),grdP.y_rho(jMin:jMax,iMax),'O')

%% h on northern edge

% make sure there is agreement as to the value of x_rho

grdC.y_rho(end-2,20)
grdP.y_rho(jMax,20)


fig(53);clf;
plot(grdC.x_rho(end-2,:),grdC.h(end-2,:),'.');
hold on;
plot(grdP.x_rho(jMax,iMin:iMax+1),grdP.h(jMax,iMin:iMax+1),'O')
title('h near northern boundary of child grid')

xlabel('x-rho (m)');ylabel('h (m)')
plot(grdC.x_rho(end-5,:),grdC.h(end-5,:),'.r');
hold on;
plot(grdP.x_rho(jMax-1,iMin:iMax+1),grdP.h(jMax-1,iMin:iMax+1),'Or')

% fig(29);clf;
% plot(grdC.x_rho(:,end-2),grdC.y_rho(:,end-2),'.');
% hold on;
% plot(grdP.x_rho(jMin:jMax,iMax),grdP.y_rho(jMin:jMax,iMax),'O')

%% double check x_rho

[ny,nx] = size(grdC.x_rho);

dumP = grdP.x_rho(jMin+1:jMax,iMin+1:iMax);

dumC = grdC.x_rho(3:3:end-2,3:3:end-2);

myDiff = dumP-dumC;
min(myDiff(:))
max(myDiff(:))

fig(91);clf;
pcolor(dumP - dumC);
shading flat;colorbar
title('(x-rho P) - (x-rho C)')

%% double check y_rho

[ny,nx] = size(grdC.y_rho);

dumP = grdP.y_rho(jMin+1:jMax,iMin+1:iMax);

dumC = grdC.y_rho(3:3:end-2,3:3:end-2);

myDiff = dumP-dumC;
min(myDiff(:))
max(myDiff(:))

fig(92);clf;
pcolor(dumP - dumC);
shading flat;colorbar
title(['(y-rho P) - (y-rho C)'])

%% double check h

[ny,nx] = size(grdC.h);

dumP = grdP.h(jMin+1:jMax,iMin+1:iMax);

dumC = grdC.h(3:3:end-2,3:3:end-2);

myDiff = dumP-dumC;
min(myDiff(:))
max(myDiff(:))

fig(99);clf;
pcolor(dumP - dumC);
shading flat;colorbar
title('h_P - h_C')

%% double check x_psi

[ny,nx] = size(grdC.x_psi);

dumP = grdP.x_psi(jMin:jMax,iMin:iMax);

dumC = grdC.x_psi(1:3:end,1:3:end);

myDiff = dumP-dumC;
min(myDiff(:))
max(myDiff(:))

fig(93);clf;
pcolor(dumP - dumC);
shading flat;colorbar
title('(x-psi P) - (x-psi C)')

%% double check y_psi

[ny,nx] = size(grdC.y_psi);

dumP = grdP.y_psi(jMin:jMax,iMin:iMax);

dumC = grdC.y_psi(1:3:end,1:3:end);

myDiff = dumP-dumC;
min(myDiff(:))
max(myDiff(:))

fig(94);clf;
pcolor(dumP - dumC);
shading flat;colorbar
title('(y-psi P) - (y-psi C)')

%% double check x_u

[ny,nx] = size(grdC.x_u);

dumP = grdP.x_u(jMin+1:jMax,iMin:iMax);
dumC = grdC.x_u(3:3:end,1:3:end);

myDiff = dumP-dumC;
min(myDiff(:))
max(myDiff(:))

fig(95);clf;
pcolor(dumP - dumC);
shading flat;colorbar
title('(x-u P) - (x-u C)')

%% double check y_u

[ny,nx] = size(grdC.y_u);
grdP.y_u(jMin-1:jMin+1,iMin-1:iMin+1)
grdC.y_u(1:4,1:4)

dumP = grdP.y_u(jMin+1:jMax,iMin:iMax);

dumC = grdC.y_u(3:3:end,1:3:end);



myDiff = dumP-dumC;
min(myDiff(:))
max(myDiff(:))

fig(96);clf;
pcolor(dumP - dumC);
shading flat;colorbar
title('(y-u P) - (y-u C)')

%% double check x_v

[ny,nx] = size(grdC.x_v);

dumP = grdP.x_v(jMin:jMax,iMin+1:iMax);
dumC = grdC.x_v(1:3:end,3:3:end);

myDiff = dumP-dumC;
min(myDiff(:))
max(myDiff(:))

fig(97);clf;
pcolor(dumP - dumC);
shading flat;colorbar
title('(x-v P) - (x-v C)')

%% double check y_v

[ny,nx] = size(grdC.y_v);

dumP = grdP.y_v(jMin:jMax,iMin+1:iMax);
dumC = grdC.y_v(1:3:end,3:3:end);

myDiff = dumP-dumC;
min(myDiff(:))
max(myDiff(:))

fig(98);clf;
pcolor(dumP - dumC);
shading flat;colorbar
title('(y-v P) - (y-v C)')


%% Check h on rho grid

fig(202);clf;
plot(grdP.x_rho(jMin+1,iMin:iMax),grdP.h(jMin+1,iMin:iMax),'b')
hold on
plot(grdP.x_rho(jMin+1,iMin:iMax),grdP.h(jMin+1,iMin:iMax),'Ob')
plot(grdC.x_rho(3,:),grdC.h(3,:),'.r');
title('southern edge, h on rho grid, child and parent')

fig(203);clf;
plot(grdP.x_rho(jMax,iMin:iMax),grdP.h(jMax,iMin:iMax),'b')
hold on
plot(grdP.x_rho(jMax,iMin:iMax),grdP.h(jMax,iMin:iMax),'Ob')
plot(grdC.x_rho(end-2,:),grdC.h(end-2,:),'.r');
title('northern edge, h on rho grid, child and parent')

fig(204);clf;
plot(grdP.y_rho(jMin:jMax,iMin+1),grdP.h(jMin:jMax,iMin+1),'b')
hold on
plot(grdP.y_rho(jMin:jMax,iMin+1),grdP.h(jMin:jMax,iMin+1),'Ob')
plot(grdC.y_rho(:,3),grdC.h(:,3),'.r');
title('western edge, h on rho grid, child and parent')

fig(205);clf;
plot(grdP.y_rho(jMin:jMax,iMax),grdP.h(jMin:jMax,iMax),'b')
hold on
plot(grdP.y_rho(jMin:jMax,iMax),grdP.h(jMin:jMax,iMax),'Ob')
plot(grdC.y_rho(:,end-2),grdC.h(:,end-2),'.r');
title('eastern edge, h on rho grid, child and parent')

