gridFile = 'GUAMJinner_1km.nc';

mask_rho = nc_varget(gridFile,'mask_rho');

[ny,nx] = size(mask_rho)

aaa=5;

%% Make the diff_factor array


factorMax = 4500;

factor = ones(ny,nx);
% fig(1);clf; pcolor(factor);shading flat; colorbar

% West
edge = 18;
for ii=1:edge; for jj=1:ny;
    factor(jj,ii) = max(factorMax*((edge-ii) + 1)/edge,factor(jj,ii));
    end;end;
fig(2);clf; pcolor(factor);shading flat; colorbar
%factor(20,1:20)

% East

for ii=1:edge
    factor(:,nx-ii+1) = factor(:,ii);
end;



% South
edge = 6;
for jj=1:edge; for ii=1:nx;
    factor(jj,ii) = max(factorMax*((edge-jj) + 1)/edge,factor(jj,ii));
    end;end;
fig(2);clf; pcolor(factor);shading flat; colorbar
%factor(1:20,20)

% North

for jj=1:edge
    factor(ny-jj+1,:) = factor(jj,:);
end;


% % East
% edge = 15;
% for ii=nx-edge+1:nx; 
%     ii
%     for jj=1:ny;
%     factor(jj,ii) = max(factorMax*(1 - ((nx-edge + 1)-ii)/edge),factor(jj,ii));
%     end;end;
% fig(2);clf; pcolor(factor);shading flat; colorbar
% factor(end-19:end,20)
% 
% % North
% edge = 6;
% for jj=ny-edge+1:ny; for ii=1:nx;
%     factor(jj,ii) = max(factorMax*(1 - ((ny-edge + 1)-jj)/edge),factor(jj,ii));
%     end;end;
% fig(2);clf; pcolor(factor);shading flat; colorbar
% factor(20,end-19:end)


fig(2);clf;pcolor(factor);shading flat; colorbar


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

