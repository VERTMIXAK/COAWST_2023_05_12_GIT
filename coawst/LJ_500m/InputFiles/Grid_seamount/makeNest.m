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


%% Rough out a seamount

% The center of the seamount

iC = iMax;
jC = round( (jMin + jMax) /2.);

xC = x_psi(jC,iC);
yC = y_psi(jC,iC);

% what follow are parameters quantifying the shape of the peak
xWidth = xmax - xmin
yWidth = ymax - ymin

a=20 - 15;
% b=0;
b=xC;
c=1000;
xdum = [ymin:100:ymax];
myH =  (a) * exp( - (xdum-b).^2 ./ c^2   );

fig(99);clf;
plot(myH)


aaa=5;

%% Update the bathymetry

h = nc_varget(parentFile,'h');
[ny,nx] = size(h)

myYrho = nc_varget(parentFile,'y_rho');
myXrho = nc_varget(parentFile,'x_rho');

dumY = myYrho - yC;
dumX = myXrho - xC;


hdum = h;
rmat = h;

for ii=1:nx; for jj=1:ny    
    r = sqrt( (dumX(jj,ii))^2 + (dumY(jj,ii))^2 );
    rmat(jj,ii) = r;
    hdum(jj,ii) = 20 - a * exp( - (r)^2 / c^2 );
end;end;
fig(5);clf;
pcolor(rmat);shading flat;colorbar
fig(6);clf;
pcolor(hdum);shading flat;colorbar

nc_varput(parentFile,'h',hdum);

aaa=5;

%% Make the subgrid

coarse2fine(parentFile,childFile,3,iMin,iMax,jMin,jMax)



%% Make the contacts file

Gnames = {parentFile, childFile}

[S,G] = contact(Gnames,contactsFile)
