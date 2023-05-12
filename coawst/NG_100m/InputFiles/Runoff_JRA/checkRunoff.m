close all

runoffFile = 'NG_runoff_2018.nc';
gridFile = '../Gridpak/NG_100m.nc';

friver = nc_varget(runoffFile,'friver');
lat = nc_varget(runoffFile,'lat');
lon = nc_varget(runoffFile,'lon');
pn = nc_varget(gridFile,'pn');
pm = nc_varget(gridFile,'pm');
size(friver)


aaa=5;


% fig(1);clf;
% pcolor(sq(friver(1,:,:)));shading flat
% xlim([1155 1165]);
% ylim([525 530]);
% caxis([0 .001])

% jRange = [524:528];
% iRange = [1153:1157];
% fig(2);clf;
% pcolor(lon(iRange),lat(jRange),sq(friver(1,jRange,iRange)));shading flat
% colorbar

% The dominant pixel is at
myI = 453;
myJ = 800;

Area = 1 / ( pn(myJ,myI) * pm(myJ,myI) )

friver(1,:,:);nansum(ans(:))
ans*Area

% friver(1,myJ,myI) * Area

