newFile = 'riverSource.nc';

gridFile = '../Gridpak/NG_100m.nc';
lat_rho = nc_varget(gridFile,'lat_rho');
lon_rho = nc_varget(gridFile,'lon_rho');
lat_psi = nc_varget(gridFile,'lat_psi');
lon_psi = nc_varget(gridFile,'lon_psi');
[ny,nx] = size(lon_psi);
pn = nc_varget(gridFile,'pn');
pm = nc_varget(gridFile,'pm');


sourceFile = '../riverData_2020/flow_Taunton_dailyAve.txt';
dum = importdata(sourceFile);
time = dum(:,1);

nc_create_empty(newFile,nc_64bit_offset_mode);

% Dimension section
nc_add_dimension(newFile,'time',0);
nc_add_dimension(newFile,'lat',ny);
nc_add_dimension(newFile,'lon',nx);
nc_add_dimension(newFile,'bnds',2);

% Variables section

clear dum;
dum.Name = 'time';
dum.Nctype = 'float';
dum.Dimension = {'time'};
dum.Attribute = struct('Name',{'bounds','long_name','units','calendar'},'Value',{'time_bnds','time','days since 1900-01-01 00:00:00','gregorian'});
nc_addvar(newFile,dum)

clear dum;
dum.Name = 'time_bnds';
dum.Nctype = 'float';
dum.Dimension = {'time','bnds'};
% dum.Attribute = struct('Name',{'long_name','units','calendar'},'Value',{'time_bnds','days since 1900-01-01 00:00:00','gregorian','time, scalar, series'});
nc_addvar(newFile,dum)

clear dum;
dum.Name = 'lat';
dum.Nctype = 'float';
dum.Dimension = {'lat'};
dum.Attribute = struct('Name',{'long_name','units'},'Value',{'latitude','degrees_north'});
nc_addvar(newFile,dum);

clear dum;
dum.Name = 'lat_bnds';
dum.Nctype = 'float';
dum.Dimension = {'lat','bnds'};
% dum.Attribute = struct('Name',{'long_name','units'},'Value',{'latitude','degrees_north','time, scalar, series'});
nc_addvar(newFile,dum);

clear dum;
dum.Name = 'lon';
dum.Nctype = 'float';
dum.Dimension = {'lon'};
dum.Attribute = struct('Name',{'long_name','units'},'Value',{'longitude','degrees_east'});
nc_addvar(newFile,dum);

clear dum;
dum.Name = 'lon_bnds';
dum.Nctype = 'float';
dum.Dimension = {'lon','bnds'};
% dum.Attribute = struct('Name',{'long_name','units'},'Value',{'longitude','degrees_east','time, scalar, series'});
nc_addvar(newFile,dum);

clear dum;
dum.Name = 'friver';
dum.Nctype = 'float';
dum.Dimension = {'time','lat','lon'};
dum.Attribute = struct('Name',{'long_name','units','coordinates'},'Value',{'Water flux into sea water from rivers','kg m-2 s-1','lon lat'});
nc_addvar(newFile,dum);

% Global attributes section

nc_attput(newFile,nc_global,'title', 'USGS river source data file ala JRA55 files');
nc_attput(newFile,nc_global,'format', 'netCDF-3 64bit offset file' );
nc_attput(newFile,nc_global,'frequency', 'day' );

% Construct the bnds fields

lat_bnds = zeros(ny,2);
lon_bnds = zeros(nx,2);
time_bnds = zeros(length(time));

dum1=time-.5;
dum2=time+.5;
time_bnds=[dum1 dum2];

dum1=lon_rho(1,1:end-1);
dum2=lon_rho(1,2:end);
lon_bnds=[dum1' dum2'];

dum1=lat_rho(1:end-1,1);
dum2=lat_rho(2:end,1);
lat_bnds=[dum1 dum2];

% Fill in grid data
nc_varput(newFile,'lat'  ,lat_psi(:,1));
nc_varput(newFile,'lon'  ,lon_psi(1,:));
nc_varput(newFile,'time',time);
nc_varput(newFile,'time_bnds',time_bnds);
nc_varput(newFile,'lon_bnds',lon_bnds);
nc_varput(newFile,'lat_bnds',lat_bnds);


aaa=5;

%% Taunton river

% NOTE: these source files have the total freshwater flow in 
%       m^3/s
%  I need to divide these numbers by the area of tile where I dump this
%  water.

myI = 451;
myJ = 799;

sourceFile = '../riverData_2020/flow_Taunton_dailyAve.txt';
dum = importdata(sourceFile);
flow = dum(:,2);

area = 1/ ( pn(myJ,myI) * pm(myJ,myI) );

flow = flow/area;
dum = nc_varget(newFile,'friver');

dum(:,myJ,myI) = flow;


%% Pawtuxet river

myI = 265;
myJ = 820;

sourceFile = '../riverData_2020/flow_Pawtuxet_dailyAve.txt';
dum = importdata(sourceFile);
flow = dum(:,2);

area = 1/ ( pn(myJ,myI) * pm(myJ,myI) );

flow = flow/area;
dum = nc_varget(newFile,'friver');

dum(:,myJ,myI) = flow;


%% Blackstone river

myI = 254;
myJ = 909;

sourceFile = '../riverData_2020/flow_Blackstone_dailyAve.txt';
dum = importdata(sourceFile);
flow = dum(:,2);

area = 1/ ( pn(myJ,myI) * pm(myJ,myI) );

flow = flow/area;
dum = nc_varget(newFile,'friver');

dum(:,myJ,myI) = flow;


%% finish

nc_varput(newFile,'friver',dum);


