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
fig(1);clf;imagesc(hCrho);axis xy;colorbar
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


hCrho(1,10) = (1/3).*((-3).*hCrho(1,11)+(-3).*hCrho(8,10)+(-3).*hCrho(8,11)+2.* hPrho(55,104)+2.*hPrho(55,105)+hPrho(56,104)+hPrho(56,105)+ hPrho(57,104)+hPrho(57,105)+2.*hPrho(58,104)+2.*hPrho(58,105)) ;
hCrho(2,10) = (1/3).* ((-3).*hCrho(2,11)+3.*hCrho(8,10)+3.*hCrho(8,11)+hPrho(55,104)+ hPrho(55,105)+2.*hPrho(56,104)+2.*hPrho(56,105)+(-1).*hPrho(57,104)+( -1).*hPrho(57,105)+(-2).*hPrho(58,104)+(-2).*hPrho(58,105)) ;
hCrho(2,1) = (1/3).*( 3.*hCrho(1,11)+(-3).*hCrho(1,1)+3.*hCrho(2,11)+2.*hPrho(55,101)+ hPrho(55,102)+(-1).*hPrho(55,104)+(-2).*hPrho(55,105)+2.* hPrho(56,101)+hPrho(56,102)+(-1).*hPrho(56,104)+(-2).*hPrho(56,105)) ;
hCrho(2,2) = ( 1/3).*((-3).*hCrho(1,11)+(-3).*hCrho(1,2)+(-3).*hCrho(2,11)+ hPrho(55,101)+2.*hPrho(55,102)+hPrho(55,104)+2.*hPrho(55,105)+ hPrho(56,101)+2.*hPrho(56,102)+hPrho(56,104)+2.*hPrho(56,105)) ;
hCrho(2,3) = (1/3).* (3.*hCrho(1,11)+(-3).*hCrho(1,3)+3.*hCrho(2,11)+hPrho(55,101)+ hPrho(55,102)+hPrho(55,103)+(-1).*hPrho(55,104)+(-2).*hPrho(55,105)+ hPrho(56,101)+hPrho(56,102)+hPrho(56,103)+(-1).*hPrho(56,104)+(-2).* hPrho(56,105)) ;
hCrho(2,4) = (1/3).*((-3).*hCrho(1,11)+(-3).*hCrho(1,4)+(-3).* hCrho(2,11)+2.*hPrho(55,102)+hPrho(55,103)+hPrho(55,104)+2.* hPrho(55,105)+2.*hPrho(56,102)+hPrho(56,103)+hPrho(56,104)+2.* hPrho(56,105)) ;
hCrho(2,5) = (1/3).*(3.*hCrho(1,11)+(-3).*hCrho(1,5)+3.*hCrho(2,11)+ hPrho(55,102)+2.*hPrho(55,103)+(-1).*hPrho(55,104)+(-2).* hPrho(55,105)+hPrho(56,102)+2.*hPrho(56,103)+(-1).*hPrho(56,104)+(-2) .*hPrho(56,105)) ;
hCrho(2,6) = (1/3).*((-3).*hCrho(1,11)+(-3).*hCrho(1,6)+(-3).* hCrho(2,11)+hPrho(55,102)+hPrho(55,103)+2.*hPrho(55,104)+2.* hPrho(55,105)+hPrho(56,102)+hPrho(56,103)+2.*hPrho(56,104)+2.* hPrho(56,105)) ;
hCrho(2,7) = (1/3).*(3.*hCrho(1,11)+(-3).*hCrho(1,7)+3.*hCrho(2,11)+ 2.*hPrho(55,103)+(-2).*hPrho(55,105)+2.*hPrho(56,103)+(-2).* hPrho(56,105)) ;
hCrho(2,8) = (1/3).*((-3).*hCrho(1,11)+(-3).*hCrho(1,8)+(-3).* hCrho(2,11)+hPrho(55,103)+3.*hPrho(55,104)+2.*hPrho(55,105)+ hPrho(56,103)+3.*hPrho(56,104)+2.*hPrho(56,105)) ;
hCrho(2,9) = (1/3).*(3.* hCrho(1,11)+(-3).*hCrho(1,9)+3.*hCrho(2,11)+hPrho(55,103)+(-1).* hPrho(55,105)+hPrho(56,103)+(-1).*hPrho(56,105)) ;
hCrho(3,10) = (1/3).*((-3).* hCrho(3,11)+(-3).*hCrho(8,10)+(-3).*hCrho(8,11)+hPrho(55,104)+ hPrho(55,105)+hPrho(56,104)+hPrho(56,105)+2.*hPrho(57,104)+2.* hPrho(57,105)+2.*hPrho(58,104)+2.*hPrho(58,105)) ;
hCrho(3,2) = (1/3).*(3.* hCrho(1,1)+3.*hCrho(1,2)+(-3).*hCrho(3,1)+(-1).*hPrho(55,101)+(-1).* hPrho(55,102)+hPrho(57,101)+hPrho(57,102)) ;
hCrho(4,10) = (1/3).*((-3).*hCrho(4,11)+ 3.*hCrho(8,10)+3.*hCrho(8,11)+2.*hPrho(56,104)+2.*hPrho(56,105)+(-2).* hPrho(58,104)+(-2).*hPrho(58,105)) ;
hCrho(4,2) = (1/3).*((-3).*hCrho(1,1)+(-3).* hCrho(1,2)+(-3).*hCrho(4,1)+2.*hPrho(55,101)+2.*hPrho(55,102)+3.* hPrho(56,101)+3.*hPrho(56,102)+hPrho(57,101)+hPrho(57,102)) ;
hCrho(5,10) = (1/3).*(( -3).*hCrho(5,11)+(-3).*hCrho(8,10)+(-3).*hCrho(8,11)+hPrho(56,104)+ hPrho(56,105)+3.*hPrho(57,104)+3.*hPrho(57,105)+2.*hPrho(58,104)+2.* hPrho(58,105)) ;
hCrho(5,2) = (1/3).*(3.*hCrho(1,1)+3.*hCrho(1,2)+(-3).*hCrho(5,1)+( -2).*hPrho(55,101)+(-2).*hPrho(55,102)+2.*hPrho(57,101)+2.* hPrho(57,102)) ;
hCrho(6,10) = (1/3).*((-3).*hCrho(6,11)+3.*hCrho(8,10)+3.* hCrho(8,11)+hPrho(56,104)+hPrho(56,105)+(-1).*hPrho(58,104)+(-1).* hPrho(58,105)) ;
hCrho(6,2) = (1/3).*((-3).*hCrho(1,1)+(-3).*hCrho(1,2)+(-3).* hCrho(6,1)+2.*hPrho(55,101)+2.*hPrho(55,102)+2.*hPrho(56,101)+2.* hPrho(56,102)+hPrho(57,101)+hPrho(57,102)+hPrho(58,101)+hPrho(58,102)) ;
hCrho(7,10) = (1/3).*((-3).*hCrho(7,1)+(-3).*hCrho(8,10)+(-3).*hCrho(8,1)+2.* hPrho(57,101)+hPrho(57,102)+2.*hPrho(57,104)+hPrho(57,105)+2.* hPrho(58,101)+hPrho(58,102)+2.*hPrho(58,104)+hPrho(58,105)) ;
hCrho(7,11) = (1/3).*( 3.*hCrho(7,1)+(-3).*hCrho(8,11)+3.*hCrho(8,1)+(-2).*hPrho(57,101)+(-1) .*hPrho(57,102)+hPrho(57,104)+2.*hPrho(57,105)+(-2).*hPrho(58,101)+( -1).*hPrho(58,102)+hPrho(58,104)+2.*hPrho(58,105)) ;
hCrho(7,2) = (1/3).*(3.* hCrho(1,1)+3.*hCrho(1,2)+(-3).*hCrho(7,1)+(-2).*hPrho(55,101)+(-2).* hPrho(55,102)+(-1).*hPrho(56,101)+(-1).*hPrho(56,102)+2.* hPrho(57,101)+2.*hPrho(57,102)+hPrho(58,101)+hPrho(58,102)) ;
hCrho(7,3) = (1/3).*( 3.*hCrho(7,1)+3.*hCrho(8,1)+(-3).*hCrho(8,3)+(-1).*hPrho(57,101)+ hPrho(57,103)+(-1).*hPrho(58,101)+hPrho(58,103)) ;
hCrho(7,4) = (1/3).*((-3).* hCrho(7,1)+(-3).*hCrho(8,1)+(-3).*hCrho(8,4)+2.*hPrho(57,101)+3.* hPrho(57,102)+hPrho(57,103)+2.*hPrho(58,101)+3.*hPrho(58,102)+ hPrho(58,103)) ;
hCrho(7,5) = (1/3).*(3.*hCrho(7,1)+3.*hCrho(8,1)+(-3).*hCrho(8,5)+( -2).*hPrho(57,101)+2.*hPrho(57,103)+(-2).*hPrho(58,101)+2.* hPrho(58,103)) ;
hCrho(7,6) = (1/3).*((-3).*hCrho(7,1)+(-3).*hCrho(8,1)+(-3).* hCrho(8,6)+2.*hPrho(57,101)+2.*hPrho(57,102)+hPrho(57,103)+ hPrho(57,104)+2.*hPrho(58,101)+2.*hPrho(58,102)+hPrho(58,103)+ hPrho(58,104)) ;
hCrho(7,7) = (1/3).*(3.*hCrho(7,1)+3.*hCrho(8,1)+(-3).*hCrho(8,7)+( -2).*hPrho(57,101)+(-1).*hPrho(57,102)+2.*hPrho(57,103)+hPrho(57,104)+ (-2).*hPrho(58,101)+(-1).*hPrho(58,102)+2.*hPrho(58,103)+ hPrho(58,104)) ;
hCrho(7,8) = (1/3).*((-3).*hCrho(7,1)+(-3).*hCrho(8,1)+(-3).* hCrho(8,8)+2.*hPrho(57,101)+hPrho(57,102)+hPrho(57,103)+2.* hPrho(57,104)+2.*hPrho(58,101)+hPrho(58,102)+hPrho(58,103)+2.* hPrho(58,104)) ;
hCrho(7,9) = (1/3).*(3.*hCrho(7,1)+3.*hCrho(8,1)+(-3).*hCrho(8,9)+( -2).*hPrho(57,101)+(-1).*hPrho(57,102)+hPrho(57,103)+hPrho(57,104)+ hPrho(57,105)+(-2).*hPrho(58,101)+(-1).*hPrho(58,102)+hPrho(58,103)+ hPrho(58,104)+hPrho(58,105)) ;
hCrho(8,2) = (1/3).*((-3).*hCrho(1,1)+(-3).* hCrho(1,2)+(-3).*hCrho(8,1)+2.*hPrho(55,101)+2.*hPrho(55,102)+ hPrho(56,101)+hPrho(56,102)+hPrho(57,101)+hPrho(57,102)+2.* hPrho(58,101)+2.*hPrho(58,102)) ;




fig(2);clf;imagesc(hCrho);axis xy;colorbar
% caxis([5760 5820])

fig(3);clf;imagesc(hCrho - h);axis xy;colorbar

nc_varput(newFile,'h',hCrho);
