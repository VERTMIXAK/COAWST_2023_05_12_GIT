clear

file1='/import/c1/VERTMIX/jgpender/roms-kate_svn/SEAKp_1km/InputFiles/Runoff_proto/sourceData/goa_dischargex_09012016_08312017.nc'
file2 ='/import/c1/VERTMIX/jgpender/roms-kate_svn/SEAKp_1km/InputFiles/Runoff_proto/runoffData/runoff_NGOA_09012016_08312017.nc'

dat1.lon=nc_varget(file1,'lon')
dat1.lat=nc_varget(file1,'lat')
dat1.q = nc_varget(file1,'q');
dat1.Q = squeeze(mean(dat1.q))';

dat2.lon=nc_varget(file2,'lon_rho')-360
dat2.lat=nc_varget(file2,'lat_rho')
dat2.q  = squeeze(mean(nc_varget(file2,'Runoff')))

%%
 bb = [-137 -130.5 55.5 59.6]
 figure(2);clf;colormap(jet)
 Qmin = 4;
%  subplot(1,2,1)
 idx = find(dat1.lon>bb(1)&dat1.lon<bb(2)&dat1.lat>bb(3)&dat1.lat<bb(4));
 plot(dat1.lon(idx),dat1.lat(idx),'k.');hold on

 
 
 
 idx = find(dat1.lon>bb(1)&dat1.lon<bb(2)&dat1.lat>bb(3)&dat1.lat<bb(4)&dat1.lat<bb(4)&log10(dat1.Q)>Qmin);
 scatter(dat1.lon(idx),dat1.lat(idx),30,log10(dat1.Q(idx)),'filled');hold on;caxis([Qmin 8]) 
 
 title('Hill and Beamer annual log10 annual mean')
