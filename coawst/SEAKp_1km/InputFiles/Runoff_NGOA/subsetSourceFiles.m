clear;close all;

oldDir = 'sourceData_ORIG/';
newDir = 'sourceData_subset/';
file   = 'goa_dischargex_09012017_08312018.nc';

unix(['\rm ',newDir,file]);

lat = nc_varget([oldDir,file],'lat');
lon = nc_varget([oldDir,file],'lon');
  q = nc_varget([oldDir,file],'q');
  
lon0 = -138;
lon1 = -130.5;
lat0 = 53;
lat1 = 59.5;

ndx = find(lon>lon0 & lon<lon1 & lat>lat0 & lat<lat1);
latNew = lat(ndx);
lonNew = lon(ndx);
qNew   = q(:,ndx);


unix(['ncks -d timeSeries,0,',num2str(length(ndx)-1),' ',oldDir,file,' ',newDir,file   ])

nc_varput([newDir,file],'lat',latNew);
nc_varput([newDir,file],'lon',lonNew);
nc_varput([newDir,file],'q',qNew);