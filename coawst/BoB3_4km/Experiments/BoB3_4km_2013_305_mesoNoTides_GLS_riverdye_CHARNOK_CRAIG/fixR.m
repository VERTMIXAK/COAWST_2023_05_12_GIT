clear; close all

rstFile = 'netcdfOutput_days063_270/bob_rst.nc';
newRSTFile = 'netcdfOutput_days063_270/bob_rst2.nc';

gridFile = 'BoB3_4km.nc';
HISFile = 'netcdfOutput_days001_DT20/bob_his_00001.nc';

grd = roms_get_grid(gridFile,HISFile,0,1);

unix(['\rm ',newRSTFile]);
unix(['ncks -d ocean_time,0 ',rstFile,' ',newRSTFile]);


%% Target the problem

ru    = nc_varget(rstFile,   'ru');
rubar = nc_varget(rstFile,'rubar');



[ntU,nU,nzU,nyU,nxU] = size(ru);
[ntUbar,nUbar,nzUbar,nyUbar,nxUbar] = size(rubar);

delta=5;
myY = 156;
myX = 90;

% myY = 100;
% myX = 200;

% fig(1);clf;imagesc(1:nxU,1:nyU,sq(ru(3,1,30,:,:)));axis xy;xlim([myX-delta myX+delta]);ylim([myY-delta myY+delta]);colorbar;
% fig(2);clf;imagesc(1:nxU,1:nyU,sq(ru(2,1,30,:,:)));axis xy;xlim([myX-delta myX+delta]);ylim([myY-delta myY+delta]);colorbar;
fig(3);clf;imagesc(1:nxU,1:nyU,sq(ru(3,1,30,myY-delta:myY+delta,myX-delta:myX+delta)));axis xy;colorbar;caxis([-500 500])
fig(4);clf;imagesc(1:nxU,1:nyU,sq(ru(2,1,30,myY-delta:myY+delta,myX-delta:myX+delta)));axis xy;colorbar;caxis([-500 500])



%%


% smoo = 40;
% Dsmoo=lowpass2d(double(vswap(h,nan,0)),smoo,smoo);done


dum = sq(ru(3,1,30,:,:));
fig(5);clf;imagesc(1:nxU,1:nyU,dum);axis xy;colorbar;caxis([-500 500])



fsmoo = 1/3;   filter_order = 11;dumSmoo  = hls_lowpassbutter2d(dum,fsmoo,fsmoo,1,filter_order);
% fsmoo = 1/20;  filter_order = 9;Dsmoo = hls_lowpassbutter2d(h,fsmoo,fsmoo,1,filter_order);
% fsmoo = 1/30;  filter_order = 9;Dsmoo = hls_lowpassbutter2d(h,fsmoo,fsmoo,1,filter_order);




fig(6);clf;imagesc(1:nxU,1:nyU,dumSmoo);axis xy;colorbar;caxis([-500 500])

aaa=5;


%% Feather the smoothed bathymetry into the original near the edges.

[ny, nx] = size(h);

width = .10* 1/fsmoo;
delta = 10*width;

% fig(90);clf;
% x=[1:100];
% plot(x,    1./(1+exp(-(x-delta)/width)) )
% 
% fig(91);clf;
% x=[nx-100:nx];
% plot(x,    1./(1+exp(-((nx-x)-delta)/width)) )
% 
% fig(92);clf;
% x=[1:nx];
% plot(x,  1./(1+exp(-(x-delta)/width)) +  1./(1+exp(-((nx-x)-delta)/width)) -1 )

sigmoidMask = 0*h;

for ii=1:nx; for jj=1:ny
    sigmoidMask(jj,ii) = (  1./(1+exp(-(ii-delta)/width)) +  1./(1+exp(-((nx-ii)-delta)/width)) - 1 ) * (  1./(1+exp(-(jj-delta)/width)) +  1./(1+exp(-((ny-jj)-delta)/width)) - 1 );
end;end;

fig(95);clf;
pcolor(sigmoidMask);shading flat;colorbar;



newh = h + (Dsmoo - h) .* sigmoidMask;

fig(50);clf
pcolor(newh - h);shading flat;colorbar;

fig(51);clf
pcolor(newh(1:50,1:50) - h(1:50,1:50));shading flat;colorbar;



% fig(52);clf
% pcolor(newh);shading flat;colorbar;caxis([0 5])
% 
% 
% fig(53);clf
% pcolor(mask);shading flat;colorbar;caxis([0 5])

fig(54);clf
pcolor(mask.*newh);shading flat;colorbar;caxis([0 5]);

irange=ivec;
jrange=jvec;
fig(98);clf;
contour(irange,jrange,sq(Dsmoo(jrange,irange)));shading flat;



aaa=5;


%% write the smoothed bathymetry to hmax(3)

hraw = nc_varget(gridFile,'hraw');
size(hraw)
hraw(3,:,:) = newh;
nc_varput(gridFile,'hraw',hraw)

%%

% irange=[900:1100];
% jrange=[200:250];


fig(98);clf;
pcolor(irange,jrange,sq(Dsmoo(jrange,irange)));shading flat;caxis([0,50]);colorbar


%%


fig(201);clf
contour(ivec,jvec,Dsmoo(jvec,ivec))

% irange=[900:1100];
% jrange=[200:250];
% 
% 
% fig(99);clf;
% pcolor(irange,jrange,sq(hraw(7,jrange,irange)));shading flat;caxis([0,100]);colorbar
