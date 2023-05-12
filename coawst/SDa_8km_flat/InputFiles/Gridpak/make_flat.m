clear;

oldGrid = 'SDa_8km.nc';
newGrid = 'SDa_8km_flat.nc';

unix(['cp ',oldGrid,' ',newGrid]);

h = nc_varget(newGrid,'h');
mask = nc_varget(newGrid,'mask_rho');

fig(1);clf;imagesc(h);axis xy
fig(2);clf;imagesc(mask);axis xy;colorbar





indices = find( mask == 0);
[myJ,myI] = ind2sub(size(mask),indices);
[myJ,myI];ans(1:15,:)

newJ = [myJ(1:8)' myJ(10)];
newI = [myI(1:8)' myI(10)];
[newJ',newI'];ans(1:9,:)

hnew = h*0 + 1945;
masknew = mask;

for ii=1:length(newI)
    masknew(newJ(ii),newI(ii)) = 1;
%     h(newJ(ii)-1:newJ(ii)+1,newI(ii)-1:newI(ii)+1);
%     hnew(newJ(ii),newI(ii)) = mean(ans(:));
    
end


fig(11);clf;imagesc(hnew);axis xy
fig(12);clf;imagesc(masknew);axis xy

nc_varput(newGrid,'h',hnew);
nc_varput(newGrid,'mask_rho',masknew);
