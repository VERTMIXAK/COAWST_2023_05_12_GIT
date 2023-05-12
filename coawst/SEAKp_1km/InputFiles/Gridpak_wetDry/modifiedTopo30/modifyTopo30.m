clear;

bathyOrig = '/import/c1/VERTMIX/jgpender/ROMS/BathyData/topo30.Gridpak_SEAK.nc';

bathyShift = 'topo30.Gridpak_SEAK_shift.nc';
bathyNew   = 'topo30.Gridpak_SEAK_shiftSmooth.nc';


unix(['cp ',bathyOrig,' ',bathyShift ]);

topo = nc_varget(bathyShift,'topo');
lat  = nc_varget(bathyShift,'topo_lat') - .01;

nc_varput(bathyShift,'topo_lat',lat);
unix(['cp ',bathyShift,' ',bathyNew ]);

topoOrig = topo;

mask = (sign(topo)+1)/2;
mask2 = mask;
mask(mask==1) = nan;

topoTemp = topo .* (1.-mask);

[ny,nx] = size(topo);

ivec = [4500:5500];
jvec = [2500:3700];

fig(1);clf;
pcolor(ivec,jvec,topoTemp(jvec,ivec));shading flat;colorbar

fig(11);clf;
pcolor(ivec,jvec,topoTemp(jvec,ivec)-topo(jvec,ivec));shading flat;colorbar

% for ii=ivec; for jj=jvec
for ii=5:nx-5; for jj=5:ny-5
    if ~isnan(topoTemp(jj,ii))
        topoTemp(jj-1:jj+1,ii-1:ii+1);
        topo(jj,ii) = nanmean(ans(:)  );
    end
end;end;

nc_varput(bathyNew,'topo',topo);

fig(2);clf;
pcolor(ivec,jvec,topoOrig(jvec,ivec)-topo(jvec,ivec));shading flat;colorbar;caxis([-100 100])




