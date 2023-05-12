file = 'SDa_8km.nc';
h = nc_varget(file,'h');
mask = nc_varget(file,'mask_rho');


%% First fix

fig(1);clf;imagesc(h);axis xy;colorbar


fig(2);clf;imagesc(mask);axis xy;colorbar

fig(3);clf;imagesc(h(6:8,22:24));axis xy;colorbar

h(6:8,22:24)

aaa=5;


 h(6:8,22:24);mean(ans(:));h(7,23) = ans;
 
 
fig(11);clf;imagesc(h);axis xy;colorbar


fig(12);clf;imagesc(mask);axis xy;colorbar

fig(13);clf;imagesc(h(5:10,20:25));axis xy;colorbar



fig(14);clf;imagesc(h(6:8,22:24));axis xy;colorbar

h(6:8,22:24)

aaa=5;



%% Second fix

fig(1);clf;imagesc(h);axis xy;colorbar


fig(2);clf;imagesc(mask);axis xy;colorbar

fig(3);clf;imagesc(h(21:23,1:3));axis xy;colorbar

h(21:23,1:3)

aaa=5;


h(21:23,1:2);mean(ans(:));h(22,1) = ans;
h(21:23,1:3);mean(ans(:));h(22,2) = ans; 
 
fig(11);clf;imagesc(h);axis xy;colorbar


fig(12);clf;imagesc(mask);axis xy;colorbar

fig(13);clf;imagesc(h(21:23,1:3));axis xy;colorbar



fig(14);clf;imagesc(h(21:23,1:3));axis xy;colorbar

h(21:23,1:3)

aaa=5;



%% Write

nc_varput(file,'h',h);