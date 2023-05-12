fileORIG = 'surf2_Jan.nc';
fileNEW  = 'surf2Mod_Jan.nc';

unix(['cp ',fileORIG,' ',fileNEW]);

dum = nc_varget(fileNEW,'Pair');
nc_varput(fileNEW,'Pair',dum*100);


dum = nc_varget(fileNEW,'Qair');
nc_varput(fileNEW,'Qair',dum/5000);
