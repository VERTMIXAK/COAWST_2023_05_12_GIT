clear;

kateDir = '/import/AKWATERS/kshedstrom/hydroflow/new_2019/';
localDir = 'Runoff_NGOA/sourceData/'

file = [localDir,'goa_dischargex_09012013_08312014.nc']
    
lon = nc_varget(file,'lon');
lat = nc_varget(file,'lat');

q = nc_varget(file,'q');
size(q)

fig(1);plot(lon,lat)

%%
lon0 = min(lon);
lon1 = max(lon);
lat0 = min(lat);
lat1 = max(lat);

bb = [   [lon0;lon1]  [lat0;lat1 ]]

hls_get_wvs(bb);

load('coastCheck.mat')

wvs.lon = wvs.lon;


fig(2);clf;plot(lon,lat,'.');hold on
plot(wvs.lon,wvs.lat,'r')
