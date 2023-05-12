clear
fileU = 'u.nc'
fileV = 'v.nc'
gfile = 'GUAMHinner_1km.nc'
grd=roms_get_grid(gfile);
u_sur = nc_varget(fileU,'u_sur');
u_bar = nc_varget(fileU,'ubar');
u_bc=u_sur-u_bar;


% v_sur = nc_varget(fileV,'v_sur');
% v_bar = nc_varget(fileV,'vbar');
% v_bc=v_sur-v_bar;

[nt,ny,nx]=size(u_bc);

myJ = round(ny/2) + 3;

%% basic plot u

figure(1);clf;colormap(gray)
for tt=1:40
%  pcolor(grd.x_u/1e3,grd.y_u/1e3,squeeze(u_bc(48,:,:)));caxis([-1,1]/10);axis equal tight;shading flat
 pcolor(grd.x_u/1e3,grd.y_u/1e3,squeeze(u_bc(tt,:,:)));caxis([-1,1]/10);axis equal tight;shading flat;title('u')
 pause(.1)
end;
aaa=5;

%% basic plot v

% figure(1);clf;colormap(gray)
% for tt=1:50
% %  pcolor(grd.x_u/1e3,grd.y_u/1e3,squeeze(u_bc(48,:,:)));caxis([-1,1]/10);axis equal tight;shading flat
%  pcolor(grd.x_v/1e3,grd.y_v/1e3,squeeze(v_bc(tt,:,:)));caxis([-1,1]/10);axis equal tight;shading flat;title('v')
%  pause(.1)
% end;
% aaa=5;

%% Line plot
 
 
figure(11);clf;colormap(gray)
 pcolor(squeeze(u_bc(48,:,:)));caxis([-1,1]/10);axis equal tight;shading flat

figure(2);clf;colormap(gray)
 x = grd.x_u(myJ,:)/1e3;y= 1:96;dat = squeeze(u_bc(1:96,myJ,:));whos x y dat
 pcolor(x,y,dat);;caxis([-1,1]/10);axis xy;shading flat;
 


figure(3);clf
 plot(u_bc(:,myJ,80),'g','linew',2);hold on
 plot(u_bc(:,myJ,5),'r','linew',2);hold on
%  plot(u_bc(:,myJ,40),'k','linew',2);hold on
%  plot(u_bc(:,myJ,120),'b','linew',2);hold on
 legend('halfway from seamount to boundary','near boundary')
 
%% Traveling wave - u

figure(5);clf;colormap(gray)
for tt=1:50
    tt
 plot(sq(u_bc(tt,myJ,1:round(nx/2))));title('u');ylim(.1*[-1 1])
 pause(.1)
end;
aaa=5;
