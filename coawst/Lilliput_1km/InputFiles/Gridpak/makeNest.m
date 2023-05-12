sourceFile   = 'Lilliput.nc';
parentFile   = 'Lilliput_parent.nc';
childFile    = 'Lilliput_child.nc';
contactsFile = 'Lilliput_contacts.nc';

unix(['cp ',sourceFile,' ',parentFile]);

myLat = nc_varget(parentFile,'lat_psi');
myLon = nc_varget(parentFile,'lon_psi');


%% Define the core area of my grid

iCoreLL = 3;
iCoreUR = 6;
jCoreLL = 2;
jCoreUR = 4;

%% Make the subgrid

coarse2fine(parentFile,childFile,3,iCoreLL,iCoreUR,jCoreLL,jCoreUR)


%% Make the contacts file

sourceGrids = [parentFile,childFile];

