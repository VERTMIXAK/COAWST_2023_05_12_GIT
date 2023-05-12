clear; close all;tabwindow;


sourceFile = '../Gridpak/LJ_500m.nc';
parentFile = 'LJ_500m_parent.nc';
childFile = 'LJ_500m_child.nc';
contactsFile = 'LJ_500m_contacts.nc';

unix('rm *ths.txt *.nc');

unix(['cp ',sourceFile,  ' ',parentFile]);


h = nc_varget(parentFile,'h');
[ny,nx] = size(h);

x_psi = nc_varget(parentFile,'x_psi');
y_psi = nc_varget(parentFile,'y_psi');


% fig(1);clf;pcolor(h);shading flat

%% Define the child grid

% these are the extrema on the distro child grid

xmin = 4000;
xmax = 15000;
ymin = 5500;
ymax = 22000;

% iMin = 9;
% iMax = 31;
% jMin = 12;
% jMax = 45;

[~,iMin] = find(x_psi == xmin)
[~,iMax] = find(x_psi == xmax)
[jMin,~] = find(y_psi == ymin)
[jMax,~] = find(y_psi == ymax)


%% Make the subgrid

coarse2fine(parentFile,childFile,3,iMin,iMax,jMin,jMax)



%% Make the contacts file

Gnames = {parentFile, childFile}

[S,G] = contact(Gnames,contactsFile)
