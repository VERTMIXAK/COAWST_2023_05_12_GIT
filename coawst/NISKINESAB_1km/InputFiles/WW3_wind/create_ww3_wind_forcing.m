clear;

% to create ww3 wind forcing file.
%
% jcwarner 13Nov2017
%

% This is very hacky for now. In future we will provide 
% a file that directly reads NCEP data and writes out a
% WW3 wind forcing ascii file.
%

% uFile = '~/coawst/GlobalDataFiles/MERRA_NISKINE/MERRA_Uwind_1hours_2018.nc';
% vFile = '~/coawst/GlobalDataFiles/MERRA_NISKINE/MERRA_Vwind_1hours_2018.nc';

uFile = '~/coawst/GlobalDataFiles/JRA_NISKINE/JRA55DO_1.4_Uwind_2018_NISKINE.nc';
vFile = '~/coawst/GlobalDataFiles/JRA_NISKINE/JRA55DO_1.4_Vwind_2018_NISKINE.nc';



netcdf_load(uFile)
netcdf_load(vFile)
wind_time = time;
[LP, MP, ntimes]=size(Uwind);

lon1d = lon;
lat1d = lat;

lon = repmat(lon1d,[1,MP]);
lat = repmat(lat1d',[LP,1]);


aaa=5;



%% diag stuff

% ivec=[61:71];lon(ivec)';
% jvec=[12:17];lat(jvec);
% 
% myT=1135-38;
% 
% datevec(wind_time(myT)+datenum(1900,1,1,0,0,0))

% fig(1);clf;pcolor(sq(Uwind(ivec,jvec,myT)));colorbar;title('Uwind')
% fig(2);clf;pcolor(sq(Vwind(ivec,jvec,myT)));colorbar;title('Vwind')




%% resume

fid = fopen('ww3_NISKINESAB_1km_wind_forc.dat','w');
% for mm=1:ntimes
for mm=1040:1280
%   for mm=1073:1073
% write time stamp
  zz=datevec(wind_time(mm)+datenum(1900,1,1,0,0,0));
  zz1=num2str(zz(1));
  zz2=['00',num2str(zz(2))];zz2=zz2(end-1:end);
  zz3=['00',num2str(zz(3))];zz3=zz3(end-1:end);
  zz4=['00',num2str(zz(4))];zz4=zz4(end-1:end);
  zz5=['00',num2str(zz(5))];zz5=zz5(end-1:end);
  zz6=['00',num2str(zz(6))];zz6=zz6(end-1:end);
  dtstr=[zz1,zz2,zz3,' ',zz4,zz5,zz6]
  fprintf(fid,'%15s',dtstr);
  fprintf(fid,'\n');
  zzu=squeeze(Uwind(:,:,mm));
  zzv=squeeze(Vwind(:,:,mm));
  
  % jgp add
%   zzu=0*zzu;
%   zzv=0*zzv;
  % jgp end
    
%   fig(1);clf;pcolor(zzu);colorbar;title('Uwind');shading flat;
%   fig(11);clf;pcolor(lon,lat,zzu);colorbar;title('Uwind');shading flat;
  
  for index1 = 1:MP;
    fprintf(fid,'%12.4f',zzu(:,index1));
    fprintf(fid,'\n');
  end
  for index1 = 1:MP;
    fprintf(fid,'%12.4f',zzv(:,index1));
    fprintf(fid,'\n');
  end
end
fclose(fid);



