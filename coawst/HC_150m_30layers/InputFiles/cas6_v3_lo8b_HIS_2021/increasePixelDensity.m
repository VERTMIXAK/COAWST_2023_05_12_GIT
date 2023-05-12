smallGridFile = './PS_UW_grid_reduced.nc';
bigGridFile = './PS_UW_grid_morePoints.nc';
unix(['cp ../Gridpak/HC_125m.nc ',bigGridFile]);

maskLObig = nc_varget(bigGridFile,'mask_rho');
maskLOsmall = nc_varget(smallGridFile,'mask_rho');

size(maskLObig)/4
[ny,nx] = size(maskLOsmall)

fig(1);clf;pcolor(maskLOsmall);shading flat
fig(2);clf;pcolor(maskLObig);shading flat

for ii=1:nx; for jj=1:ny
    
    maskLObig( (jj-1)*4+1:(jj-1)*4+4,(ii-1)*4+1:(ii-1)*4+4) = maskLOsmall(jj,ii);
end;end;

fig(3);clf;pcolor(maskLObig);shading flat
nc_varput(bigGridFile,'mask_rho',maskLObig);