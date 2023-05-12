clear; close all;tabwindow;

% grab the parent grid file that has spherical=0 so that pm and pn are
% uniform, then change the spherical flag to 1.
sourceGrid           = '../Gridpak/PRAIRIENest_3km_parent_sphFALSE.nc';
parentFile           = 'PRAIRIENest_3km_parent.nc';
childFile            = 'PRAIRIENest_3km_child.nc';
contactsFile         = 'PRAIRIENest_3km_contacts.nc';

unix(['\rm *ths.txt ',childFile,' ',parentFile,' ',contactsFile]);
unix(['cp ',sourceGrid,' ',parentFile]);
% nc_varput(parentFile,'spherical',1);


aaa=5;

%% Define the core area of my grid

iCoreLL = 101;
iCoreUR = 120;
jCoreLL = 55;
jCoreUR = 88;

% fig(2);clf;pcolor(myLon(jCoreLL:jCoreUR,iCoreLL:iCoreUR),myLat(jCoreLL:jCoreUR,iCoreLL:iCoreUR),h(jCoreLL:jCoreUR,iCoreLL:iCoreUR));shading flat;colorbar


%% create child grid

coarse2fine(parentFile,childFile,3,iCoreLL,iCoreUR,jCoreLL,jCoreUR)

Gnames = {parentFile, childFile}

[S,G] = contact(Gnames,contactsFile)


%% set spherical to 1

nc_varput(parentFile,'spherical',1);
nc_varput(childFile,'spherical',1);