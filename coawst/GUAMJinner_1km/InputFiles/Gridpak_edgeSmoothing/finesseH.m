fileORIG = 'GUAMFinner_1km.nc_hORIG';
fileNEW  = 'GUAMFinner_1km.nc';


h = nc_varget(fileNEW,'h');
mask = nc_varget(fileNEW,'mask_rho');


myJ = 313;myI = 238;

delta=7;



fig(1);clf;
imagesc(sq(h(myJ-delta:myJ+delta,myI-delta:myI+delta)));axis xy;colorbar
caxis([10 100])

fig(2);clf;
imagesc(sq(mask(myJ-delta:myJ+delta,myI-delta:myI+delta)));axis xy;colorbar

%% 'fix' h

for ii=myI-1:myI+1
    h(myJ,ii) = 1/3 * ( h(myJ+1,ii) + h(myJ-1,ii) + h(myJ,ii-1) );
end;



fig(21);clf;
imagesc(sq(h(myJ-delta:myJ+delta,myI-delta:myI+delta)));axis xy;colorbar
caxis([10 200])

