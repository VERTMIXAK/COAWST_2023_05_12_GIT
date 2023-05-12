clear;
lat0 = 47;
lat1 = 48.9;
lon0 = -124.7;
lon1 = -122.1;

% At 47N, the deltaX of a longitude increment is only about 
%   cos(lat) = cos(48 deg) ~ .66
% as big as the deltaY of the same latitude increment

factor = cos( (lat1+lat0)/2 *3.14159/180 );

intervalLat = 1/1000;
intervalLon = 1/1600;

lat_b = [lat0:intervalLat:lat1];
lon_b = [lon0:intervalLon:lon1];

lat = (lat_b(1:end-1) + lat_b(2:end) ) /2;
lon = (lon_b(1:end-1) + lon_b(2:end) ) /2;

aaa=5;



%% Turn the data into something Gridpak can use

outFile = 'forXesmf.nc';

nc_create_empty(outFile,nc_64bit_offset_mode);

% Dimension section
nc_add_dimension(outFile,'x',length(lon));
nc_add_dimension(outFile,'y',length(lat));
nc_add_dimension(outFile,'x_b',length(lon_b));
nc_add_dimension(outFile,'y_b',length(lat_b));


% Variables section

dum.Name = 'lon';
dum.Nctype = 'double';
dum.Dimension = {'x'};
dum.Attribute = struct('Name',{'long_name','units','field'},'Value',{'longitude','degrees_east','time, scalar, series'});
nc_addvar(outFile,dum);

dum.Name = 'lat';
dum.Nctype = 'double';
dum.Dimension = {'y'};
dum.Attribute = struct('Name',{'long_name','units','field'},'Value',{'latitude','degrees_north','time, scalar, series'});
nc_addvar(outFile,dum);


dum.Name = 'lon_b';
dum.Nctype = 'double';
dum.Dimension = {'x_b'};
dum.Attribute = struct('Name',{'long_name','units','field'},'Value',{'longitude','degrees_east','time, scalar, series'});
nc_addvar(outFile,dum);

dum.Name = 'lat_b';
dum.Nctype = 'double';
dum.Dimension = {'y_b'};
dum.Attribute = struct('Name',{'long_name','units','field'},'Value',{'latitude','degrees_north','time, scalar, series'});
nc_addvar(outFile,dum);



% Global attributes section



% Fill in grid data
nc_varput(outFile,'lat',lat);
nc_varput(outFile,'lon',lon);
nc_varput(outFile,'lat_b',lat_b);
nc_varput(outFile,'lon_b',lon_b);


