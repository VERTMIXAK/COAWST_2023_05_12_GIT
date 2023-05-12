clear;

% The presumption is that I've run bathtub only, so 
%   hraw(1) holds the unthresholded bathymetry (so mountains)
%   hraw(2) holds the thresholded bathymetry

gridFile = 'SEAKp_1km.nc'

hraw = nc_varget(gridFile,'hraw');
h    = sq(hraw(2,:,:));

lat = nc_varget(gridFile,'lat_rho');
lon = nc_varget(gridFile,'lon_rho');
mask = nc_varget(gridFile,'mask_rho');

% make sure the threshold is OK under everywhere under the land mask

threshold = 5;
h(mask==0) = threshold;

aaa=5;



%%

vLimit=[0,500];

% ivec = 2*[100:140];
% jvec = 2*[380:460];
% ivec = [300:600];
% jvec = [200:400];

[ny,nx] = size(h);
ivec = [1:nx];
jvec = [1:ny];



fig(1);pcolor(h);shading flat;colorbar%;caxis([0 8000])


fig(10);clf;
pcolor(ivec,jvec,h(jvec,ivec));shading flat;colorbar;caxis(vLimit);

fig(101);clf
contour(ivec,jvec,h(jvec,ivec))


aaa=5;

%%


% smoo = 40;
% Dsmoo=lowpass2d(double(vswap(h,nan,0)),smoo,smoo);done

fsmoo = 1/3;   filter_order = 9;Dsmoo  = hls_lowpassbutter2d(h,fsmoo,fsmoo,1,filter_order);
% fsmoo = 1/20;  filter_order = 9;Dsmoo = hls_lowpassbutter2d(h,fsmoo,fsmoo,1,filter_order);
% fsmoo = 1/30;  filter_order = 9;Dsmoo = hls_lowpassbutter2d(h,fsmoo,fsmoo,1,filter_order);


%Get rid of depths less than 50
Dsmoo(Dsmoo<50) = 50;


h(mask==0) = threshold;




fig(2);pcolor(Dsmoo);shading flat;colorbar;%caxis([0 8000])

fig(20);clf;
pcolor(ivec,jvec,Dsmoo(jvec,ivec));shading flat;colorbar;caxis(vLimit);


fig(3);clf;
pcolor(Dsmoo-h);shading flat;colorbar;

fig(30);clf;
pcolor(ivec,jvec,Dsmoo(jvec,ivec)-h(jvec,ivec));shading flat;colorbar;

fig(300);clf;
pcolor(1:50,1:50,Dsmoo(1:50,1:50)-h(1:50,1:50));shading flat;colorbar;

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


%Get rid of depths less than 50
Dsmoo(Dsmoo<50) = 50;
newh(mask==0) = threshold;



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
