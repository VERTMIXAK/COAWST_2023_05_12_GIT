clear;close all;tabwindow


% myDir = 'LJ_500m_2020_001_nesting_twoWay_lotsaWrites/netcdfOutput_bak/';
myDir = './';

parentFile = [myDir,'Lilliput_parent.nc'];
childFile = [myDir,'Lilliput_child.nc'];


hA = nc_varget(parentFile,'h');
lonArho = nc_varget(parentFile,'lon_rho');
latArho = nc_varget(parentFile,'lat_rho');
lonAu = nc_varget(parentFile,'lon_u');
latAu = nc_varget(parentFile,'lat_u');
lonAv = nc_varget(parentFile,'lon_v');
latAv = nc_varget(parentFile,'lat_v');

hB = nc_varget(childFile,'h');
lonBrho = nc_varget(childFile,'lon_rho');
latBrho = nc_varget(childFile,'lat_rho');
lonBu = nc_varget(childFile,'lon_u');
latBu = nc_varget(childFile,'lat_u');
lonBv = nc_varget(childFile,'lon_v');
latBv = nc_varget(childFile,'lat_v');

lonmaxRho = max(lonBrho(:));
lonminRho = min(lonBrho(:));
latmaxRho = max(latBrho(:));
latminRho = min(latBrho(:));

lonmaxU = max(lonBu(:));
lonminU = min(lonBu(:));
latmaxU = max(latBu(:));
latminU = min(latBu(:));

lonmaxV = max(lonBv(:));
lonminV = min(lonBv(:));
latmaxV = max(latBv(:));
latminV = min(latBv(:));



%% Get indices for rho grid

latDelta = latArho - latminRho;
lonDelta = lonArho - lonminRho;
myDist = sqrt( latDelta.^2 + lonDelta.^2 );
[jMin,iMin] = find ( min(myDist(:)) == myDist);

latDelta = latArho - latmaxRho;
lonDelta = lonArho - lonmaxRho;
myDist = sqrt( latDelta.^2 + lonDelta.^2 );
[jMax,iMax] = find ( min(myDist(:)) == myDist);


%% plot h

% delta = .1;

fig(3);clf
pcolor(lonArho,latArho,hA);hold on;%shading faceted
% line([lonminRho lonminRho],[latminRho latmaxRho])
% line([lonmaxRho lonmaxRho],[latminRho latmaxRho])
% line([lonminRho lonmaxRho],[latminRho latminRho])
% line([lonminRho lonmaxRho],[latmaxRho latmaxRho])
title('rho grid a with contact boundary drawn')
daspect([1 1 1])


fig(4);clf
pcolor(lonArho,latArho,hA);%shading faceted
hold on
% line([lonminRho lonminRho],[latminRho latmaxRho])
% line([lonmaxRho lonmaxRho],[latminRho latmaxRho])
% line([lonminRho lonmaxRho],[latminRho latminRho])
% line([lonminRho lonmaxRho],[latmaxRho latmaxRho])
pcolor(lonBrho,latBrho,hB);%shading faceted
colorbar;daspect([1 1 1])
title('rho grid a with grid b overlay; stars are u grid points')

plot(lonAu,latAu,'.k')
plot(lonBu,latBu,'*r')

done('rho')


