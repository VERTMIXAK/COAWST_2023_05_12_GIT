sourceDir = '../Gridpak/';
parentFile = 'lake_jersey_grd_a.nc';
childFile = 'lake_jersey_grd_b.nc';
contactsFile = 'lake_jersey_ngc_2g_ab.nc';

unix('rm *ths.txt *.nc');

unix(['cp ',sourceDir,parentFile,  ' ',parentFile]);
unix(['cp ',sourceDir,childFile,   ' ',childFile]);
unix(['cp ',sourceDir,contactsFile,' ',contactsFile]);


h = nc_varget(parentFile,'h');
[ny,nx] = size(h);

x_rho = nc_varget(parentFile,'x_rho');
y_rho = nc_varget(parentFile,'y_rho');


fig(1);clf;pcolor(hOrig);shading flat


%% Rough out a seamount

% The center of the grid is

xC = round(nx/2.);
yC = round(ny/2.);


a=18 - 15;
% b=0;
b=xC;
c=1000;
% xdum = [xLL:100:];
% myH =  (a) * exp( - (xdum-b).^2 ./ c^2   );
% 
% fig(99);clf;
% plot(myH)
% 
% 
% aaa=5;

%% Update the bathymetry

myYrho = nc_varget(parentFile,'y_rho');
myXrho = nc_varget(parentFile,'x_rho');

dumY = myYrho - myYrho(yC,xC);
dumX = myXrho - myXrho(yC,xC);


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





