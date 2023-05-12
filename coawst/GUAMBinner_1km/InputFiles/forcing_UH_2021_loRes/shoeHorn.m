

year = 2021;


names={'Pair', 'Qair', 'Tair', 'rain', 'lwrad_down', 'swrad', 'Uwind', 'Vwind', 'albedo', 'cloud'}
times={'pair_time', 'qair_time', 'tair_time', 'rain_time', 'lrf_time', 'srf_time', 'wind_time', 'wind_time', 'albedo_time', 'cloud_time'}

% longNames= {'Pressure_surface', ...
%     'Specific_humidity_height_above_ground',...
%     'Temperature_height_above_ground',...
%     'Precipitation_rate_surface',...
%     'Downward_Long-Wave_Radp_Flux_surface_6_Hour_Average',...
%     'Downward_Short-Wave_Radiation_Flux_surface_3_Hour_Average',...
%     'u-component_of_wind_height_above_ground',...
%     'v-component_of_wind_height_above_ground',...
%     'Albedo_surface_6_Hour_Average',...
%     'Total_cloud_cover_entire_atmosphere_3_Hour_Average'}

latMin=11;
latMax=17;
lonMin=141;
lonMax=148;


MERRAdir='/import/c1/VERTMIX/jgpender/roms-kate_svn/GlobalDataFiles/MERRA_FLEAT/'

for ii=1:8
    
    newFile = [char(names(ii)),'.nc']
    oldFile = [newFile,'_ORIG']
    mirrorSource = [MERRAdir,'MERRA_',char(names(ii)),'*2014*.nc']
    
    lon = nc_varget(oldFile,'lon');
    lat = nc_varget(oldFile,'lat');
    time = nc_varget(oldFile,char(times(ii)));
    var = nc_varget(oldFile,char(names(ii)));
    [nt, ny, nx] = size(var)
    
    myArg =  ['ncks -O -d lon,1,',num2str(nx),' -d lat,1,',num2str(ny),' -d ',char(times(ii)),',1,',num2str(nt),' '];
    unix([myArg,mirrorSource,' ',newFile])
    
    lat = flipud(lat);
    for tt=1:nt
        var(tt,:,:) = flipud(sq(var(tt,:,:)));
    end;
    
    if ii==1    % convert pressure from millibar to Pascal
        var = 100. * var;
    end;
        
        
    nc_varput(newFile,'lat',lat);
    nc_varput(newFile,char(names(ii)),var);
    nc_varput(newFile,char(times(ii)),time);
    
end;

