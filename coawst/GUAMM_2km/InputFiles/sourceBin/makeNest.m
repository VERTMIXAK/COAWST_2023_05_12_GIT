clear; close all;tabwindow;


sourceFile = '../Gridpak/LJ_500m.nc';
parentFile = 'test.nc';
childFile = 'test_child.nc';
contactsFile = 'test_contacts.nc';

% unix('rm *ths.txt *.nc');

% unix(['cp ',sourceFile,  ' ',parentFile]);


h = nc_varget(parentFile,'h');
[ny,nx] = size(h);



% fig(1);clf;pcolor(h);shading flat

%% Define the child grid

iMin = 0;
iMax = nx - 2;
jMin = 0;
jMax = ny -2;



%% Make the subgrid

coarse2fine(parentFile,childFile,3,iMin,iMax,jMin,jMax)



%% Make the contacts file

Gnames = {parentFile, childFile}

[S,G] = contact(Gnames,contactsFile)
