gFile = 'HC_100mME.nc';

hraw = nc_varget(gFile,'hraw');

hold = sq(hraw(2,:,:));
% hnew = lowpass(lowpass(hold',4)',4);
% hnew = lowpass(lowpass(hold',2)',2);
hnew = lowpass(lowpass(hold',8)',8);

% fsmoo = 1/3; filter_order=9; hnew = hls_lowpassbutter2d(hold,fsmoo,fsmoo,1,filter_order);

hnew(hnew<5)=4;

fig(1);pcolor(hold);shading flat;caxis([0 20])
fig(2);pcolor(hnew);shading flat;caxis([0 20])

hraw(3,:,:) = hnew;
nc_varput(gFile,'hraw',hraw);

