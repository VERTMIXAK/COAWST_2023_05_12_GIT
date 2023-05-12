clear; close all;tabwindow;

parentFile           = 'PRAIRIENest_3km_parent.nc';
childFile            = 'PRAIRIENest_3km_child.nc';

%% rho

ext = '_rho';

xParent = round(nc_varget(parentFile,['x',ext]));
yParent =round( nc_varget(parentFile,['y',ext]));
xChild = round(nc_varget(childFile,['x',ext]));
yChild = round(nc_varget(childFile,['y',ext]));

var = ['lat',ext];
vParent = nc_varget(parentFile,var);
vChild = interp2(xParent,yParent,vParent,xChild,yChild);
nc_varput(childFile,var,vChild);

var = ['lon',ext];
vParent = nc_varget(parentFile,var);
vChild = interp2(xParent,yParent,vParent,xChild,yChild);
nc_varput(childFile,var,vChild);

%% u

ext = '_u';

xParent = round(nc_varget(parentFile,['x',ext]));
yParent =round( nc_varget(parentFile,['y',ext]));
xChild = round(nc_varget(childFile,['x',ext]));
yChild = round(nc_varget(childFile,['y',ext]));

var = ['lat',ext];
vParent = nc_varget(parentFile,var);
vChild = interp2(xParent,yParent,vParent,xChild,yChild);
nc_varput(childFile,var,vChild);

var = ['lon',ext];
vParent = nc_varget(parentFile,var);
vChild = interp2(xParent,yParent,vParent,xChild,yChild);
nc_varput(childFile,var,vChild);

%% v

ext = '_v';

xParent = round(nc_varget(parentFile,['x',ext]));
yParent =round( nc_varget(parentFile,['y',ext]));
xChild = round(nc_varget(childFile,['x',ext]));
yChild = round(nc_varget(childFile,['y',ext]));

var = ['lat',ext];
vParent = nc_varget(parentFile,var);
vChild = interp2(xParent,yParent,vParent,xChild,yChild);
nc_varput(childFile,var,vChild);

var = ['lon',ext];
vParent = nc_varget(parentFile,var);
vChild = interp2(xParent,yParent,vParent,xChild,yChild);
nc_varput(childFile,var,vChild);

%% psi

ext = '_psi';

xParent = round(nc_varget(parentFile,['x',ext]));
yParent =round( nc_varget(parentFile,['y',ext]));
xChild = round(nc_varget(childFile,['x',ext]));
yChild = round(nc_varget(childFile,['y',ext]));

var = ['lat',ext];
vParent = nc_varget(parentFile,var);
vChild = interp2(xParent,yParent,vParent,xChild,yChild);
nc_varput(childFile,var,vChild);

var = ['lon',ext];
vParent = nc_varget(parentFile,var);
vChild = interp2(xParent,yParent,vParent,xChild,yChild);
nc_varput(childFile,var,vChild);
