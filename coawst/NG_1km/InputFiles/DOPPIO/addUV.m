myFiles = dir('runs*.nc');

for nn=1:length(myFiles)
    file = myFiles(nn).name
    uvSource = [file,'.1']
    
    
    dum.Name = 'u_eastward';
    dum.Nctype = 'double';
    dum.Dimension = {'ocean_time','s_rho','eta_rho','xi_rho'};
%     dum.Coordinates = {'ocean_time','s_rho','eta_rho','xi_rho'};
    dum.Attribute = struct('Name',{'long_name','units','field','time','_FillValue'},'Value',{'eastward momentum component','m s-1','u_eastward,scalar,series','ocean_time',1.e+37});
    nc_addvar(file,dum);    
    
    dataSmall = nc_varget(uvSource,'u_eastward');
%     [nz,ny,nx] = size(dataSmall);
%     data = zeros(1,nz,ny,nx); 
%     data(1,:,:,:) = dataSmall;
%     nc_varput(file,'u_eastward',data);
    nc_varput(file,'u_eastward',dataSmall);
    
    
    
    dum.Name = 'v_northward';
    dum.Nctype = 'double';
    dum.Dimension = {'ocean_time','s_rho','eta_rho','xi_rho'};
%     dum.Coordinates = {'ocean_time','s_rho','eta_rho','xi_rho'};
    dum.Attribute = struct('Name',{'long_name','units','field','time','_FillValue'},'Value',{'northward momentum component','m s-1','v_northward,scalar,series','ocean_time',1.e+37});
    nc_addvar(file,dum);    
    
    dataSmall = nc_varget(uvSource,'v_northward');
%     [nz,ny,nx] = size(dataSmall);
%     data = zeros(1,nz,ny,nx); 
%     data(1,:,:,:) = dataSmall;
%     nc_varput(file,'v_northward',data);  
    nc_varput(file,'v_northward',dataSmall);    
    
    
    
    dum.Name = 'ubar_eastward';
    dum.Nctype = 'double';
    dum.Dimension = {'ocean_time','eta_rho','xi_rho'};
%     dum.Coordinates = {'ocean_time','eta_rho','xi_rho'};
    dum.Attribute = struct('Name',{'long_name','units','field','time','_FillValue'},'Value',{'eastward vertically integrated momentum component','m s-1','ubar_eastward,scalar,series','ocean_time',1.e+37});
    nc_addvar(file,dum);    
    
    dataSmall = nc_varget(uvSource,'ubar_eastward');
%     [ny,nx] = size(dataSmall);
%     data = zeros(1,ny,nx); 
%     data(1,:,:) = dataSmall;
%     nc_varput(file,'ubar_eastward',data);
    nc_varput(file,'ubar_eastward',dataSmall);
    
    
    
    dum.Name = 'vbar_northward';
    dum.Nctype = 'double';
    dum.Dimension = {'ocean_time','eta_rho','xi_rho'};
%     dum.Coordinates = {'ocean_time','eta_rho','xi_rho'};
    dum.Attribute = struct('Name',{'long_name','units','field','time','_FillValue'},'Value',{'northward vertically integrated momentum component','m s-1','vbar_northward,scalar,series','ocean_time',1.e+37});
    nc_addvar(file,dum);    
    
    dataSmall = nc_varget(uvSource,'vbar_northward');
%     [ny,nx] = size(dataSmall);
%     data = zeros(1,ny,nx); 
%     data(1,:,:) = dataSmall;
%     nc_varput(file,'vbar_northward',data);
    nc_varput(file,'vbar_northward',dataSmall);
    
end;