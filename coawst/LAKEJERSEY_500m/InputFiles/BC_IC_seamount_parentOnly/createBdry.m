clear; close all;tabwindow;

sourceFile = 'ini_a/lake_jersey_ini_a.nc';
bdryFile   = 'lake_jersey_bdry_a.nc';

unix(['cp ',sourceFile,' ',bdryFile]);

s_rho   = 8;
s_w     = 9;
eta_rho = 82;
eta_psi = 81;
eta_u   = 82;
eta_v   = 81;
xi_rho  = 102;
xi_psi  = 101;
xi_u    = 101;
xi_v    = 102;



% I'm going to try adding the edge fields to the ini file




%% zeta_west

dum.Name = 'zeta_west';
dum.Nctype = 'double';
dum.Dimension = {'ocean_time','eta_rho'};
dum.Attribute = struct('Name',{'long_name','units','field'},'Value',{'free-surface west boundary condition','meter','zeta_west, scalar, series'});
nc_addvar(bdryFile,dum);

temp = zeros(1,eta_rho);
nc_varput(bdryFile,'zeta_west',temp);


%% ubar_west

dum.Name = 'ubar_west';
dum.Nctype = 'double';
dum.Dimension = {'ocean_time','eta_u'};
dum.Attribute = struct('Name',{'long_name','units','time','coordinates','field'},'Value',        ...
           {'vertically integrated u-momentum component',       ...
           'meter second-1',                                    ...
           'ocean_time',                                        ...
           'y_u ocean_time',                                ...
           'ubar-velocity, scalar, series'});
nc_addvar(bdryFile,dum);

temp = zeros(1,eta_u);
nc_varput(bdryFile,'ubar_west',temp);

%% vbar_west

dum.Name = 'vbar_west';
dum.Nctype = 'double';
dum.Dimension = {'ocean_time','eta_v'};
dum.Attribute = struct('Name',{'long_name','units','time','coordinates','field'},'Value',        ...
           {'vertically integrated v-momentum component',       ...
           'meter second-1',                                    ...
           'ocean_time',                                        ...
           'y_u ocean_time',                                ...
           'vbar-velocity, scalar, series'});
nc_addvar(bdryFile,dum);

temp = zeros(1,eta_v);
nc_varput(bdryFile,'vbar_west',temp);

%% u_west

dum.Name = 'u_west';
dum.Nctype = 'double';
dum.Dimension = {'ocean_time','s_rho','eta_u'};
dum.Attribute = struct('Name',{'long_name','units','time','field'},'Value',        ...
           {'3D u-momentum west boundary condition',       ...
           'meter second-1',                                    ...
           'ocean_time',                                    ...
           'u_west, scalar, series'});
nc_addvar(bdryFile,dum);

temp = zeros(1,s_rho,eta_u);
nc_varput(bdryFile,'u_west',temp);


aaa=5;

%% v_west

dum.Name = 'v_west';
dum.Nctype = 'double';
dum.Dimension = {'ocean_time','s_rho','eta_v'};
dum.Attribute = struct('Name',{'long_name','units','time','field'},'Value',        ...
           {'3D v-momentum west boundary condition',       ...
           'meter second-1',                                    ...
           'ocean_time',                                    ...
           'v_west, scalar, series'});
nc_addvar(bdryFile,dum);

temp = zeros(1,s_rho,eta_v);
nc_varput(bdryFile,'v_west',temp);


aaa=5;

%% temp_west

dum.Name = 'temp_west';
dum.Nctype = 'double';
dum.Dimension = {'ocean_time','s_rho','eta_rho'};
dum.Attribute = struct('Name',{'long_name','units','time','field'},'Value',        ...
           {'potential temperature west boundary condition',       ...
           'Celsius',                                    ...
           'ocean_time',                                    ...
           'temp_west, scalar, series'});
nc_addvar(bdryFile,dum);

dumVar = nc_varget(sourceFile,'temp');
temp = zeros(1,s_rho,eta_rho);
temp(1,:,:)   = sq(dumVar(:,:,10));
temp(1,:,1)   = sq(temp(1,:,10));
temp(1,:,end) = sq(temp(1,:,10));

nc_varput(bdryFile,'temp_west',temp);


aaa=5;

%% salt_west

dum.Name = 'salt_west';
dum.Nctype = 'double';
dum.Dimension = {'ocean_time','s_rho','eta_rho'};
dum.Attribute = struct('Name',{'long_name','units','time','field'},'Value',        ...
           {'potential temperature west boundary condition',       ...
           'PSU',                                    ...
           'ocean_time',                                    ...
           'salt_west, scalar, series'});
nc_addvar(bdryFile,dum);

dumVar = nc_varget(sourceFile,'salt');
temp = zeros(1,s_rho,eta_rho);
temp(1,:,:) = sq(dumVar(:,:,10));
nc_varput(bdryFile,'salt_west',temp);


aaa=5;

%%

unix(['/bin/bash makeDupes.bash']);

for tt = 10:99
    name = ['tStamp_',num2str(tt),'.nc']
    time = 2400 * (tt - 10)
    nc_varput(name,'ocean_time',time);
end

unix(['\rm ',bdryFile]);
unix(['ncrcat tStamp* ',bdryFile]);
unix('\rm tS*');






