ORIGFile = 'PRAIRIENest_3km_child.nc_ORIG';
newFile  = 'PRAIRIENest_3km_child.nc';
parentFile = 'PRAIRIENest_3km_parent.nc';

unix(['cp ',ORIGFile,' ',newFile]);
grdC = roms_get_grid(newFile);
grdP  = roms_get_grid(parentFile);

h = nc_varget(newFile,'h');

hPrho = grdP.h;

hCrho = grdC.h;
hRhoOld = hCrho;
fig(1);clf;pcolor(hCrho);shading flat;colorbar
caxis([5760 5820])

% put h on the parent psi grid
[ny,nx] = size(grdP.mask_psi);
hPpsi = zeros(ny,nx);
for jj=1:ny; for ii=1:nx
    hPpsi(jj,ii) = .25*( grdP.h(jj,ii) + grdP.h(jj,ii+1) + grdP.h(jj+1,ii) + grdP.h(jj+1,ii+1) );
end;end;

% put h on the child psi grid
[ny,nx] = size(grdC.mask_psi);
hCpsi = zeros(ny,nx);
for jj=1:ny; for ii=1:nx
    hCpsi(jj,ii) = .25*( grdC.h(jj,ii) + grdC.h(jj,ii+1) + grdC.h(jj+1,ii) + grdC.h(jj+1,ii+1) );
end;end;


