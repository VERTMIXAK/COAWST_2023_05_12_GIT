zeta = nc_varget('zeta.nc','zeta');
[nt,~,~] = size(zeta)

level = zeros(nt);
for tt=1:nt
    sq(zeta(tt,:,:));level(tt)= nanmean(ans(:));
end
plot(level)
        

