file = 'netcdfOutput/sd_his2_00030.nc';

zeta = nc_varget(file,'zeta');

[nt,~,~] = size(zeta);

sq(zeta(end,:,:));nanmean(ans(:))

myMean=zeros(nt);

for tt=1:nt
    sq(zeta(end,:,:));
    myMean(tt) = nanmean(ans(:));
end
fig(1);clf;plot(myMean)

fig(2);clf;pcolor(sq(zeta(1,:,:)));colorbar

