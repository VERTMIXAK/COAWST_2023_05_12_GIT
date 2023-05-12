sourceFile = '../../BC_IC/ini_a/lake_jersey_ini_a.nc';
newFile =             'lake_jersey_ini_a.nc';
gridFile =   '../../Gridpak_seamount_parentOnly/lake_jersey_grd_a.nc';

unix(['cp ',sourceFile,' ',newFile]);
h = nc_varget(gridFile,'h');
size(h)
nc_varput(newFile,'h',h);

% tcline = nc_varget(newFile,'Tcline');
% tcline = 5;
% nc_varput(newFile,'Tcline',tcline);



