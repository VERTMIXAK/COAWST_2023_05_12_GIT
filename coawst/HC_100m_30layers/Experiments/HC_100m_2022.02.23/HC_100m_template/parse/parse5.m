clear;close all;

HISnames  = dir('../netcdfOutput/*_his_*') ;
HIS2names = dir('../netcdfOutput/*_his2_*');

gridFile    = '../HC_100mME_wetDry.nc';
newGridFile = 'grid.nc';

[nFiles,~] = size(HISnames);

dum = ['../netcdfOutput/',HISnames(2).name];
[~,exptDate] =  unix(['echo ',dum,' | rev | cut -d "_" -f1 | rev | cut -d "." -f1']);exptDate=exptDate(1:end-1);


ff=5
    
    
    sourceHIS   = ['../netcdfOutput/',HISnames(ff).name];
    sourceHIS2  = ['../netcdfOutput/',HIS2names(ff).name];
    outHIS      = ['outHIS_',num2str(ff),'.nc';
    outHIS2     = ['outHIS2_',num2str(ff),'.nc';
    
    [~,fileDate] =  unix(['echo ',sourceHIS,' | rev | cut -d "_" -f1 | rev | cut -d "." -f1']);fileDate=fileDate(1:end-1);
    
    grd = roms_get_grid(gridFile,['../netcdfOutput/',HISnames(1).name],0,1);
    
    lonmin = -123 + 360;
    lonmax = -122.625 + 360;
    latmin = 47.6;
    latmax = 47.87;
    
    abs(grd.lon_rho(1,:) - lonmin); find(ans == min(ans));  imin = ans(1);
    abs(grd.lon_rho(1,:) - lonmax); find(ans == min(ans));  imax = ans(end);
    
    abs(grd.lat_rho(:,1) - latmin); find(ans == min(ans));  jmin = ans(1);
    abs(grd.lat_rho(:,1) - latmax); find(ans == min(ans));  jmax = ans(end);
    
    
    
    fig(1);clf;
    pcolor(grd.lon_rho(jmin:jmax,imin:imax),grd.lat_rho(jmin:jmax,imin:imax),grd.mask_rho(jmin:jmax,imin:imax));shading flat
    
    
    aaa=5;
    
    
    %% Some stuff
    
    % Subset SOME of the HIS variables to a new file
    unix(['\rm ',outHIS]);
    % vars = 'temp,salt,u_eastward,v_northward,zeta,ubar_eastward,vbar_northward';
    vars = 'zeta,ubar_eastward,vbar_northward';
    
    unix(['ncks -d xi_rho,',num2str(imin-1),',',num2str(imax-1),' -d eta_rho,',num2str(jmin-1),',',num2str(jmax-1),' -v ',vars,' ',sourceHIS,' ',outHIS]);
    
    tHIS  = nc_varget(sourceHIS,'ocean_time');
    tHIS2 = nc_varget(sourceHIS2,'ocean_time');
    
    myTimes = [];
    for tt=1:length(tHIS)
        [myTimes(tt),~] = find(tHIS2 == tHIS(tt));
    end
    myTimes;
    
    
    % grab sustr and svstr from the HIS2 file. The point here is to subset the
    % HIS2 data to the same time stamps that the HIS data uses.
    iStart = myTimes(1) - 1;
    diff(myTimes); iStride = ans(1);
    iEnd = myTimes(end) - 1;
    timeLimits = [num2str(iStart),',',num2str(iEnd),',',num2str(iStride)];
    
    unix(['\rm ',outHIS2]);
    vars = 'sustr,svstr';
    
    unix(['ncks -d ocean_time,',timeLimits,' -v ',vars,' ',sourceHIS2,' ',outHIS2]);
    
    aaa=5;
    
    %% Build full output file
    
    outFile = ['HC_',fileDate,'.nc'];
    
    
    
    unix(['\rm ',outFile]);
    nc_create_empty(outFile,nc_64bit_offset_mode);
    
    z = [0     1     2     3     4     5     6     7     8     9    10    15    20    25 ...
        30    35    40    45    50    60    70    80    90 100   110   120   130   140   150   160   170   180   200];
    
    
    % Dimension section
    nc_add_dimension(outFile,'lon',length([imin:imax]));
    nc_add_dimension(outFile,'lat',length(jmin:jmax));
    nc_add_dimension(outFile,'depth',length(z));
    nc_add_dimension(outFile,'time',0);
    
    %% ocean_time
    dum.Name = 'time';
    dum.Nctype = 'double';
    dum.Dimension = {'time'};
    dum.Attribute = struct('Name',{'long_name','units','calendar','field'},'Value',{'time since initialization','seconds since 1900-01-01 00:00:00','proleptic_gregorian','time, scalar, series'});
    nc_addvar(outFile,dum);
    
    temp = nc_varget(outHIS,'ocean_time');
    nc_varput(outFile,'time',temp);
    
    %% h
    dum.Name = 'bathy';
    dum.Nctype = 'float';
    dum.Dimension = {'lat','lon'};
    dum.Attribute = struct('Name',{'long_name','units'},'Value',{'bathymetry','meter'});
    nc_addvar(outFile,dum);
    
    temp = nc_varget(gridFile,'h');
    nc_varput(outFile,'bathy',temp(jmin:jmax,imin:imax));
    
    %% mask_rho
    dum.Name = 'mask';
    dum.Nctype = 'int';
    dum.Dimension = {'lat','lon'};
    dum.Attribute = struct('Name',{'long_name','flag_values','flag_meanings'},'Value',{'mask on RHO-grid','0,1','land, water'});
    nc_addvar(outFile,dum);
    
    temp = nc_varget(gridFile,'mask_rho');
    nc_varput(outFile,'mask',temp(jmin:jmax,imin:imax));
    
    %% lon
    % dum.Name = 'lon2D';
    % dum.Nctype = 'double';
    % dum.Dimension = {'lat','lon'};
    % dum.Attribute = struct('Name',{'long_name','units'},'Value',{'longitude of RHO points','degree_east'});
    % nc_addvar(outFile,dum);
    
    dum.Name = 'lon';
    dum.Nctype = 'double';
    dum.Dimension = {'lon'};
    dum.Attribute = struct('Name',{'long_name','units'},'Value',{'longitude of RHO points','degree_east'});
    nc_addvar(outFile,dum);
    
    temp = nc_varget(gridFile,'lon_rho');
    lon2D = temp(jmin:jmax,imin:imax);
    % nc_varput(outFile,'lon2D',lon2D);
    nc_varput(outFile,'lon',lon2D(1,:));
    aaa=5;
    
    %% lat
    % dum.Name = 'lat2D';
    % dum.Nctype = 'double';
    % dum.Dimension = {'lat','lon'};
    % dum.Attribute = struct('Name',{'long_name','units'},'Value',{'latitude of RHO points','degree_north'});
    % nc_addvar(outFile,dum);
    
    dum.Name = 'lat';
    dum.Nctype = 'double';
    dum.Dimension = {'lat'};
    dum.Attribute = struct('Name',{'long_name','units'},'Value',{'latitude of RHO points','degree_north'});
    nc_addvar(outFile,dum);
    
    temp = nc_varget(gridFile,'lat_rho');
    lat2D = temp(jmin:jmax,imin:imax);
    % nc_varput(outFile,'lat2D',lat2D);
    nc_varput(outFile,'lat',lat2D(:,1));
    aaa=5;
    
    %% z
    dum.Name = 'depth';
    dum.Nctype = 'double';
    dum.Dimension = {'depth'};
    dum.Attribute = struct('Name',{'long_name','units'},'Value',{'depth','meter'});
    nc_addvar(outFile,dum);
    
    nc_varput(outFile,'depth',z);
    
    %% zeta
    dum.Name = 'zeta';
    dum.Nctype = 'double';
    dum.Dimension = {'time','lat','lon'};
    dum.Attribute = struct('Name',{'long_name','units','field'},'Value',{'free-surface','meter','free-surface, scalar, series'});
    nc_addvar(outFile,dum);
    
    temp = nc_varget(outHIS,'zeta');
    nc_varput(outFile,'zeta',temp);
    aaa=5;
    
    %% u
    dum.Name = 'u';
    dum.Nctype = 'double';
    dum.Dimension = {'time','depth','lat','lon'};
    dum.Attribute = struct('Name',{'long_name','units','field'},'Value',{'u at RHO points','m/s','u, scalar, series'});
    nc_addvar(outFile,dum);
    
    oldU = nc_varget(sourceHIS,'u');
    nz = length(z);
    newU = zeros(length(tHIS),nz,length([jmin:jmax]),length([imin:imax]) );
    
    newU(:,1,:,:) = oldU(:,end,jmin:jmax,imin:imax);
    tic
    for tt=1:length(tHIS);for kk=2:nz
            roms_zslice(sourceHIS,'u_eastward',tt,z(kk),grd);
            newU(tt,kk,:,:) = ans(jmin:jmax,imin:imax);
        end;end;
    toc
    
    nc_varput(outFile,'u',newU);
    
    %% ubar
    dum.Name = 'ubar';
    dum.Nctype = 'double';
    dum.Dimension = {'time','lat','lon'};
    dum.Attribute = struct('Name',{'long_name','units','field'},'Value',{'ubar at RHO points','m/s','u, scalar, series'});
    nc_addvar(outFile,dum);
    
    temp = nc_varget(outHIS,'ubar_eastward');
    nc_varput(outFile,'ubar',temp);
    
    %% v
    dum.Name = 'v';
    dum.Nctype = 'double';
    dum.Dimension = {'time','depth','lat','lon'};
    dum.Attribute = struct('Name',{'long_name','units','field'},'Value',{'v at RHO points','m/s','u, scalar, series'});
    nc_addvar(outFile,dum);
    
    oldV = nc_varget(sourceHIS,'v');
    nz = length(z);
    newV = zeros(length(tHIS),nz,length([jmin:jmax]),length([imin:imax]) );
    
    newV(:,1,:,:) = oldV(:,end,jmin:jmax,imin:imax);
    tic
    for tt=1:length(tHIS);for kk=2:nz
            roms_zslice(sourceHIS,'v_northward',tt,z(kk),grd);
            newV(tt,kk,:,:) = ans(jmin:jmax,imin:imax);
        end;end;
    toc
    
    nc_varput(outFile,'v',newV);
    
    %% vbar
    dum.Name = 'vbar';
    dum.Nctype = 'double';
    dum.Dimension = {'time','lat','lon'};
    dum.Attribute = struct('Name',{'long_name','units','field'},'Value',{'vbar at RHO points','m/s','u, scalar, series'});
    nc_addvar(outFile,dum);
    
    temp = nc_varget(outHIS,'vbar_northward');
    nc_varput(outFile,'vbar',temp);
    
    %% salt
    dum.Name = 'salt';
    dum.Nctype = 'double';
    dum.Dimension = {'time','depth','lat','lon'};
    dum.Attribute = struct('Name',{'long_name','field'},'Value',{'salinity','salinity, scalar, series'});
    nc_addvar(outFile,dum);
    
    
    oldS = nc_varget(sourceHIS,'salt');
    nz = length(z);
    newS = zeros(length(tHIS),nz,length([jmin:jmax]),length([imin:imax]) );
    
    newS(:,1,:,:) = oldS(:,end,jmin:jmax,imin:imax);
    tic
    for tt=1:length(tHIS);for kk=2:nz
            roms_zslice(sourceHIS,'salt',tt,z(kk),grd);
            newS(tt,kk,:,:) = ans(jmin:jmax,imin:imax);
        end;end;
    toc
    
    nc_varput(outFile,'salt',newS);
    
    %% temp
    dum.Name = 'temp';
    dum.Nctype = 'double';
    dum.Dimension = {'time','depth','lat','lon'};
    dum.Attribute = struct('Name',{'long_name','units','field'},'Value',{'potential temperature','Celsius','temperature, scalar, series'});
    nc_addvar(outFile,dum);
    
    oldT = nc_varget(sourceHIS,'temp');
    nz = length(z);
    newT = zeros(length(tHIS),nz,length([jmin:jmax]),length([imin:imax]) );
    
    newT(:,1,:,:) = oldT(:,end,jmin:jmax,imin:imax);
    tic
    for tt=1:length(tHIS);for kk=2:nz
            roms_zslice(sourceHIS,'temp',tt,z(kk),grd);
            newT(tt,kk,:,:) = ans(jmin:jmax,imin:imax);
        end;end;
    toc
    
    nc_varput(outFile,'temp',newT);
    
    %% sustr
    
    dum.Name = 'sustr';
    dum.Nctype = 'float';
    dum.Dimension = {'time','lat','lon'};
    dum.Attribute = struct('Name',{'long_name','units','field'},'Value',{'surface u-momentum stress on RHO-grid','N m-2','surface u-momentum stress, scalar, series'});
    nc_addvar(outFile,dum);
    
    oldStress = nc_varget(outHIS2,'sustr');
    [nt,~,~] = size(oldStress);
    
    newStress = zeros(nt,length([jmin:jmax]),length([imin:imax]) );
    for tt=1:nt
%         newStress(tt,:,:) = interp2(grd.lon_u,grd.lat_u,sq(oldStress(tt,:,:)),lon2D,lat2D);
        newStress(tt,:,:) = oldStress(tt,jmin:jmax,imin:imax);
    end;
    
    nc_varput(outFile,'sustr',newStress);
    
    aaa=5;
    
    %% svstr
    
    dum.Name = 'svstr';
    dum.Nctype = 'float';
    dum.Dimension = {'time','lat','lon'};
    dum.Attribute = struct('Name',{'long_name','units','field'},'Value',{'surface v-momentum stress on RHO-grid','N m-2','surface v-momentum stress, scalar, series'});
    nc_addvar(outFile,dum);
    
    oldStress = nc_varget(outHIS2,'svstr');
    [nt,~,~] = size(oldStress);
    
    newStress = zeros(nt,length([jmin:jmax]),length([imin:imax]) );
    for tt=1:nt
%         newStress(tt,:,:) = interp2(grd.lon_v,grd.lat_v,sq(oldStress(tt,:,:)),lon2D,lat2D);
        newStress(tt,:,:) = oldStress(tt,jmin:jmax,imin:imax);
    end;
    
    nc_varput(outFile,'svstr',newStress);
    

