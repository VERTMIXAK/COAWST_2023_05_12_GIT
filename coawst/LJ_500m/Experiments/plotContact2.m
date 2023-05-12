clear;close all;tabwindow

myDir = 'LJ_500m_2020_001_nesting_oneWay_lotsaWrites/netcdfOutput_bak/';


parentFile = [myDir,'lj_his_parent_00001.nc'];
parentFile2 = [myDir,'lj_his2_parent_00001.nc'];
childFile = [myDir,'lj_his_child_00001.nc'];
childFile2 = [myDir,'lj_his2_child_00001.nc']


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

latDelta = latArho - latminRho;
lonDelta = lonArho - lonminRho;
myDist = sqrt( latDelta.^2 + lonDelta.^2 );
[jMin,iMin] = find ( min(myDist(:)) == myDist);

latDelta = latArho - latmaxRho;
lonDelta = lonArho - lonmaxRho;
myDist = sqrt( latDelta.^2 + lonDelta.^2 );
[jMax,iMax] = find ( min(myDist(:)) == myDist);

latArho(jMin:jMin+3,iMin:iMin+3);
latBrho(1:5,1:5);


%% plot h

% delta = .1;

% fig(3);clf
% pcolorjw(lonArho,latArho,hA);shading flat;hold on
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
% pcolorjw(lonArho,latArho,hA);shading flat
% xlim([lonminRho-delta lonmaxRho+delta]);ylim([latminRho-delta latmaxRho+delta]);
% caxis([5600 6000]);
% hold on
% line([lonminRho lonminRho],[latminRho latmaxRho])
% line([lonmaxRho lonmaxRho],[latminRho latmaxRho])
% line([lonminRho lonmaxRho],[latminRho latminRho])
% line([lonminRho lonmaxRho],[latmaxRho latmaxRho])
% pcolorjw(lonBrho,latBrho,hB);shading flat
% colorbar;title('grid a with grid b overlay')

% done('h')

%% Pick t and z and plot U

[ntA,nz,ny,nx] = size(uA);
% [ntB,nz,ny,nx] = size(uB);

myTa = 2;
myTb = 4;
myZ = nz;

delta = .05;


% plot U

myUa = sq(uA(myTa,myZ,:,:));
myUb = sq(uB(myTb,myZ,:,:));
myLim = max(abs(myUb(:)));

fig(10);clf;
pcolorjw(lonAu,latAu,myUa);shading flat;colorbar
xlim([lonminU-delta lonmaxU+delta]);ylim([latminU-delta latmaxU+delta]);
caxis(myLim * [-1 1]);
title(['u on A grid, nz = ',num2str(myZ),'  nt = ',num2str(myTa)])
hold on
line([lonminU lonminU],[latminU latmaxU])
line([lonmaxU lonmaxU],[latminU latmaxU])
line([lonminU lonmaxU],[latminU latminU])
line([lonminU lonmaxU],[latmaxU latmaxU])

fig(11);clf;
pcolorjw(lonAu,latAu,myUa);shading flat;colorbar
xlim([lonminU-delta lonmaxU+delta]);ylim([latminU-delta latmaxU+delta]);
caxis(myLim*[-1 1]);
title(['u on A grid with u on B grid overlay, nz = ',num2str(myZ),'  ntA = ',num2str(myTa),'  ntB = ',num2str(myTb)])
hold on
line([lonminU lonminU],[latminU latmaxU])
line([lonmaxU lonmaxU],[latminU latmaxU])
line([lonminU lonmaxU],[latminU latminU])
line([lonminU lonmaxU],[latmaxU latmaxU])
pcolorjw(lonBu,latBu,myUb);shading flat

fig(12);clf;
pcolorjw(lonBu,latBu,myUb);shading flat;colorbar
caxis(myLim*[-1 1]);
title(['u on B grid, nz = ',num2str(myZ),'  ntA = ',num2str(myTa),'  ntB = ',num2str(myTb)])


myLim = max(abs(myUa(:)))/1;
% myMax = max(myUa(:))/1;
% myMin = min(myUa(:))/1;
fig(13);clf;
pcolorjw(lonAu,latAu,myUa);shading flat;colorbar
caxis(myLim*[-1 1]);
title(['u on A grid, nz = ',num2str(myZ),'  ntA = ',num2str(myTa),'  ntB = ',num2str(myTb)])

fig(15);clf;
plot(myUa(20,:));hold on
plot(myUa(20,:),'.')

fig(16);clf;
pcolorjw(sq(uA(myTa,:,:,10)));shading flat;colorbar

fig(17);clf;
plot(sq(ubarA(myTa,:,10)));shading flat;colorbar
hold on
plot(sq(ubarA(myTa,:,10)),'.');shading flat;colorbar

dum = sq(uA(myTa,:,:,10));
for jj=1:ny
    dum(:,jj) = dum(:,jj) - sq(ubarA(myTa,jj,10));
end
fig(18);clf;
pcolorjw(dum);shading flat;colorbar



done('u')


%% plot V

pwd
[ntA,nz,ny,nx] = size(vA);
[ntB,nz,ny,nx] = size(vB);

myVa = sq(vA(myTa,myZ,:,:));
myVb = sq(vB(myTb,myZ,:,:));
myLim = max(abs(myVb(:)));

fig(20);clf;
pcolorjw(lonAv,latAv,myVa);shading flat;colorbar
xlim([lonminV-delta lonmaxV+delta]);ylim([latminV-delta latmaxV+delta]);
caxis(myLim * [-1 1]);
title(['v on A grid, nz = ',num2str(myZ),'  nt = ',num2str(myTa)])
hold on
line([lonminV lonminV],[latminV latmaxV])
line([lonmaxV lonmaxV],[latminV latmaxV])
line([lonminV lonmaxV],[latminV latminV])
line([lonminV lonmaxV],[latmaxV latmaxV])

fig(21);clf;
pcolorjw(lonAv,latAv,myVa);shading flat;colorbar
xlim([lonminV-delta lonmaxV+delta]);ylim([latminV-delta latmaxV+delta]);
caxis(myLim*[-1 1]);
title(['u on A grid with v on B grid overlay, nz = ',num2str(myZ),'  ntA = ',num2str(myTa),'  ntB = ',num2str(myTb)])
hold on
line([lonminV lonminV],[latminV latmaxV])
line([lonmaxV lonmaxV],[latminV latmaxV])
line([lonminV lonmaxV],[latminV latminV])
line([lonminV lonmaxV],[latmaxV latmaxV])
pcolorjw(lonBv,latBv,myVb);shading flat

fig(22);clf;
pcolorjw(lonBv,latBv,myVb);shading flat;colorbar
caxis(myLim*[-1 1]);
title(['v on B grid, nz = ',num2str(myZ),'  ntA = ',num2str(myTa),'  ntB = ',num2str(myTb)])


myLim = max(abs(myVa(:)))/1;
% myMax = max(myUa(:))/1;
% myMin = min(myUa(:))/1;
fig(23);clf;
pcolorjw(lonAv,latAv,myVa);shading flat;colorbar
caxis(myLim*[-1 1]);
title(['v on A grid, nz = ',num2str(myZ),'  ntA = ',num2str(myTa),'  ntB = ',num2str(myTb)])



fig(25);plot(myVa(:,20),'.');hold on
fig(25);plot(myVa(:,20))

done('v')



