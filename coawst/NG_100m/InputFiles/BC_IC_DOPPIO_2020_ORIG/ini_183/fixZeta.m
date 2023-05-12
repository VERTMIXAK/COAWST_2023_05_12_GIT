    oldFile = 'Source_2020_07_01.nc_ORIG';
    file = 'Source_2020_07_01.nc';
    
    unix(['cp ',oldFile,' ',file]);
    
    zeta = nc_varget(file,'zeta');
    [ny,nx] = size(zeta);
    
    
    fig(1);clf;pcolor(zeta);shading flat
    
    for nn=1:10
    zetaOld = zeta;
    for ii=1:nx;for jj=3:ny-3
            if isnan(zetaOld(jj,ii))
                zeta(jj,ii) = nanmean(zetaOld(jj-2:jj+2,ii));
            end
        end;end
    end;
    
    fig(3);clf;pcolor(zeta);shading flat
    
    dum = zeros(1,ny,nx);
    dum(1,:,:) = zeta;
    nc_varput(file,'zeta',dum);


