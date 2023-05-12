zeta = nc_varget('netcdfOutput_normalLBC/zeta.nc','zeta');
[nt,~,~] = size(zeta)

level = zeros(nt);
for tt=1:nt
    sq(zeta(tt,:,:));level(tt)= nanmean(ans(:));
end


plot([1:nt]/24,level);title('nanmean(zeta)')
        

