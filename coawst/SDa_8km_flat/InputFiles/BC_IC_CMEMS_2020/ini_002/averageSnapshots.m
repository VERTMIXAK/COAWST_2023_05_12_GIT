file1 = 'GLOBAL_ANALYSIS_FORECAST_PHY_001_024-TDS_2020_001.5_ic_SDa_8km_flat.nc';
file2 = 'GLOBAL_ANALYSIS_FORECAST_PHY_001_024-TDS_2020_002.5_ic_SDa_8km_flat.nc';
outFile = 'CMEMS_2020_002_ic_SDa_8km_flat.nc';

unix(['cp ',file1,' ',outFile]);

var = 'ocean_time';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
nc_varput(outFile,var,dum);


var = 'zeta';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
clear temp;temp(1,:,:) = dum;
nc_varput(outFile,var,temp);


var = 'temp';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
clear temp;temp(1,:,:,:) = dum;
nc_varput(outFile,var,temp);


var = 'salt';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
clear temp;temp(1,:,:,:) = dum;
nc_varput(outFile,var,temp);


var = 'u';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
clear temp;temp(1,:,:,:) = dum;
nc_varput(outFile,var,temp);


var = 'ubar';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
clear temp;temp(1,:,:) = dum;
nc_varput(outFile,var,temp);


var = 'v';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
clear temp;temp(1,:,:,:) = dum;
nc_varput(outFile,var,temp);


var = 'vbar';
dum1 = nc_varget(file1,var);
dum2 = nc_varget(file2,var);
dum  = (dum1 + dum2)/2;
clear temp;temp(1,:,:) = dum;
nc_varput(outFile,var,temp);

