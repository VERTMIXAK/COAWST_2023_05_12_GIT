h = nc_varget('PS_UW_grid_reduced.nc','h');
mask = nc_varget('PS_UW_grid_reduced.nc','mask_rho');
pm = nc_varget('PS_UW_grid_reduced.nc','pm');

[ny,nx] = size(h);





fig(1);clf;
imagesc(mask);axis xy

fig(2);clf;
imagesc(h);axis xy

fig(3);clf
imagesc(mask);axis xy;xlim([80 nx+.5]);ylim([130 ny+.5])


mask(end,86:89)
h(end,86:89)
1./pm(end,86:89);

%% 

gridFile = '../Gridpak/HC_125m.nc';
myH = nc_varget(gridFile,'h');
myMask = nc_varget(gridFile,'mask_rho');
myPm = nc_varget(gridFile,'pm');
[myNy,myNx] = size(myH);

fig(11);clf;
imagesc(myMask);axis xy

fig(12);clf;
imagesc(myH);axis xy

fig(13);clf
imagesc(myMask);axis xy;ylim([530 myNy+.5]);xlim([330 myNx+.5])

myMask(end,341:357)
myH(end,341:357)
1./myPm(end,341:357);


%%

widthLO = sum(1./pm(end,86:89))
widthHC = sum(1./myPm(end,341:357))

areaLO = sum( h(end,86:89)./pm(end,86:89) )
areaHC = sum( myH(end,341:357)./myPm(end,341:357) )
