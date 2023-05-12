function wvs = hls_get_wvs(bb)
%lon0 = -167.5;lon1 = -151.0;lat0  = 69.3;lat1 = 73.0; % chukchi
%lon0 = -360  ;lon1 = 360   ; lat0 = -90 ;lat1 = 90;        % earth
%bbox2 =[   [lon0;lon1]  [lat0;lat1 ]] 
outfile = 'coastCheck.mat';
if ~exist(outfile);
bb2 = [   [bb(1);bb(2)]  [bb(3);bb(4) ]]; 
[a1,a2]=shaperead('/import/VERTMIXFS/hlsimmons/DATA/global_mapper_data/world_vector_shoreline/world_vector_shoreline.shp', 'UseGeoCoords', true,'BoundingBox',bb2);
%%
wvs.lon=[];wvs.lat=[];
for ii = 1:length(a1);disp(ii/length(a1))
    wvs.lon=[wvs.lon a1(ii).Lon];wvs.lat = [wvs.lat a1(ii).Lat];
end
    str = sprintf('save %s wvs',outfile);disp(str);eval(str);
else
    str = sprintf('load %s wvs',outfile);%disp(str)
    eval(str);
end
%%
%%
