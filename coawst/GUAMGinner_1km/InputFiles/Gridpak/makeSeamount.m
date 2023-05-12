oldGrid = 'GUAMGinner_1km.nc_ORIG';
newGrid = 'GUAMGinner_1km_seamount.nc';
unix(['cp ',oldGrid,' ',newGrid]);


mask = nc_varget(newGrid,'mask_rho');
mask = 1+ 0*mask;
nc_varput(newGrid,'mask_rho',mask);

mask = nc_varget(newGrid,'mask_psi');
mask = 1+ 0*mask;
nc_varput(newGrid,'mask_psi',mask);

mask = nc_varget(newGrid,'mask_u');
mask = 1+ 0*mask;
nc_varput(newGrid,'mask_u',mask);

mask = nc_varget(newGrid,'mask_v');
mask = 1+ 0*mask;
nc_varput(newGrid,'mask_v',mask);

%%


h = nc_varget(newGrid,'h');

[ny,nx] = size(h)
xdum = [1:nx] - nx/2;
ydum = [1:ny] - ny/2;

fig(1);clf;
plot( 6000 - sq(h(ny/2,:)) );


a=6000 - 200;
b=0;
c=30;
x = 1:nx;
myH =  (a) * exp( - (xdum-b).^2 ./ c^2   );
fig(2);clf;
plot(x, myH)

fig(3);clf;
plot( 6000 - sq(h(ny/2,:)) );
hold on;
plot(x+24, myH,'r')

fig(4);clf;
plot( sq(h(ny/2,:)) );
hold on;
plot(x+24, 6000 - myH,'r')


%%

hdum = h;
rmat = h;
for ii=1:nx; for jj=1:ny    
    r = sqrt( (xdum(ii))^2 + (ydum(jj))^2 );
    rmat(jj,ii) = r;
    hdum(jj,ii) = 6000 - a * exp( - (r-b)^2 / c^2 );
end;end;
fig(5);clf;
pcolor(rmat);shading flat;colorbar
fig(6);clf;
pcolor(hdum);shading flat;colorbar

fig(7);clf;
plot( 6000 - sq(hdum(ny/2,:)) );
fig(8);clf;
plot( 6000 - sq(hdum(:,nx/2)) );

nc_varput(newGrid,'h',hdum);





