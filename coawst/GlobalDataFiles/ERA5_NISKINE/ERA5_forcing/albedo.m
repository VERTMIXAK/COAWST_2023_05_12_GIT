sourceFile = 'site2/adaptor.mars.internal-1623173286.2878828-1391-27-c49242d3-0590-4aa3-ab1a-4c74b14b5b27.nc';
albedoFile = 'ROMSforcing/ERA5_2018_albedo.nc';

dum = nc_varget(albedoFile,'albedo');


aaa=5;



dum = round(0 .* dum -32762);

nc_varput(albedoFile,'albedo',dum);




% dum1 = nc_varget(sourceFile,'msnswrf');
% dum2 = nc_varget(sourceFile,'msdwswrf');
% 
% myAlbedo = 1 - dum1 ./ dum2;
% 
% sq(dum1(13,:,:))%%
% 
% fig(1);pcolor(sq(dum1(13,:,:)));shading flat;colorbar
% fig(2);pcolor(sq(dum2(13,:,:)));shading flat;colorbar
% 
% fig(10);pcolor(sq(myAlbedo(13,:,:)));shading flat;colorbar
% 
% 
% %%
% 
% fig(99);clf;
% sq(dum1(13,:,:)) ./ sq(dum2(13,:,:)); pcolor(ans);colorbar;shading flat








