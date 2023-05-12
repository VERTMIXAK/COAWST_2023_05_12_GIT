gridFile = 'PALAU_400m.nc';

% The idea is to add the variable rdrag2 to the grid file.
% Just for show, so far as I know.

dum.Name = 'rdrag';
dum.Nctype = 'float';
dum.Dimension = {'eta_rho','xi_rho'};
dum.Attribute = struct('Name',{'long_name','units','coordinates','field'},'Value',{'linear bottom drag coefficient','m/s','eta_rho xi_rho','rdrag, scalar, series'});
nc_addvar(gridFile,dum);

dum.Name = 'rdrag2';
dum.Nctype = 'float';
dum.Dimension = {'eta_rho','xi_rho'};
dum.Attribute = struct('Name',{'long_name','units','coordinates','field'},'Value',{'quadratic bottom drag coefficient','m/s','eta_rho xi_rho','rdrag2, scalar, series'});
nc_addvar(gridFile,dum);