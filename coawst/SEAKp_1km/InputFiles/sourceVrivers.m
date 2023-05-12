clear;

fileRivers = 'Runoff_NGOA/SEAKp_rivers_09012013_08312014.nc';
fileSource = 'Runoff_NGOA/sourceData/goa_dischargex_09012013_08312014.nc';
gridFile   = 'Gridpak/SEAKp_1km.nc';
hisFile    = '../Experiments/SEAKp_1km_2017_002_meso_8tides_GLS_rivers_noDye_Hill/netcdfOutput_days3-12/seak_his_00005.nc';

grd = roms_get_grid(gridFile,hisFile,0,1);


% The river file and the source file have the same timestamps, even if they
% are formated differently.
% timeSource = nc_varget(fileSource,'time');
timeRivers = nc_varget(fileRivers,'river_time');

qSource = nc_varget(fileSource,'q');
latSource = nc_varget(fileSource,'lat');
lonSource = nc_varget(fileSource,'lon');

transport = nc_varget(fileRivers,'river_transport');
Xriver = nc_varget(fileRivers,'river_Xposition');
Yriver = nc_varget(fileRivers,'river_Eposition');

lonRiver = 0*Xriver; latRiver = 0*Xriver;
for nn=1:length(Xriver)
    lonRiver(nn) = grd.lon_rho(Yriver(nn),Xriver(nn));
    latRiver(nn) = grd.lat_rho(Yriver(nn),Xriver(nn));
end;
lonRiver=lonRiver-360;

%pick a date. The first snapshot is 1 Aug, which is fine.

dNum = 1;
qSource   = sq(qSource(dNum,:));
transport = sq(transport(dNum,:))';

bb = [-138 -130.5 53 59.5];
hls_get_wvs(bb);
load('coastCheck.mat')

% fig(1);clf
% plot(wvs.lon,wvs.lat,'r');


%% Plot the source data

ndx = find(lonSource>bb(1) & lonSource<bb(2) & latSource>bb(3) & latSource<bb(4));

lonSource = lonSource(ndx);
latSource = latSource(ndx);
qSource   = qSource(ndx);

fig(5);clf;
plot(wvs.lon,wvs.lat,'r');hold on;
scatter(lonSource,latSource,abs(qSource)/86400+.01,'.');
title('Hill source file')


% fig(5);clf;
% pcolor(lonSource,latSource,log10(qSource));shading flat;colorbar
% caxis([-5 -1])
% 
% title('Source data - need to get area figured out');







%% Plot the data in the river file

% The river forcing file has coastal points only, written as integer
% indices on the ROMS grid file. 


fig(10);clf;
plot(wvs.lon,wvs.lat,'r');hold on;
scatter(lonRiver,latRiver,abs(transport)+.01,'.');
title('ROMS freshwater forcing file')

[dum,~] = find(abs(transport)==max(abs(transport(:))));
transport(dum)=0;
fig(11);clf;
plot(wvs.lon,wvs.lat,'r');hold on;
scatter(lonRiver,latRiver,abs(transport)+.01,'.');
title('ROMS freshwater forcing file')

