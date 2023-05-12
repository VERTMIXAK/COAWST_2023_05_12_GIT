clear;

oldFile = 'NG_100m.nc_ORIG';
newFile = 'NG_100m.nc';

unix(['cp ',oldFile,' ',newFile]);

aaa=5;

hraw = nc_varget(newFile,'hraw');
[~,ny,nx] = size(hraw);

htemp = sq(hraw(2,:,:));

x0 = 190;
x1 = 550;
y0 = 450;
y1 = 650;

fig(1);clf;
pcolor(htemp);shading flat;hold on
plot([x0 x1],[y0 y1],'r')

slope = (y1-y0)/(x1-x0);
mask = 1 +  0*htemp;
for ii=x0:x1; for jj=y0:ny-3
	if jj > y0 + slope * (ii - x0)
        mask(jj,ii) = 0;
    end
end;end;

% fig(10);clf;
% pcolor(mask );shading flat



myI=[255:340];
myJ=[500:660];
fig(2);clf;
pcolor(myI,myJ,htemp(myJ,myI));shading flat


aaa=5;

delta = 2;
% for jj=1:ny; for ii=1:nx
for jj=3:ny-3; for ii=3:nx-3
%     if mask(jj,ii) == 0 
        hraw(2,jj-delta:jj+delta,ii-delta:ii+delta);
        htemp(jj,ii) = nanmean(ans(:));
%     end;
end;end;

% for jj=1:ny; for ii=1:nx
for jj=3:ny-3; for ii=3:nx-3
%     if mask(jj,ii) == 0 
        hraw(2,jj-delta:jj+delta,ii-delta:ii+delta);
        htemp(jj,ii) = nanmean(ans(:));
%     end;
end;end;

% for jj=1:ny; for ii=1:nx
for jj=3:ny-3; for ii=3:nx-3
%     if mask(jj,ii) == 0 
        hraw(2,jj-delta:jj+delta,ii-delta:ii+delta);
        htemp(jj,ii) = nanmean(ans(:));
%     end;
end;end;

fig(3);clf;
pcolor(myI,myJ,htemp(myJ,myI));shading flat


% fig(4);clf
% pcolor(htemp - sq(hraw(2,:,:)));shading flat;colorbar


hraw(3,:,:) = htemp;
nc_varput(newFile,'hraw',hraw);
