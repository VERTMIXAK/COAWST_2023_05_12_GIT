clear; close all;tabwindow;

parentFile = 'PRAIRIEinner_1km.nc';
childFile = 'PRAIRIEinnerNest_1km.nc';
contactsFile = 'PRAIRIEinnerNest_contacts_1km.nc';

myLon = nc_varget(parentFile,'lon_psi');
myLat = nc_varget(parentFile,'lat_psi');

mask = nc_varget(parentFile,'mask_psi');


%% Define the core area of my grid

latLL = 11.;
lonLL = 153;

latDelta = myLat - latLL;
lonDelta = myLon - lonLL;
myDist = sqrt( latDelta.^2 + lonDelta.^2);
[jCoreLL,iCoreLL] = find( min(myDist(:)) == myDist)
[myLat(jCoreLL,iCoreLL) - latLL,myLon(jCoreLL,iCoreLL) - lonLL]

 

% latUR = 11.9; 
% lonUR = 153.5;
latUR = 11.1; 
lonUR = 153.05;
dumY = myLat - latUR;
dumX = myLon - lonUR;
myDist = sqrt( dumY.^2 + dumX.^2);
[jCoreUR,iCoreUR] = find( min(myDist(:)) == myDist)
[myLat(jCoreUR,iCoreUR) - latUR,myLon(jCoreUR,iCoreUR) - lonUR]*111

fig(1);clf;pcolor(myLon(jCoreLL:jCoreUR,iCoreLL:iCoreUR),myLat(jCoreLL:jCoreUR,iCoreLL:iCoreUR),mask(jCoreLL:jCoreUR,iCoreLL:iCoreUR));shading flat

%% Make the subgrid

coarse2fine(parentFile,childFile,3,iCoreLL,iCoreUR,jCoreLL,jCoreUR)


%% Make the contacts file

Gnames = {parentFile, childFile}

[S,G] = contact(Gnames,contactsFile)


%% plot bathymetry

hParent    = nc_varget(parentFile,'h');
lonParent  = nc_varget(parentFile,'lon_rho');
latParent  = nc_varget(parentFile,'lat_rho');
maskParent = nc_varget(parentFile,'mask_rho');

hChild    = nc_varget(childFile,'h');
lonChild  = nc_varget(childFile,'lon_rho');
latChild  = nc_varget(childFile,'lat_rho');
maskChild = nc_varget(childFile,'mask_rho');


maxH =  max(hChild(:));
maxH = 3000;

% fig(10);clf;
% pcolor(lonChild,latChild,hChild);shading flat;colorbar;
% caxis([0 maxH]);



fig(11); clf
deltaLon = .25;
deltaLat = .25;
pcolor(lonParent,latParent,hParent);shading flat;
ylim([latLL-deltaLat latUR+deltaLat]);
xlim([lonLL-deltaLon lonUR+deltaLon]);
caxis([0 maxH]);
hold on;
pcolor(lonChild,latChild,hChild);shading flat;
line([lonLL lonUR],[latLL latLL]);
line([lonLL lonUR],[latUR latUR]);
line([lonLL lonLL],[latLL latUR]);
line([lonUR lonUR],[latLL latUR]);
title('parent plus child')



fig(12);clf;
pcolor(lonParent,latParent,hParent);shading flat;
ylim([latLL-deltaLat latUR+deltaLat]);
xlim([lonLL-deltaLon lonUR+deltaLon]);
caxis([0 maxH]);
title('parent only')


error('simple exit');


%% debug h for sub grid

min(hChild(:))
[j,i] =find( min(hChild(:)) == hChild  );
mask = nc_varget(childFile,'mask_rho');

fig(90);clf
pcolor(mask);shading flat;colorbar

latNeg = latChild(j,i)
lonNeg = lonChild(j,i)

latDelta = latParent - latNeg;
lonDelta = lonParent - lonNeg;
myDist = sqrt( latDelta.^2 + lonDelta.^2);
[jCoreLL,iCoreLL] = find( min(myDist(:)) == myDist)
[latParent(jCoreLL,iCoreLL) - latNeg,lonParent(jCoreLL,iCoreLL) - lonNeg]

% fig(91);clf;
% plot(lonParent(jCoreLL,:),hParent(jCoreLL,:))

fig(91);clf;
plot(hParent(jCoreLL,:))


fig(92);clf;
plot(lonChild(j,:),hChild(j,:));hold on
plot(lonParent(jCoreLL,225:350),hParent(jCoreLL,225:350),'r')


minH = min(hParent(:));
hChild(maskChild == 0 ) = minH;

fig(93);clf;
plot(lonChild(j,:),hChild(j,:));hold on
plot(lonParent(jCoreLL,225:350),hParent(jCoreLL,225:350),'r')

nc_varput(childFile,'h',hChild);


%%


fig(50);clf
pcolorjw(lonParent,latParent,hParent);shading flat;colorbar
hold on
plot([min(lonChild(:)) max(lonChild(:)) ],[min(latChild(:)) min(latChild(:)) ] )
plot([min(lonChild(:)) max(lonChild(:)) ],[max(latChild(:)) max(latChild(:)) ] )
plot([min(lonChild(:)) min(lonChild(:)) ],[min(latChild(:)) max(latChild(:)) ] )
plot([max(lonChild(:)) max(lonChild(:)) ],[min(latChild(:)) max(latChild(:)) ] )

fig(51);clf
pcolorjw(lonChild,latChild,hChild);shading flat;colorbar









