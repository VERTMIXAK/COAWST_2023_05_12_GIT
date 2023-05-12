sourceFile = '../../BC_IC/ini_b/lake_jersey_ini_b.nc';
newFile =             'lake_jersey_ini_b.nc';
gridFile =   '../../Gridpak_seamount_straddleContact/lake_jersey_grd_b.nc';

unix(['cp ',sourceFile,' ',newFile]);
h = nc_varget(gridFile,'h');
size(h)
nc_varput(newFile,'h',h);

% tcline = nc_varget(newFile,'Tcline');
% tcline = 5;
% nc_varput(newFile,'Tcline',tcline);



