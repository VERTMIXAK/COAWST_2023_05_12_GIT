clear; close all;tabwindow;

sourceGrid           = '../Gridpak_sphFALSE/PRAIRIENest_3km_sphFALSE_parent.nc';
parentFile           = 'PRAIRIENest_3km_parent.nc';
childFile            = 'PRAIRIENest_3km_child.nc';
contactsFile         = 'PRAIRIENest_3km_contacts.nc';
childTrueFile        = '../Grid_3to1_smallFALSE/PRAIRIENest_3km_child.nc';

unix(['\rm *ths.txt ',childFile,' ',parentFile,' ',contactsFile]);
unix(['cp ',sourceGrid,' ',parentFile]);

aaa=5;

%% Define the core area of my grid

iCoreLL = 101;
iCoreUR = 104;
jCoreLL = 55;
jCoreUR = 57;

% fig(2);clf;pcolor(myLon(jCoreLL:jCoreUR,iCoreLL:iCoreUR),myLat(jCoreLL:jCoreUR,iCoreLL:iCoreUR),h(jCoreLL:jCoreUR,iCoreLL:iCoreUR));shading flat;colorbar


%% create child grid

coarse2fine(parentFile,childFile,3,iCoreLL,iCoreUR,jCoreLL,jCoreUR)

dum = nc_varget(childTrueFile,'lat_rho');
nc_varput(childFile,'lat_rho',dum);
dum = nc_varget(childTrueFile,'lon_rho');
nc_varput(childFile,'lon_rho',dum);

dum = nc_varget(childTrueFile,'lat_psi');
nc_varput(childFile,'lat_psi',dum);
dum = nc_varget(childTrueFile,'lon_psi');
nc_varput(childFile,'lon_psi',dum);

dum = nc_varget(childTrueFile,'lat_u');
nc_varput(childFile,'lat_u',dum);
dum = nc_varget(childTrueFile,'lon_u');
nc_varput(childFile,'lon_u',dum);

dum = nc_varget(childTrueFile,'lat_v');
nc_varput(childFile,'lat_v',dum);
dum = nc_varget(childTrueFile,'lon_v');
nc_varput(childFile,'lon_v',dum);

Gnames = {parentFile, childFile}

[S,G] = contact(Gnames,contactsFile)