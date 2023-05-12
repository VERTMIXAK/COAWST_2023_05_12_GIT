year = '2018';

sourceData = ['/import/c1/VERTMIX/jgpender/roms-kate_svn/GlobalDataFiles/JRA_BoB/JRA55DO_1.4_Tair_',year,'_BoB_monthlyAve.nc'];

tair = nc_varget(sourceData,'Tair') - 272.15;
lat  = nc_varget(sourceData,'lat');
lon  = nc_varget(sourceData,'lon');

riverFileORIG = ['JRA-1.4_BoB_rivers_',year,'.nc_ORIG'];
riverFile  = ['JRA-1.4_BoB_rivers_',year,'.nc'];
unix(['cp ',riverFileORIG,' ',riverFile])


riverTemp = nc_varget(riverFile,'river_temp');
riverX    = nc_varget(riverFile,'river_Xposition');
riverY    = nc_varget(riverFile,'river_Eposition');
[ntRiver, nyRiver, nxRiver] = size(riverTemp);


gridFile = '../Gridpak/BoB3_4km.nc';
gridLat  = nc_varget(gridFile,'lat_rho');
gridLon  = nc_varget(gridFile,'lon_rho');

riverTempNew = riverTemp;

for tt=1:ntRiver
    tt
    dum = sq(tair(tt,:,:));
    for ii=1:nxRiver;
        riverTempNew(tt,:,ii) = interp2(lon,lat,dum,gridLon(riverX(ii)),gridLat(riverY(ii))  );
end;end;

nc_varput(riverFile,'river_temp',riverTempNew);


