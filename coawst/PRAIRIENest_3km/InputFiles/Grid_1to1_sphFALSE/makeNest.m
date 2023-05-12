clear; close all;tabwindow;

sourceGrid           = '../Gridpak_sphFALSE/PRAIRIENest_3km_sphFALSE_parent.nc';
parentFile           = 'PRAIRIENest_3km_parent.nc';
childFile            = 'PRAIRIENest_3km_child.nc';
contactsFile         = 'PRAIRIENest_3km_contacts.nc';

unix(['\rm *ths.txt ',childFile,' ',parentFile,' ',contactsFile])
unix(['cp ',sourceGrid,' ',parentFile])

aaa=5;

%% Define the core area of my grid

iCoreLL = 101;
iCoreUR = 120;
jCoreLL = 55;
jCoreUR = 88;

% fig(2);clf;pcolor(myLon(jCoreLL:jCoreUR,iCoreLL:iCoreUR),myLat(jCoreLL:jCoreUR,iCoreLL:iCoreUR),h(jCoreLL:jCoreUR,iCoreLL:iCoreUR));shading flat;colorbar


%% create child grid

coarse2fine(parentFile,childFile,1,iCoreLL,iCoreUR,jCoreLL,jCoreUR)

Gnames = {parentFile, childFile}

[S,G] = contact(Gnames,contactsFile)