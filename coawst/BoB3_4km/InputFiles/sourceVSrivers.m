fileRivers = 'Runoff/JRA-1.4_BoB_rivers_2013.nc';
fileSource = '/import/c1/AKWATERS/kate/JRA55-do/runoff_JRA55-do-1-4-0_2013.nc';
gridFile   = 'Gridpak/BoB3_4km.nc';
hisFile    = '../Experiments/BoB3_4km_2013_305_mesoNoTides_GLS_riverdye_CHARNOK_CRAIG/netcdfOutput_days003_007_DT100/bob_his_00005.nc';

grd = roms_get_grid(gridFile,hisFile,0,1);

timeSource = nc_varget(fileSource,'time');

timesRivers = nc_varget(fileRivers,'river_time');

fRiverSource = nc_varget(fileSource,'friver');
latSource = nc_varget(fileSource,'lat');
lonSource = nc_varget(fileSource,'lon');

transportFull = nc_varget(fileRivers,'river_transport');
Xriver = nc_varget(fileRivers,'river_Xposition');
Yriver = nc_varget(fileRivers,'river_Eposition');

%pick a date

dNum = 180;
fSource = sq(fRiverSource(dNum,:,:));
transport     = sq(transportFull(dNum,:))';

bb = [84.125 93.875 18.375 24.125];
hls_get_wvs(bb);
load('coastCheck.mat')

% fig(1);clf
% plot(wvs.lon,wvs.lat,'r');


%% Plot the source data

idx = find(lonSource>bb(1) & lonSource<bb(2));
jdx = find(latSource>bb(3) & latSource<bb(4));

lonSource = lonSource(idx);
latSource = latSource(jdx);
fSource   = fSource(jdx,idx);

fig(5);clf;
pcolor(lonSource,latSource,log10(fSource));shading flat;colorbar
caxis([-5 -1])

title('Source data - need to get area figured out');



[a,b] = find(fSource == max(fSource(:)) );

% [dum1,~] = distance(latSource(a),lonSource(b),latSource(a+1),lonSource(b  ))
% [dum2,~] = distance(latSource(a),lonSource(b),latSource(a),  lonSource(b+1))

[deltaY,~] = sw_dist([latSource(a),latSource(a+1)],[lonSource(b),lonSource(b  )],'km');
[deltaX,~] = sw_dist([latSource(a),latSource(a  )],[lonSource(b),lonSource(b+1)],'km');

% the Ganges flow in m^3/s (after noting the density is about 1030 kg /m^3 )

approxFlowGangesSource = fSource(a,b) * (1000*deltaX) * (1000*deltaY) / 1030

% Do the whole domain

flowSourceTot = sum(fSource(:)) * (1000*deltaX) * (1000*deltaY) / 1030

aaa=5;






%% Plot the data in the river file

% The river forcing file has coastal points only, written as integer
% indices on the ROMS grid file. 

lonRiver = 0*Xriver; latRiver = 0*Xriver;
for nn=1:length(Xriver)
    lonRiver(nn) = grd.lon_rho(Yriver(nn),Xriver(nn));
    latRiver(nn) = grd.lat_rho(Yriver(nn),Xriver(nn));
end;



ndx = find(lonRiver>bb(1) & lonRiver<bb(2) & latRiver>bb(3) & latRiver<bb(4));

% fig(9);clf;
% plot(wvs.lon,wvs.lat,'r');hold on;
% scatter(lonRiver(ndx),latRiver(ndx),abs(transport(ndx)),'.');
% title('ROMS freshwater forcing file')

fig(10);clf;
plot(wvs.lon,wvs.lat,'r');hold on;
scatter(lonRiver(ndx),latRiver(ndx),abs(transport(ndx))+.01,'.');
title('ROMS freshwater forcing file')

aaa=5;

[a,~] = find(abs(transport) == max(abs(transport)) );
a=a(1);

% the Ganges flow here is in m^3 / sec

approxFlowGangesROMS = sum(abs(transport(a-15:a+15) ))

romsFileTot = sum(abs(transport(:) ))


aaa=5;


 