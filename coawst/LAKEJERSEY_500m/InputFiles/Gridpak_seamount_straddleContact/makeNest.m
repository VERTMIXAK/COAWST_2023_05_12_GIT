sourceFile = '../Gridpak/lake_jersey_grd_a.nc';
parentFile = 'lake_jersey_grd_a.nc';
childFile = 'lake_jersey_grd_b.nc';
contactsFile = 'lake_jersey_ngc_2g_ab.nc';

unix('rm *ths.txt *.nc');

unix(['cp ',sourceFile,' ',parentFile]);


myY = nc_varget(parentFile,'y_psi');
myX = nc_varget(parentFile,'x_psi');

mask = nc_varget(parentFile,'mask_psi');


%% Define the core area of my grid

yLL = 5500;
xLL = 4000;
dumY = myY - yLL;
dumX = myX - xLL;
myDist = sqrt( dumY.^2 + dumX.^2);
[jCoreLL,iCoreLL] = find( min(myDist(:)) == myDist)
[myY(jCoreLL,iCoreLL) - yLL,myX(jCoreLL,iCoreLL) - xLL]

 
yUR = 22000; 
xUR = 15000; 
dumY = myY - yUR;
dumX = myX - xUR;
myDist = sqrt( dumY.^2 + dumX.^2);
[jCoreUR,iCoreUR] = find( min(myDist(:)) == myDist)
[myY(jCoreUR,iCoreUR) - yUR,myX(jCoreUR,iCoreUR) - xUR]*111

fig(1);clf;pcolor(mask(jCoreLL:jCoreUR,iCoreLL:iCoreUR));shading flat


%% Rough out a seamount

% The center of the grid is

% xC = (xUR + xLL)/2.
xC = xUR
yC = (yUR + yLL)/2.

xWidth = xUR - xLL
yWidth = yUR - yLL

a=18 - 15;
% b=0;
b=xC;
c=1000;
xdum = [xLL:100:xUR];
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
    hdum(jj,ii) = 18 - a * exp( - (r)^2 / c^2 );
end;end;
fig(5);clf;
pcolor(rmat);shading flat;colorbar
fig(6);clf;
pcolor(hdum);shading flat;colorbar

nc_varput(parentFile,'h',hdum);


%% Make the subgrid

coarse2fine(parentFile,childFile,3,iCoreLL,iCoreUR,jCoreLL,jCoreUR)


%% Make the contacts file

Gnames = {parentFile, childFile}

[S,G] = contact(Gnames,contactsFile)






