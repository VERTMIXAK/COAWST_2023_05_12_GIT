% converts lat,lon to x,y(km) and back
% usage: [x,y]=xy_ll_AIS_2km(lon,lat,'F'); or
%        [lon,lat]=xy_ll_AIS_2km(x,y,'B');
function [x,y]=xy_ll_AIS_2km(lon,lat,BF);
if BF=='F', % lat,lon ->x,y
    [x,y]=mapll(lat,lon,71,70,'s');
else
     [lat,lon]=mapxy(x,y,71,70,'s');
end
return
 
