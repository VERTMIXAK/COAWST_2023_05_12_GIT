gridFile = 'GUAMGinner_1km_seamount.nc';

mask_rho = nc_varget(gridFile,'mask_rho');

[ny,nx] = size(mask_rho)

aaa=5;

%% Make the diff_factor array

edge = 12;
factorMax = 100;

factor = ones(ny,nx);
% fig(1);clf; pcolor(factor);shading flat; colorbar

for ii=1:edge; for jj=1:ny;
    factor(jj,ii) = max(factorMax*((edge-ii) + 1),factor(jj,ii));
    end;end;
fig(2);clf; pcolor(factor);shading flat; colorbar

for jj=1:edge; for ii=1:nx;
    factor(jj,ii) = max(factorMax*((edge-jj) + 1),factor(jj,ii));
    end;end;
fig(2);clf; pcolor(factor);shading flat; colorbar

for ii=nx-edge+1:nx; for jj=1:ny;
    factor(jj,ii) = max(factorMax*(1 - ((nx-edge + 1)-ii)),factor(jj,ii));
    end;end;
fig(2);clf; pcolor(factor);shading flat; colorbar


for jj=ny-edge+1:ny; for ii=1:nx;
    factor(jj,ii) = max(factorMax*(1 - ((ny-edge + 1)-jj)),factor(jj,ii));
    end;end;
fig(2);clf; pcolor(factor);shading flat; colorbar

aaa=5;

%% Write to file

% Note that if the fields are already there then the addvar stuff crashes

dum.Name = 'visc_factor'; 
dum.Nctype = 'float'; 
dum.Dimension ={'eta_rho','xi_rho'}; 
dum.Attribute =struct('Name',{'long_name','units','coordinates','field'},'Value',{'linearbottom drag coefficient','m/s','eta_rho xi_rho','visc_factor, scalar,series'}); 
nc_addvar(gridFile,dum);

dum.Name = 'diff_factor'; 
dum.Nctype = 'float'; 
dum.Dimension ={'eta_rho','xi_rho'}; 
dum.Attribute =struct('Name',{'long_name','units','coordinates','field'},'Value',{'diffusionspatial scaling factor','m/s','eta_rho xi_rho','diff_factor, scalar,series'}); 
nc_addvar(gridFile,dum);

nc_varput(gridFile,'diff_factor',factor);
nc_varput(gridFile,'visc_factor',factor);

