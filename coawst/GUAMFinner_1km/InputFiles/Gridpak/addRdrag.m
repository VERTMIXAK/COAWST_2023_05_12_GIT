gridFile = 'GUAMFinner_1km_seamount2.nc';

visc = nc_varget(gridFile,'mask_rho');

[ny,nx] = size(visc)

aaa=5;

% The idea is to add the variable rdrag2 to the grid file.
% Just for show, so far as I know.

dum.Name = 'visc_factor';
dum.Nctype = 'float';
dum.Dimension = {'eta_rho','xi_rho'};
dum.Attribute = struct('Name',{'long_name','units','coordinates','field'},'Value',{'linear bottom drag coefficient','m/s','eta_rho xi_rho','visc_factor, scalar, series'});
nc_addvar(gridFile,dum);



% dum.Name = 'rdrag';
% dum.Nctype = 'float';
% dum.Dimension = {'eta_rho','xi_rho'};
% dum.Attribute = struct('Name',{'long_name','units','coordinates','field'},'Value',{'linear bottom drag coefficient','m/s','eta_rho xi_rho','rdrag, scalar, series'});
% nc_addvar(gridFile,dum);

% dum.Name = 'rdrag2';
% dum.Nctype = 'float';
% dum.Dimension = {'eta_rho','xi_rho'};
% dum.Attribute = struct('Name',{'long_name','units','coordinates','field'},'Value',{'quadratic bottom drag coefficient','m/s','eta_rho xi_rho','rdrag2, scalar, series'});
% nc_addvar(gridFile,dum);