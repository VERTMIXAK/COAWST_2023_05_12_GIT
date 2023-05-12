clear;
close all;


% fileRunoff = 'Runoff_NGOA_defective/runoffData/runoff_NGOA_09012013_08312014.nc';
% fileSource = 'Runoff_NGOA_defective/sourceData/goa_dischargex_09012013_08312014.nc';
fileRunoff = 'Runoff_NGOA/runoffData/runoff_NGOA_09012013_08312014.nc';
fileSource = 'Runoff_NGOA/sourceData_subset/goa_dischargex_09012013_08312014.nc';
fileRivers = 'Runoff_NGOA/SEAKp_rivers_09012013_08312014.nc';
gridFile   = 'Gridpak/SEAKp_1km.nc';
% hisFile    = '../Experiments/SEAKp_1km_2017_002_meso_8tides_GLS_rivers_noDye_Hill/netcdfOutput_days3-12/seak_his_00005.nc';
hisFile    = 'BC_IC_CMEMS_2017/ini_002/CMEMS_2017_002_ic_SEAKp_1km.nc';

grd = roms_get_grid(gridFile,hisFile,0,1);

% The river file and the source file have the same timestamps, even if they
% are formated differently.
% timeSource = nc_varget(fileSource,'time');
timeRunoff = nc_varget(fileRunoff,'runoff_time');

qSource = nc_varget(fileSource,'q');
latSource = nc_varget(fileSource,'lat');
lonSource = nc_varget(fileSource,'lon');

runoff = nc_varget(fileRunoff,'Runoff');
runoffRaw = nc_varget(fileRunoff,'Runoff_raw');
lonRunoff = nc_varget(fileRunoff,'lon_rho')-360;
latRunoff = nc_varget(fileRunoff,'lat_rho');

transport = nc_varget(fileRivers,'river_transport');
Xriver = nc_varget(fileRivers,'river_Xposition');
Yriver = nc_varget(fileRivers,'river_Eposition');

% pick a date
date = 1;
q = sq(qSource(date,:))';
runoff = sq(runoff(date,:,:));
runoffRaw = sq(runoffRaw(date,:,:));
transport = sq(transport(date,:));

runoff(runoff==0)=nan;
runoffRaw(runoffRaw==0)=nan;


lonRiver = 0*Xriver; latRiver = 0*Xriver;
for nn=1:length(Xriver)
    lonRiver(nn) = grd.lon_rho(Yriver(nn),Xriver(nn));
    latRiver(nn) = grd.lat_rho(Yriver(nn),Xriver(nn));
end;
lonRiver=lonRiver-360;

bb = [-138 -130.5 53 59.5];
hls_get_wvs(bb);
load('coastCheck.mat')

aaa=5;


%% Plot the source data

qThreshold = 5;
ndx = find(lonSource>bb(1) & lonSource<bb(2) & latSource>bb(3) & latSource<bb(4) & log10(q) > qThreshold);

lonSource = lonSource(ndx);
latSource = latSource(ndx);
q   = q(ndx);

fig(5);clf;
plot(wvs.lon,wvs.lat,'w');hold on;
scatter(lonSource,latSource,q/86400+.01,'.');colorbar
title('Hill source file   q / 86400')


% fig(6);clf;
% plot(wvs.lon,wvs.lat,'w');hold on;
% scatter(lonSource(ndx),latSource(ndx),abs(qSource(ndx,1))/2500+.01,'.');colorbar
% title('Hill source file   q / 86400')




%% Plot the runoff data


[jdx,idx] = find(log10(runoff) > qThreshold);

myLons=zeros(1,length(jdx));myLats=myLons;myRunoff=myLons;myRunoffRaw=myLons;
for nn=1:length(jdx)
    myLons(nn) = lonRunoff(jdx(nn),idx(nn));
    myLats(nn) = latRunoff(jdx(nn),idx(nn));
    myRunoff(nn) = runoff(jdx(nn),idx(nn));
    myRunoffRaw(nn) = runoffRaw(jdx(nn),idx(nn));
end;

fig(10);clf;
plot(wvs.lon,wvs.lat,'w');hold on;
scatter(myLons,myLats,myRunoff/(86400)+.01,'.');colorbar
title(' runoff / (86400)')



%% Plot the ROMS forcing data


ndx = find( log10(abs(transport*86400)) > qThreshold);

lonRiver = lonRiver(ndx);
latRiver = latRiver(ndx);
transport   = transport(ndx);

fig(15);clf;
plot(wvs.lon,wvs.lat,'w');hold on;
scatter(lonRiver,latRiver,abs(transport)+.01,'.');colorbar
title('ROMS freshwater forcing file   abs(transport) ')


% fig(6);clf;
% plot(wvs.lon,wvs.lat,'w');hold on;
% scatter(lonSource(ndx),latSource(ndx),abs(qSource(ndx,1))/2500+.01,'.');colorbar
% title('Hill source file   q / 86400')


