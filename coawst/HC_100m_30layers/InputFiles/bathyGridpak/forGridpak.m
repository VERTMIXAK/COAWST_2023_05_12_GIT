oldFile = 'psdem2000_arrayLatLon.nc';

outFile = 'psdem2000.Gridpak.nc';

topo = nc_varget(oldFile,'topo');
lat = nc_varget(oldFile,'lat');
lon = nc_varget(oldFile,'lon') + 360;

[ny,nx] = size(topo);

fig(1);clf;
pcolor(lon,lat,topo);shading flat;colorbar


aaa=5;


%% Turn the data into something Gridpak can use

nc_create_empty(outFile,nc_64bit_offset_mode);

% Dimension section
nc_add_dimension(outFile,'lon',nx);
nc_add_dimension(outFile,'lat',ny);
% Variables section

dum.Name = 'topo_lon';
dum.Nctype = 'double';
dum.Dimension = {'lon'};
dum.Attribute = struct('Name',{'long_name','units','field'},'Value',{'longitude','degrees_east','time, scalar, series'});
nc_addvar(outFile,dum);

dum.Name = 'topo_lat';
dum.Nctype = 'double';
dum.Dimension = {'lat'};
dum.Attribute = struct('Name',{'long_name','units','field'},'Value',{'latitude','degrees_north','time, scalar, series'});
nc_addvar(outFile,dum);

dum.Name = 'topo';
dum.Nctype = 'double';
dum.Dimension = {'lat','lon'};
dum.Attribute = struct('Name',{'long_name','units','coordinates','field'},'Value',{'elevation','meter','topo_lat topo_lon','elevation, scalar, series'});
nc_addvar(outFile,dum);


% Global attributes section

nc_attput(outFile,nc_global,'title', 'PSDEM-2000 - 10m grid' );
nc_attput(outFile,nc_global,'type', 'Gridpak-ready bathymetry file' );


% Fill in grid data
nc_varput(outFile,'topo_lat',lat);
nc_varput(outFile,'topo_lon',lon);
% elevation is in decimeters
nc_varput(outFile,'topo'    ,topo  );

