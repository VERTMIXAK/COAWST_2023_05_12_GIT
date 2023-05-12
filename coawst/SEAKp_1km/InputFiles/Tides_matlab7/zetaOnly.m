origFile = 'AllComponents_2007.nc';
newFile  = 'AllComponents_zetaOnly_2007.nc';

unix(['cp ',origFile,' ',newFile]);

dum = nc_varget(newFile,'tide_Cangle');
nc_varput(newFile,'tide_Cangle',0*dum);

dum = nc_varget(newFile,'tide_Cphase');
nc_varput(newFile,'tide_Cphase',0*dum);

dum = nc_varget(newFile,'tide_Cmax');
nc_varput(newFile,'tide_Cmax',0*dum);

dum = nc_varget(newFile,'tide_Cmin');
nc_varput(newFile,'tide_Cmin',0*dum);