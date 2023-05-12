clear; close all


gridFile = '../Gridpak/NG_100m.nc';
jraFile  = 'USGS_NG_rivers_2020.nc';

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

fig(12);clf
pcolor(iRange,jRange,abs(rivMat(jRange,iRange)));shading flat;colorbar
xlim([440 460]);ylim([790 810])
hold on;
plot(myI,myJ)


%%
fig(10);clf;

[~,b]=find(sq(abs(flow(1,:)))>0)
plot(myI,myJ)
hold on
plot(myI(b),myJ(b),'.r')

