year = 2022;

% Most of the fields have three arguments - lat, lon, and t - but a few
% also include a 4th field - height

names3={'Pair',  'rain', 'lwrad_down', 'swrad', 'cloud', 'albedo'}
times3={'pair_time', 'rain_time', 'lrf_time', 'srf_time', 'cloud_time', 'albedo_time'}

names4={'Qair', 'Tair', 'Uwind', 'Vwind'}
times4={'qair_time', 'tair_time', 'wind_time', 'wind_time'}

MERRAdir='/import/VERTMIXFS/jgpender/roms-kate_svn/GlobalDataFiles/';

%% height-independent fields

for ii=1:5
    
    newFile = ['GFS_',char(names3(ii)),'_',num2str(year),'.nc']
    oldFile = [newFile,'_ORIG']
    mirrorSource = [MERRAdir,'MERRA_',char(names3(ii)),'*_2012.nc']
    
    lon = nc_varget(oldFile,'lon');
    lat = nc_varget(oldFile,'lat');
    time = nc_varget(oldFile,char(times3(ii)));
    var = nc_varget(oldFile,char(names3(ii)));
    [nt, ny, nx] = size(var);
    
    myArg =  ['ncks -O -d lon,1,',num2str(nx),' -d lat,1,',num2str(ny),' -d ',char(times3(ii)),',1,',num2str(nt),' '];
    unix([myArg,mirrorSource,' ',newFile]);
    
    lat = flipud(lat);
    for tt=1:nt
        var(tt,:,:) = flipud(sq(var(tt,:,:)));
    end;
    
    lonShift = 360.
    
    nc_varput(newFile,'lat',lat);
    nc_varput(newFile,'lon',lon-lonShift);
    nc_varput(newFile,char(names3(ii)),var);
    nc_varput(newFile,char(times3(ii)),time);
    
end;

%% height-dependent fields

for ii=1:4
    
    newFile = ['GFS_',char(names4(ii)),'_',num2str(year),'.nc']
    oldFile = [newFile,'_ORIG'];
    mirrorSource = [MERRAdir,'MERRA_',char(names4(ii)),'*_2012.nc']
    
    lon = nc_varget(oldFile,'lon');
    lat = nc_varget(oldFile,'lat');
    time = nc_varget(oldFile,char(times4(ii)));
    var = nc_varget(oldFile,char(names4(ii)));
    [nt, nlayers, ny, nx] = size(var);
    
    myArg =  ['ncks -O -d lon,1,',num2str(nx),' -d lat,1,',num2str(ny),' -d ',char(times4(ii)),',1,',num2str(nt),' '];
    unix([myArg,mirrorSource,' ',newFile]);
    
    var = sq(var(:,1,:,:));
    
    lat = flipud(lat);
    for tt=1:nt
        var(tt,:,:) = flipud(sq(var(tt,:,:)));
    end;
    
    nc_varput(newFile,'lat',lat);
    nc_varput(newFile,'lon',lon-lonShift);
    nc_varput(newFile,char(names4(ii)),var);
    nc_varput(newFile,char(times4(ii)),time);
    
end;

