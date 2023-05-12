tideFile = 'NORSEc_4km_tides.nc';

%% tide_Eamp
var = 'tide_Eamp';

dum = nc_varget(tideFile,var);
[nTides,ny,nx] = size(dum);

fig(1);clf; pcolor(sq(dum(1,:,:)));shading flat


for jj=1:ny
    for ii=2:200;
        if isnan(dum(1,jj,ii))
            [jj,ii]
            for nn=1:nTides
                dum(nn,jj,ii) = nanmean(dum(nn,jj,ii-1:ii+1));
            end;
        end;    
end;end

fig(1);clf; pcolor(sq(dum(1,:,:)));shading flat

nc_varput(tideFile,var,dum);


%% tide_Ephase
var = 'tide_Ephase';

dum = nc_varget(tideFile,var);
[nTides,ny,nx] = size(dum);

fig(1);clf; pcolor(sq(dum(1,:,:)));shading flat


for jj=1:ny
    for ii=2:200;
        if isnan(dum(1,jj,ii))
            [jj,ii]
            for nn=1:nTides
                dum(nn,jj,ii) = nanmean(dum(nn,jj,ii-1:ii+1));
            end;
        end;    
end;end

fig(1);clf; pcolor(sq(dum(1,:,:)));shading flat

nc_varput(tideFile,var,dum);


%% tide_Cmin
var = 'tide_Cmin';

dum = nc_varget(tideFile,var);
[nTides,ny,nx] = size(dum);

fig(1);clf; pcolor(sq(dum(1,:,:)));shading flat


for jj=1:ny
    for ii=2:200;
        if isnan(dum(1,jj,ii))
            [jj,ii]
            for nn=1:nTides
                dum(nn,jj,ii) = nanmean(dum(nn,jj,ii-1:ii+1));
            end;
        end;    
end;end

fig(1);clf; pcolor(sq(dum(1,:,:)));shading flat

nc_varput(tideFile,var,dum);


%% tide_Cmax
var = 'tide_Cmax';

dum = nc_varget(tideFile,var);
[nTides,ny,nx] = size(dum);

fig(1);clf; pcolor(sq(dum(1,:,:)));shading flat


for jj=1:ny
    for ii=2:200;
        if isnan(dum(1,jj,ii))
            [jj,ii]
            for nn=1:nTides
                dum(nn,jj,ii) = nanmean(dum(nn,jj,ii-1:ii+1));
            end;
        end;    
end;end

fig(1);clf; pcolor(sq(dum(1,:,:)));shading flat

nc_varput(tideFile,var,dum);


%% tide_Cangle
var = 'tide_Cangle';

dum = nc_varget(tideFile,var);
[nTides,ny,nx] = size(dum);

fig(1);clf; pcolor(sq(dum(1,:,:)));shading flat


for jj=1:ny
    for ii=2:200;
        if isnan(dum(1,jj,ii))
            [jj,ii]
            for nn=1:nTides
                dum(nn,jj,ii) = nanmean(dum(nn,jj,ii-1:ii+1));
            end;
        end;    
end;end

fig(1);clf; pcolor(sq(dum(1,:,:)));shading flat

nc_varput(tideFile,var,dum);


%% tide_Cphase
var = 'tide_Cphase';

dum = nc_varget(tideFile,var);
[nTides,ny,nx] = size(dum);

fig(1);clf; pcolor(sq(dum(1,:,:)));shading flat


for jj=1:ny
    for ii=2:200;
        if isnan(dum(1,jj,ii))
            [jj,ii]
            for nn=1:nTides
                dum(nn,jj,ii) = nanmean(dum(nn,jj,ii-1:ii+1));
            end;
        end;    
end;end

fig(1);clf; pcolor(sq(dum(1,:,:)));shading flat

nc_varput(tideFile,var,dum);



