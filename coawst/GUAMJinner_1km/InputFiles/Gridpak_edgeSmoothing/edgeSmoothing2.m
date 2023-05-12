oldGrid = 'GUAMJinner_1km.nc_regMask';
newGrid = 'GUAMJinner_1km_edgeSmoothing.nc';
newGrid2= 'GUAMJinner_1km.nc'

unix(['cp ',oldGrid,' ',newGrid]);

h = nc_varget(newGrid,'h');
hOrig=h;
[ny,nx] = size(h);

hWork = nan(ny+2,nx+2);hWork(2:end-1,2:end-1) = h;
[NY,NX] = size(hWork);



fig(1);clf;
pcolor(h);shading flat

fig(2);clf;
plot(h(44,:))

fig(3);clf;
plot( h(1:20,50))

fig(4);clf;
plot(h(44,end-20:end))

fig(5);clf;
pcolor(h(40:47,end-7:end));shading flat;colorbar


%% work 3x3
% This particular grid has telescoping bands 6 pixels wide on the N and S
% edges and 15 pixels wid on the E and W edges.

% work from the interior to the N/S edges with 3x3 averages
edge = 8;
hdum = hWork;

% for jj=2:edge
for jj=edge:-1:2
    for ii=2:NX-1
       hWork(jj-1:jj+1,ii-1:ii+1);  hdum(jj,ii) = nanmean(ans(:));
    end;
end;

% for jj=ny-edge+1:ny-1
for jj=NY-1:-1:NY-edge+1
    for ii=2:NX-1
       hWork(jj-1:jj+1,ii-1:ii+1);  hdum(jj,ii) = nanmean(ans(:));
    end;
end;


% work in from the E/W edges
edge = 18;

% for ii=2:edge
for ii=edge:-1:2
    for jj=2:NY-1
        hWork(jj-1:jj+1,ii-1:ii+1); hdum(jj,ii) = nanmean(ans(:));
    end;
end;

% for ii=nx-edge+1:nx-1
for ii=NX-1:-1:NX-edge+1
    for jj=2:NY-1
        hWork(jj-1:jj+1,ii-1:ii+1); hdum(jj,ii) = nanmean(ans(:));
    end;
end;

hWork = hdum;


%% final assignment


h = hWork(2:end-1,2:end-1);




%% Plots and write to file

fig(12);clf;
plot(h(44,:))

fig(13);clf;
plot( h(1:20,50))

fig(14);clf;
plot(h(44,end-20:end))

fig(15);clf;
imagesc(h(40:47,end-7:end));axis xy;colorbar

fig(11);clf;
pcolor(h);shading flat

fig(21);clf;
pcolor(h-hOrig);shading flat;colorbar


nc_varput(newGrid,'h',h);
nc_varput(newGrid2,'h',h);