hCrho(1,3) = (-1).*hCrho(1,2)+(1/3).*((-3).*hCrho(2,2)+(-3).*hCrho(2,3)+2.* hPrho(55,101)+3.*hPrho(55,102)+hPrho(55,103)+2.*hPrho(56,101)+3.* hPrho(56,102)+hPrho(56,103)) ;
hCrho(1,4) = hCrho(1,2)+(1/3).*(3.*hCrho(2,2)+(-3).* hCrho(2,4)+(-1).*hPrho(55,101)+hPrho(55,103)+(-1).*hPrho(56,101)+ hPrho(56,103)) ;
hCrho(1,5) = (-1).*hCrho(1,2)+(1/3).*((-3).*hCrho(2,2)+(-3).* hCrho(2,5)+hPrho(55,101)+3.*hPrho(55,102)+2.*hPrho(55,103)+ hPrho(56,101)+3.*hPrho(56,102)+2.*hPrho(56,103)) ;
hCrho(1,6) = hCrho(1,2)+(1/3).*( 3.*hCrho(2,2)+(-3).*hCrho(2,6)+(-1).*hPrho(55,101)+(-1).* hPrho(55,102)+hPrho(55,103)+hPrho(55,104)+(-1).*hPrho(56,101)+(-1).* hPrho(56,102)+hPrho(56,103)+hPrho(56,104)) ;
hCrho(1,7) = (-1).*hCrho(1,2)+(1/3).*(( -3).*hCrho(2,2)+(-3).*hCrho(2,7)+hPrho(55,101)+2.*hPrho(55,102)+2.* hPrho(55,103)+hPrho(55,104)+hPrho(56,101)+2.*hPrho(56,102)+2.* hPrho(56,103)+hPrho(56,104)) ;
hCrho(2,1) = (-1).*hCrho(1,1)+(-1).*hCrho(1,2)+(-1).* hCrho(2,2)+hPrho(55,101)+hPrho(55,102)+hPrho(56,101)+hPrho(56,102) ;
hCrho(2,8) = hCrho(1,2)+(-1).*hCrho(1,8)+(1/3).*(3.*hCrho(2,2)+(-1).*hPrho(55,101)+ (-2).*hPrho(55,102)+hPrho(55,103)+2.*hPrho(55,104)+(-1).* hPrho(56,101)+(-2).*hPrho(56,102)+hPrho(56,103)+2.*hPrho(56,104)) ;
hCrho(3,1) = hCrho(1,1)+hCrho(1,2)+(1/3).*((-3).*hCrho(3,2)+(-1).*hPrho(55,101)+( -1).*hPrho(55,102)+hPrho(57,101)+hPrho(57,102)) ;
hCrho(3,8) = (-1).*hCrho(1,2)+ hCrho(1,8)+(1/3).*((-3).*hCrho(2,2)+(-3).*hCrho(2,7)+(-3).*hCrho(3,7)+ hPrho(55,101)+2.*hPrho(55,102)+hPrho(55,103)+hPrho(56,101)+2.* hPrho(56,102)+2.*hPrho(56,103)+hPrho(56,104)+hPrho(57,103)+ hPrho(57,104)) ;
hCrho(4,1) = (-1).*hCrho(1,1)+(-1).*hCrho(1,2)+(1/3).*((-3).* hCrho(4,2)+2.*hPrho(55,101)+2.*hPrho(55,102)+3.*hPrho(56,101)+3.* hPrho(56,102)+hPrho(57,101)+hPrho(57,102)) ;
hCrho(4,8) = hCrho(1,2)+(-1).*hCrho(1,8)+ (1/3).*(3.*hCrho(2,2)+3.*hCrho(2,7)+(-3).*hCrho(4,7)+(-1).* hPrho(55,101)+(-2).*hPrho(55,102)+hPrho(55,104)+(-1).*hPrho(56,101)+( -2).*hPrho(56,102)+hPrho(56,103)+2.*hPrho(56,104)+hPrho(57,103)+ hPrho(57,104)) ;
hCrho(5,2) = hCrho(1,1)+hCrho(1,2)+(-1).*hCrho(5,1)+(-2/3).*( hPrho(55,101)+hPrho(55,102)+(-1).*hPrho(57,101)+(-1).*hPrho(57,102)) ;
hCrho(5,3) = ( -1).*hCrho(1,1)+(-1).*hCrho(1,2)+hCrho(5,1)+(1/3).*((-3).*hCrho(4,2)+( -3).*hCrho(4,3)+2.*hPrho(55,101)+2.*hPrho(55,102)+2.*hPrho(56,101)+3.* hPrho(56,102)+hPrho(56,103)+hPrho(57,102)+hPrho(57,103)) ;
hCrho(5,4) = hCrho(1,1)+ hCrho(1,2)+(-1).*hCrho(5,1)+(1/3).*(3.*hCrho(4,2)+(-3).*hCrho(4,4)+( -2).*hPrho(55,101)+(-2).*hPrho(55,102)+(-1).*hPrho(56,101)+ hPrho(56,103)+hPrho(57,101)+2.*hPrho(57,102)+hPrho(57,103)) ;
hCrho(5,5) = (-1).* hCrho(1,1)+(-1).*hCrho(1,2)+hCrho(5,1)+(1/3).*((-3).*hCrho(4,2)+(-3).* hCrho(4,5)+2.*hPrho(55,101)+2.*hPrho(55,102)+hPrho(56,101)+3.* hPrho(56,102)+2.*hPrho(56,103)+(-1).*hPrho(57,101)+hPrho(57,102)+2.* hPrho(57,103)) ;
hCrho(5,6) = hCrho(1,1)+hCrho(1,2)+(-1).*hCrho(5,1)+(1/3).*(3.* hCrho(4,2)+(-3).*hCrho(4,6)+(-2).*hPrho(55,101)+(-2).*hPrho(55,102)+( -1).*hPrho(56,101)+(-1).*hPrho(56,102)+hPrho(56,103)+hPrho(56,104)+ hPrho(57,101)+hPrho(57,102)+hPrho(57,103)+hPrho(57,104)) ;
hCrho(5,7) = (-1).* hCrho(1,1)+(-1).*hCrho(1,2)+hCrho(5,1)+(1/3).*((-3).*hCrho(4,2)+(-3).* hCrho(4,7)+2.*hPrho(55,101)+2.*hPrho(55,102)+hPrho(56,101)+2.* hPrho(56,102)+2.*hPrho(56,103)+hPrho(56,104)+(-1).*hPrho(57,101)+2.* hPrho(57,103)+hPrho(57,104)) ;
hCrho(5,8) = hCrho(1,1)+hCrho(1,8)+(-1).*hCrho(5,1)+( 1/3).*((-3).*hCrho(2,2)+(-3).*hCrho(2,7)+3.*hCrho(4,2)+3.*hCrho(4,7)+( -1).*hPrho(55,101)+(-1).*hPrho(55,104)+hPrho(57,101)+hPrho(57,104)) ;





fig(2);clf;pcolor(hCrho);shading flat;colorbar
% caxis([5760 5820])

fig(3);clf;pcolor(hCrho - h);shading flat;colorbar

nc_varput(newFile,'h',hCrho);
