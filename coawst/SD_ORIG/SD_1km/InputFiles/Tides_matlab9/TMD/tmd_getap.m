function [x,y,amp,phase]=tmd_getap(cname,gname,type)

%% function to extract tidal amp and phase coefficient grids from a 
%% single-constituent model file 
%
% usage:
% [x,y,umaj,umin,uphase,uincl]=get_ellipse(Model,cons);
% 
% Model - control file name for a tidal model, consisting of lines
%         <elevation file name>
%         <transport file name>
%         <grid file name>
%         <function to convert lat,lon to x,y>
% 4th line is given only for models on cartesian grid (in km)
% All model files should be provided in OTIS format
% cons - tidal constituent given as char* 
%
% output:
% umaj,umin - major and minor ellipse axis (cm/s)
% uphase, uincl - ellipse phase and inclination degrees GMT
% x,y - grid coordinates
%
% sample call:
% [x,y,umaj,umin,uphase,uincl]=get_ellipse('DATA/Model_Ross_prior','k1');
%





[h,y_lim,x_lim] = h_in('h0.WS_test1.out',1);
[n,m]=size(h);
[x,y]=XY([x_lim;y_lim],n,m);
amp=abs(h); % amplitude (m)
phase=atan2(-imag(h),real(h))/pi*180; % phase(deg)
 
For transports U and V, use "u_in" instead as:
 
[U,V,y_lim,x_lim] = u_in('u0.WS_test1.out',1);
 
Amplitude of TRANSPORTS  will be in m2/s.
To get velocities devide by depth (use script grd_in in the TMD to read in bathymetry) as:
 
[xy_lims,hz,mz,iob,dt] =  grd_in('grid1');
[hu,hv] = Huv(hz);
u=U./hulv=V./hv; % velocities in m/s
 
Find amplitude and phase similar as for elevations,
end
