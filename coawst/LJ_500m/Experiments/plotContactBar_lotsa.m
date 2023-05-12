clear;close all;tabwindow

myDir = 'LJ_500m_2020_001_nesting_twoWay_lotsaWrites/netcdfOutput_bak/';


parentFile = [myDir,'lj_his_parent_00001.nc'];
parentFile2 = [myDir,'lj_his2_parent_00001.nc'];
childFile = [myDir,'lj_his_child_00001.nc'];
childFile2 = [myDir,'lj_his2_child_00001.nc']


hA = nc_varget(parentFile,'h');
lonaRho = nc_varget(parentFile,'lon_rho');
lataRho = nc_varget(parentFile,'lat_rho');
lonaU = nc_varget(parentFile,'lon_u');
lataU = nc_varget(parentFile,'lat_u');
lonaV = nc_varget(parentFile,'lon_v');
lataV = nc_varget(parentFile,'lat_v');

hB = nc_varget(childFile,'h');
lonbRho = nc_varget(childFile,'lon_rho');
latBrho = nc_varget(childFile,'lat_rho');
lonbU = nc_varget(childFile,'lon_u');
latBu = nc_varget(childFile,'lat_u');
lonBv = nc_varget(childFile,'lon_v');
latBv = nc_varget(childFile,'lat_v');

lonmaxRho = max(lonbRho(:));
lonminRho = min(lonbRho(:));
latmaxRho = max(latBrho(:));
latminRho = min(latBrho(:));

lonmaxU = max(lonbU(:));
lonminU = min(lonbU(:));
latmaxU = max(latBu(:));
latminU = min(latBu(:));

lonmaxV = max(lonBv(:));
lonminV = min(lonBv(:));
latmaxV = max(latBv(:));
latminV = min(latBv(:));

uA = nc_varget(parentFile,'u');
uB = nc_varget(childFile,'u');

vA = nc_varget(parentFile,'v');
vB = nc_varget(childFile,'v');

wA = nc_varget(parentFile,'w');
wB = nc_varget(childFile,'w');

ubarA = nc_varget(parentFile2,'ubar');
ubarB = nc_varget(childFile2,'ubar');

vbarA = nc_varget(parentFile2,'vbar');
vbarB = nc_varget(childFile2,'vbar');


%% Get indices for rho grid

latDelta = lataRho - latminRho;
lonDelta = lonaRho - lonminRho;
myDist = sqrt( latDelta.^2 + lonDelta.^2 );
[jMin,iMin] = find ( min(myDist(:)) == myDist);

latDelta = lataRho - latmaxRho;
lonDelta = lonaRho - lonmaxRho;
myDist = sqrt( latDelta.^2 + lonDelta.^2 );
[jMax,iMax] = find ( min(myDist(:)) == myDist);

lataRho(jMin:jMin+3,iMin:iMin+3);
latBrho(1:5,1:5);


%% plot h

% delta = .1;

fig(3);clf
pcolor(lonaRho,lataRho,hA);hold on
% xlim([lonminRho-delta lonmaxRho+delta]);ylim([latminRho-delta latmaxRho+delta])
% line([lonminRho lonminRho],[latminRho latmaxRho])
% line([lonmaxRho lonmaxRho],[latminRho latmaxRho])
% line([lonminRho lonmaxRho],[latminRho latminRho])
% line([lonminRho lonmaxRho],[latmaxRho latmaxRho])
% caxis([5600 6000]);
% colorbar;title('grid a with contact boundary drawn')
% 
% 
% fig(4);clf
% pcolorjw(lonaRho,lataRho,hA);shading flat
% xlim([lonminRho-delta lonmaxRho+delta]);ylim([latminRho-delta latmaxRho+delta]);
% caxis([5600 6000]);
% hold on
% line([lonminRho lonminRho],[latminRho latmaxRho])
% line([lonmaxRho lonmaxRho],[latminRho latmaxRho])
% line([lonminRho lonmaxRho],[latminRho latminRho])
% line([lonminRho lonmaxRho],[latmaxRho latmaxRho])
% pcolorjw(lonbRho,latBrho,hB);shading flat
% colorbar;title('grid a with grid b overlay')

% done('h')

%% Pick t and plot Ubar on rho background

[ntA,ny,nx] = size(ubarA);
% [ntB,nz,ny,nx] = size(uB);

myTa = 2;
myTb = 4;

delta = .01;

myUbara = sq(ubarA(myTa,:,:));
myUbarb = sq(ubarB(myTb,:,:));
myLim = max(abs(myUbarb(:)));

fig(60);clf
pcolor(lonaU,lataU,myUbara);colorbar
caxis(myLim*[-1 1])

% plot h
fig(61);clf
pcolor(lonaRho,lataRho,hA);
hold on;colorbar
caxis(myLim*[-1 1])

xlim([lonminU-delta lonminU+delta]);ylim([latminU-delta latminU+delta]);

% xlim([lonminU-delta lonminU+delta]);ylim([latminU-delta latminU+delta])

% then add Ubar
pcolor(lonbU,latBu,myUbarb);%shading faceted;
caxis(myLim*[-1 1])

