clear; close all;tabwindow;

sourceGrid           = '../Gridpak_sphTRUE/PRAIRIENest_3km_sphTRUE_parent.nc';
parentFile           = 'PRAIRIENest_3km_parent.nc';
childFile            = 'PRAIRIENest_3km_child.nc';
contactsFile         = 'PRAIRIENest_3km_contacts.nc';
childTrueFile        = '../Grid_3to1_smallTRUE/PRAIRIENest_3km_child.nc';

unix(['\rm *ths.txt ',childFile,' ',parentFile,' ',contactsFile]);
unix(['cp ',sourceGrid,' ',parentFile]);

aaa=5;

%% Define the core area of my grid

iCoreLL = 101;
iCoreUR = 103;
jCoreLL = 55;
jCoreUR = 56;

% fig(2);clf;pcolor(myLon(jCoreLL:jCoreUR,iCoreLL:iCoreUR),myLat(jCoreLL:jCoreUR,iCoreLL:iCoreUR),h(jCoreLL:jCoreUR,iCoreLL:iCoreUR));shading flat;colorbar


%% create child grid

coarse2fine(parentFile,childFile,3,iCoreLL,iCoreUR,jCoreLL,jCoreUR)

Gnames = {parentFile, childFile}

[S,G] = contact(Gnames,contactsFile)