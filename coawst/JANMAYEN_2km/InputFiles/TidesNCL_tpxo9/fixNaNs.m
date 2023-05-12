oldFile = 'JANMAYEN_2km_tides.nc_ORIG';
newFile = 'JANMAYEN_2km_tides.nc';

unix(['cp ',oldFile,' ',newFile]);

%% tide_Eamp

dum = nc_varget(newFile,'tide_Eamp');
fig(1);clf;
pcolor(sq(dum(1,:,:)));shading flat

[nT,ny,nx] = size(dum)

for nn=1:nT; for jj=1:ny; for ii=1:nx
    if isnan(dum(nn,jj,ii))
        dum(nn,jj,ii) = nanmean(dum(nn,jj,ii-1:ii+1));
    end;
end;end;end;

nc_varput(newFile,'tide_Eamp',dum);

%% tide_Ephase

dum = nc_varget(newFile,'tide_Ephase');
fig(1);clf;
pcolor(sq(dum(1,:,:)));shading flat

[nT,ny,nx] = size(dum)

for nn=1:nT; for jj=1:ny; for ii=1:nx
    if isnan(dum(nn,jj,ii))
        dum(nn,jj,ii) = nanmean(dum(nn,jj,ii-1:ii+1));
    end;
end;end;end;

nc_varput(newFile,'tide_Ephase',dum);

%% tide_Cmax

dum = nc_varget(newFile,'tide_Cmax');
fig(1);clf;
pcolor(sq(dum(1,:,:)));shading flat

[nT,ny,nx] = size(dum)

for nn=1:nT; for jj=1:ny; for ii=1:nx
    if isnan(dum(nn,jj,ii))
        dum(nn,jj,ii) = nanmean(dum(nn,jj,ii-1:ii+1));
    end;
end;end;end;

nc_varput(newFile,'tide_Cmax',dum);

%% tide_Cmin

dum = nc_varget(newFile,'tide_Cmin');
fig(1);clf;
pcolor(sq(dum(1,:,:)));shading flat

[nT,ny,nx] = size(dum)

for nn=1:nT; for jj=1:ny; for ii=1:nx
    if isnan(dum(nn,jj,ii))
        dum(nn,jj,ii) = nanmean(dum(nn,jj,ii-1:ii+1));
    end;
end;end;end;

nc_varput(newFile,'tide_Cmin',dum);

%% tide_Cangle

dum = nc_varget(newFile,'tide_Cangle');
fig(1);clf;
pcolor(sq(dum(1,:,:)));shading flat

[nT,ny,nx] = size(dum)

for nn=1:nT; for jj=1:ny; for ii=1:nx
    if isnan(dum(nn,jj,ii))
        dum(nn,jj,ii) = nanmean(dum(nn,jj,ii-1:ii+1));
    end;
end;end;end;

nc_varput(newFile,'tide_Cangle',dum);

%% tide_Cphase

dum = nc_varget(newFile,'tide_Cphase');
fig(1);clf;
pcolor(sq(dum(1,:,:)));shading flat

[nT,ny,nx] = size(dum)

for nn=1:nT; for jj=1:ny; for ii=1:nx
    if isnan(dum(nn,jj,ii))
        dum(nn,jj,ii) = nanmean(dum(nn,jj,ii-1:ii+1));
    end;
end;end;end;

nc_varput(newFile,'tide_Cphase',dum);
