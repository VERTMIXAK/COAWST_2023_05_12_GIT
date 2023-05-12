file2D = 'Runoff/BoB_runoff_2013.nc';
fileSource = '/import/c1/AKWATERS/kate/JRA55-do/runoff_JRA55-do-1-4-0_2013.nc';


timeSource = nc_varget(fileSource,'time');

times2D = nc_varget(file2D,'time');

fRiverSource = nc_varget(fileSource,'friver');
latSource = nc_varget(fileSource,'lat');
lonSource = nc_varget(fileSource,'lon');

fRiver2D = nc_varget(file2D,'friver');
lon2D = nc_varget(file2D,'lon');
lat2D = nc_varget(file2D,'lat');

%% pick a date

dNum = 180;
fSource = sq(fRiverSource(dNum,:,:));
f2D     = sq(fRiver2D(dNum,:,:));

aaa=5;

%% Find a suitable BB
% This grid is rotated 

% fig(1);clf;pcolor(lon2D,lat2D,dum);shading flat

[a,b] = find( f2D == max(f2D(:)) );
dum(a,b) = 0;

fig(2);clf;pcolor(lon2D,lat2D,log10(f2D));shading flat;colorbar
title('log10(fRiver) for runoff file');

bb = [84 94 18.5 24];
hls_get_wvs(bb);
load('coastCheck.mat')


aaa=5;

%% Plot the source data
 
hls_get_wvs(bb);
load('coastCheck.mat')

[jdx,idx] = find(fSource > 0);


fig(5);clf;
hold on;
pcolor(lonSource,latSource,log10(fSource));shading flat;colorbar
xlim([bb(1) bb(2)]);ylim([bb(3) bb(4)])
title('source data')

aaa=5;

[a,b] = find(fSource == max(fSource(:)) )

% [dum1,~] = distance(latSource(a),lonSource(b),latSource(a+1),lonSource(b  ))
% [dum2,~] = distance(latSource(a),lonSource(b),latSource(a),  lonSource(b+1))

[deltaY,~] = sw_dist([latSource(a),latSource(a+1)],[lonSource(b),lonSource(b  )],'km');
[deltaX,~] = sw_dist([latSource(a),latSource(a  )],[lonSource(b),lonSource(b+1)],'km');

% the Ganges flow oughta be about (kg/sec)

fSource(a,b) * (1000*deltaX) * (1000*deltaY)

aaa=5;

%% Plot the runoff data
 
cutoff = -5;

[jdx,idx] = find(lon2D>bb(1)&lon2D<bb(2)&lat2D>bb(3)&lat2D<bb(4)&log10(f2D)>cutoff);
% [jdx,idx] = find(lon2D>bb(1)&lon2D<bb(2)&lat2D>bb(3)&lat2D<bb(4));
myLat=zeros(1,length(jdx));myLon=myLat;myRunoff=myLat;
for nn=1:length(jdx)
    myLat(nn) = lat2D(jdx(nn),idx(nn));
    myLon(nn) = lon2D(jdx(nn),idx(nn));
    myRunoff(nn) = f2D(jdx(nn),idx(nn));
end;


fig(10);clf
plot(wvs.lon,wvs.lat,'r');
hold on;
scatter(myLon,myLat,myRunoff/500000,'.');
title('runoff file')


