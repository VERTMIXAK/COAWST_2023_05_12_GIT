gridFile = 'GUAMFinner_1km_seamount2.nc';

diff = nc_varget(gridFile,'mask_rho');

[ny,nx] = size(diff)

aaa=5;

%% Make the diff_factor array

edge = 10;
factorMax = 5;

factor = ones(ny,nx);
fig(1);clf; pcolor(factor);shading flat; colorbar

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



%%



dum.Name = 'diff_factor';
dum.Nctype = 'float';
dum.Dimension = {'eta_rho','xi_rho'};
dum.Attribute = struct('Name',{'long_name','units','coordinates','field'},'Value',{'diffusion spatial scaling factor','m/s','eta_rho xi_rho','diff_factor, scalar, series'});
nc_addvar(gridFile,dum);

nc_varput(gridFile,'diff_factor',factor);

