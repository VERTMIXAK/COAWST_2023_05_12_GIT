clear; close all


gridFile = '../Gridpak/NG_100m.nc';
jraFile  = 'JRA-1.4_NG_rivers_2018.nc';

lat = nc_varget(gridFile,'lat_rho');
lon = nc_varget(gridFile,'lon_rho');

myI = nc_varget(jraFile,'river_Xposition');
myJ = nc_varget(jraFile,'river_Eposition');
flow = nc_varget(jraFile,'river_transport');

myN = length(myI);

% fig(1);clf;
% plot(myI,myJ)

[ny,nx] = size(lon)

rivMat = zeros(ny,nx);
myTime = 1;

for nn=1:myN
	rivMat(myJ(nn),myI(nn)) = flow(1,nn);
end;


iRange=[1:nx];
jRange=[1:ny];
fig(2);clf
pcolor(iRange,jRange,abs(rivMat(jRange,iRange)));shading flat;colorbar
hold on;
plot(myI,myJ)
caxis([0 .05])

fig(12);clf
pcolor(iRange,jRange,abs(rivMat(jRange,iRange)));shading flat;colorbar
xlim([150 300]);ylim([300 600])
hold on;
plot(myI,myJ)
caxis([0 .05])

fig(13);clf
pcolor(iRange,jRange,abs(rivMat(jRange,iRange)));shading flat;colorbar
xlim([375 500]);ylim([475 600])
hold on;
plot(myI,myJ)
caxis([0 .05])

