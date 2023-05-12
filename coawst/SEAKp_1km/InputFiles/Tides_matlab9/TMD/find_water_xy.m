function [x_new,y_new]=find_water_xy(Model,x,y,R)

% Find nearest water for polar stereo models.

x_new=NaN*ones(size(x));
y_new=NaN*ones(size(y));

% R is search radius in km

% Get model bathy grid
[xg,yg,H]=get_bathy(Model);
loc=find(H==0); H(loc)=NaN; clear loc;
mask=isnan(H);
dx=mean(diff(xg));
dy=mean(diff(yg));
[ny nx]=size(H);

% Find nearest ocean point for each GZ point
for i=1:length(x);
    
    nx_search=round(R/dx);
    ny_search=round(R/dy);
    
    %disp([num2str(i) '/' num2str(length(lon))]);
    ix=round((x(i)-min(xg))/dx)+1;
    iy=round((y(i)-min(yg))/dy)+1;
    ix1=max([ix-nx_search 1]); ix2=min([ix+nx_search nx]);
    iy1=max([iy-ny_search 1]); iy2=min([iy+ny_search ny]);
    distmin=1e34; indx=NaN; indy=NaN;
    for iy=iy1:iy2
        for ix=ix1:ix2
            dist=sqrt((x(i)-xg(ix)).^2+(y(i)-yg(iy)).^2);
            if(dist<distmin && mask(iy,ix)==0);
                indy=iy; indx=ix;
                distmin=dist;
            end
        end
    end
    %disp([ix1 ix2 iy1 iy2 nx ny nx_search ny_search])
    if(~isnan(indx));
        x_new(i)=xg(indx);
        y_new(i)=yg(indy);
    else
        x_new(i)=NaN; y_new(i)=NaN;
    end
end
return