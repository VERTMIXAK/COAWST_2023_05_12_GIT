oldFile = 'GUAMKinner_1km.nc';
newFile = 'GUAMKinnerNest_1km.nc';

myLat = nc_varget(oldFile,'lat_psi');
myLon = nc_varget(oldFile,'lon_psi');

mask = nc_varget(oldFile,'mask_psi');


%% Define the core area of my grid

latLL = 13.8;
lonLL = 144.8;
dumLat = myLat - latLL;
dumLon = myLon - lonLL;
myDist = sqrt( dumLat.^2 + dumLon.^2);
[jCoreLL,iCoreLL] = find( min(myDist(:)) == myDist)
[myLat(jCoreLL,iCoreLL) - latLL,myLon(jCoreLL,iCoreLL) - lonLL]*111

%latUR = 15.7636785507202;  
latUR = 14.5; 
lonUR = 145.5; 
dumLat = myLat - latUR;
dumLon = myLon - lonUR;
myDist = sqrt( dumLat.^2 + dumLon.^2);
[jCoreUR,iCoreUR] = find( min(myDist(:)) == myDist)
[myLat(jCoreUR,iCoreUR) - latUR,myLon(jCoreUR,iCoreUR) - lonUR]*111

fig(1);clf;pcolor(mask(jCoreLL:jCoreUR,iCoreLL:iCoreUR));shading flat

%% Make the subgrid

coarse2fine(oldFile,newFile,3,iCoreLL,iCoreUR,jCoreLL,jCoreUR)


%% Make the contacts file

sourceGrids = [oldFile newFile];

