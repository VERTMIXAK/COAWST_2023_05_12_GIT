myFiles = dir('runs*.nc');

for nn=1:length(myFiles)
    file = myFiles(nn).name
    
    zeta = nc_varget(file,'zeta');
    mask = nc_varget(file,'mask_rho');
    [nt,ny,nx] = size(zeta);
    
    yrange = [70:100];
    xrange = [100:150];
    
    fig(1);clf;pcolor(sq(zeta(1,yrange,xrange)));shading flat
    fig(2);clf;pcolor(mask(yrange,xrange));shading flat
    
    zetaOld = zeta;
    for tt=1:nt;
        tt
            for ii=1:nx;for jj=10:ny-10
%                 [tt,jj,ii]
            if isnan(zetaOld(tt,jj,ii))
                zeta(tt,jj,ii) = nanmean(zetaOld(tt,jj-2:jj+2,ii));
            end
        end;end;end
    
    fig(3);clf;pcolor(sq(zeta(1,yrange,xrange)));shading flat
    

    nc_varput(file,'zeta',zeta);
end;
