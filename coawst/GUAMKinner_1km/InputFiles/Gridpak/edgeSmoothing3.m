oldGrid = 'GUAMKinner_1km.nc_origBathy';
newGrid = 'GUAMKinner_1km_edgeSmoothing.nc';
newGrid2= 'GUAMKinner_1km.nc'

unix(['cp ',oldGrid,' ',newGrid]);

h = nc_varget(newGrid,'h');

window=10;
h(1,:) = lowpass(h(1,:),window);
h(end,:) = lowpass(h(end,:),window);
h(:,1) = lowpass(h(:,1),window);
h(:,end) = lowpass(h(:,end),window);

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
fig(98);clf;plot(hWork(:,2))

aaa=5;

%% presmoothing

hWork(1,:) = lowpass(hWork(1,:),10);
hWork(end,:) = lowpass(hWork(end,:),10);
hWork(:,1) = lowpass(hWork(:,1),10);
hWork(:,end) = lowpass(hWork(:,end),10);

edgeW = 26;
edgeE = 16;
edgeS = 7;
edgeN = 7;

% Southern and Northern edges
for ii=2:NX-1
    hWork(     2:edgeS   ,ii) =  interp1([     2      edgeS], [hWork(   2     ,ii) hWork(edgeS,ii)],[2        :edgeS]);
    hWork(NY-edgeN+1:NY-1,ii) =  interp1([NY-edgeN+1   NY-1], [hWork(NY-edgeN+1,ii) hWork(NY-1,ii)],[NY-edgeN+1:NY-1]);
end;

% Western and Eastern edges
for jj=2:NY-1
    hWork(jj,     2:edgeW   ) =  interp1([     2      edgeW], [hWork(jj,   2     ) hWork(jj,edgeW)],[2        :edgeW]);
    hWork(jj,NX-edgeE+1:NX-1) =  interp1([NX-edgeE+1   NX-1], [hWork(jj,NX-edgeE+1) hWork(jj,NX-1)],[NX-edgeE+1:NX-1]);
end;



fig(32);clf;
plot(hWork(44,:))

aaa=5;

%% work 3x3
% This particular grid has telescoping bands 6 pixels wide on the N and S
% edges and 25 and 15 pixels width on the W and E edges.

% work from the interior to the N/S edges with 3x3 averages
hdum = hWork;

% South 
for jj=edgeS:-1:2
    for ii=2:NX-1
       hWork(jj-1:jj+1,ii-1:ii+1);  hdum(jj,ii) = nanmean(ans(:));
    end;
end;

% North
for jj=NY-1:-1:NY-edgeN+1
    for ii=2:NX-1
       hWork(jj-1:jj+1,ii-1:ii+1);  hdum(jj,ii) = nanmean(ans(:));
    end;
end;



% West
for ii=edgeW:-1:2
    for jj=2:NY-1
        hWork(jj-1:jj+1,ii-1:ii+1); hdum(jj,ii) = nanmean(ans(:));
    end;
end;

% East
for ii=NX-1:-1:NX-edgeE+1
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
