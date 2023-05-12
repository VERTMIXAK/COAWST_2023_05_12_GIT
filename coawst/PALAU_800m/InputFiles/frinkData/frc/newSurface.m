clear;

oldFile = 'surf_Jan.nc';
newFile = 'surf2_Jan.nc';

oldLat = nc_varget(oldFile,'lat');
oldLon = nc_varget(oldFile,'lon');

size(oldLat)
[ny,nx] = size(oldLon)

nc_create_empty(newFile,nc_64bit_offset_mode);
    
% Dimension section
nc_add_dimension(newFile,'lon',nx);
nc_add_dimension(newFile,'lat',ny);
nc_add_dimension(newFile,'frc_time',0);

%% Variables section

dum.Name = 'lon';
dum.Nctype = 'float';
dum.Dimension = {'lon'};
dum.Attribute = struct('Name',{'long_name','units'},'Value',{'Longitude','degrees_east'});
nc_addvar(newFile,dum);

dum.Name = 'lat';
dum.Nctype = 'float';
dum.Dimension = {'lat'};
dum.Attribute = struct('Name',{'long_name','units'},'Value',{'Latitude','degrees_north'});
nc_addvar(newFile,dum);

nc_varput(newFile,'lon',oldLon(1,:));
nc_varput(newFile,'lat',oldLat(:,1));


longName = 'atmospheric forcing frc_time';
units    = 'days since 2000-01-01 00:00:00'; 
dum.Name = 'frc_time';
dum.Nctype = 'float';
dum.Dimension = {'frc_time'};
dum.Attribute = struct('Name',{'long_name','units','time','coordinates','field'},'Value',{longName,units,'frc_time','frc_time','placeholder, scalar, series'});
nc_addvar(newFile,dum);

temp = nc_varget(oldFile,'frc_time');
nc_varput(newFile,'frc_time',temp);


longName = 'surface air pressure';
units    = 'millibar'; 
dum.Name = 'Pair';
dum.Nctype = 'float';
dum.Dimension = {'frc_time','lat','lon'};
dum.Attribute = struct('Name',{'long_name','units','time','coordinates','field'},'Value',{longName,units,'frc_time',['lon lat ','frc_time'],'placeholder, scalar, series'});
nc_addvar(newFile,dum);

temp = nc_varget(oldFile,'Pair');
nc_varput(newFile,'Pair',temp);


longName = 'surface air relative humidity';
units    = 'percentage'; 
dum.Name = 'Qair';
dum.Nctype = 'float';
dum.Dimension = {'frc_time','lat','lon'};
dum.Attribute = struct('Name',{'long_name','units','time','coordinates','field'},'Value',{longName,units,'frc_time',['lon lat ','frc_time'],'placeholder, scalar, series'});
nc_addvar(newFile,dum);

temp = nc_varget(oldFile,'Qair');
nc_varput(newFile,'Qair',temp);


longName = 'surface air temperature';
units    = 'Celcius'; 
dum.Name = 'Tair';
dum.Nctype = 'float';
dum.Dimension = {'frc_time','lat','lon'};
dum.Attribute = struct('Name',{'long_name','units','time','coordinates','field'},'Value',{longName,units,'frc_time',['lon lat ','frc_time'],'placeholder, scalar, series'});
nc_addvar(newFile,dum);

temp = nc_varget(oldFile,'Tair');
nc_varput(newFile,'Tair',temp);


longName = 'surface u-wind component';
units    = 'meter second-1'; 
dum.Name = 'Uwind';
dum.Nctype = 'float';
dum.Dimension = {'frc_time','lat','lon'};
dum.Attribute = struct('Name',{'long_name','units','time','coordinates','field'},'Value',{longName,units,'frc_time',['lon lat ','frc_time'],'placeholder, scalar, series'});
nc_addvar(newFile,dum);

temp = nc_varget(oldFile,'Uwind');
nc_varput(newFile,'Uwind',temp);



longName = 'surface v-wind component';
units    = 'meter second-1'; 
dum.Name = 'Vwind';
dum.Nctype = 'float';
dum.Dimension = {'frc_time','lat','lon'};
dum.Attribute = struct('Name',{'long_name','units','time','coordinates','field'},'Value',{longName,units,'frc_time',['lon lat ','frc_time'],'placeholder, scalar, series'});
nc_addvar(newFile,dum);

temp = nc_varget(oldFile,'Vwind');
nc_varput(newFile,'Vwind',temp);


longName = 'net longwave radiation flux';
units    = 'Watts meter-2'; 
dum.Name = 'lwrad_down';
dum.Nctype = 'float';
dum.Dimension = {'frc_time','lat','lon'};
dum.Attribute = struct('Name',{'long_name','units','time','coordinates','field'},'Value',{longName,units,'frc_time',['lon lat ','frc_time'],'placeholder, scalar, series'});
nc_addvar(newFile,dum);

temp = nc_varget(oldFile,'lwrad_down');
nc_varput(newFile,'lwrad_down',temp);


longName = 'rain fall rate';
units    = 'kilogram meter-2 second-1'; 
dum.Name = 'rain';
dum.Nctype = 'float';
dum.Dimension = {'frc_time','lat','lon'};
dum.Attribute = struct('Name',{'long_name','units','time','coordinates','field'},'Value',{longName,units,'frc_time',['lon lat ','frc_time'],'placeholder, scalar, series'});
nc_addvar(newFile,dum);

temp = nc_varget(oldFile,'rain');
nc_varput(newFile,'rain',temp);



longName = 'solar shortwave radiation';
units    = 'Watts meter-2'; 
dum.Name = 'swrad';
dum.Nctype = 'float';
dum.Dimension = {'frc_time','lat','lon'};
dum.Attribute = struct('Name',{'long_name','units','time','coordinates','field'},'Value',{longName,units,'frc_time',['lon lat ','frc_time'],'placeholder, scalar, series'});
nc_addvar(newFile,dum);

temp = nc_varget(oldFile,'swrad');
nc_varput(newFile,'swrad',temp);
