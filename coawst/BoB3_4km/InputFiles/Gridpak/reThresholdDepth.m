file = 'PALAU_400m.nc';

h = nc_varget(file,'h');

fig(1);clf;
pcolor(h);shading flat;colorbar;caxis([0,8000])

hPrime=h;
hPrime(hPrime>6000) = 6000;
fig(2);clf;
pcolor(hPrime);shading flat;colorbar;caxis([0,8000])

nc_varput(file,'h',hPrime);