clear

grd1 = roms_get_grid('LJ_500m_parent.nc')
grd2 = roms_get_grid('LJ_500m_child.nc')
%%
% % % get indices of parent grid associated with edge of child grid
% % xpsi2_south = grd2.x_psi(1,:);
% % clear iMin 
% % [jMin,iMin] = hls_nearest_2d(grd1.x_psi,grd1.y_psi,grd2.x_psi(1  ,  1),grd2.y_psi(1  ,1  ));
% % [jMin,iMin] = hls_nearest_2d(grd1.x_psi,grd1.y_psi,grd2.x_psi(1  ,end),grd2.y_psi(1  ,end));
% % [jMax,iMax] = hls_nearest_2d(grd1.x_psi,grd1.y_psi,grd2.x_psi(end,end),grd2.y_psi(end,end));

jMin = 12;
jMax = 45;
iMin = 9;
iMax = 31;

%%
figure(1);clf;set(gcf,'color','w')
buf = 10
clear ax
ax(1)=subplot(2,2,1);%pcolor(grd1.x_rho/1e3,grd1.y_rho/1e3, grd1.h);shading flat;colorbar;caxis([3000 6000]);
               plot(grd1.x_rho/1e3,grd1.y_rho/1e3, 'ro');rect;hold on
               plot(grd2.x_rho/1e3,grd2.y_rho/1e3, 'k.');
%                hlim([grd2.bbkm(1)-buf grd2.bbkm(2)+buf grd2.bbkm(3)-buf grd2.bbkm(4)+buf]);
               zoom on;title('h-points')
 
ax(2)=subplot(2,2,2);%pcolor(grd1.x_rho/1e3,grd1.y_rho/1e3, grd1.h);shading flat;colorbar;caxis([3000 6000]);rect;hold on
               plot(grd1.x_u/1e3,grd1.y_u/1e3, 'ro');rect;hold on
               plot(grd2.x_u/1e3,grd2.y_u/1e3, 'k.');
%                hlim([grd2.bbkm(1)-buf grd2.bbkm(2)+buf grd2.bbkm(3)-buf grd2.bbkm(4)+buf]);
               zoom on;title('u-points')
 
ax(3)=subplot(2,2,3);%pcolor(grd1.x_rho/1e3,grd1.y_rho/1e3, grd1.h);shading flat;colorbar;caxis([3000 6000]);rect;hold on
               plot(grd1.x_v/1e3,grd1.y_v/1e3, 'ro');rect;hold on
               plot(grd2.x_v/1e3,grd2.y_v/1e3, 'k.');
%                hlim([grd2.bbkm(1)-buf grd2.bbkm(2)+buf grd2.bbkm(3)-buf grd2.bbkm(4)+buf]);
               zoom on;title('v-points')
ax(4)=subplot(2,2,4);
               %pcolor(grd1.x_rho/1e3,grd1.y_rho/1e3, grd1.h);shading flat;colorbar;caxis([3000 6000]);rect;hold on
               plot(grd1.x_psi/1e3,grd1.y_psi/1e3, 'ro');rect;hold on
               plot(grd2.x_psi/1e3,grd2.y_psi/1e3, 'k.');
%               hlim([grd2.bbkm(1)-buf grd2.bbkm(2)+buf grd2.bbkm(3)-buf grd2.bbkm(4)+buf]);
               
               zoom on;title('psi-points, lower right corner')
linkaxes(ax,'xy')
hlim([-2 2 -335 -331]);
%%
% parent and child have coincident psi points. psi_parent should be EXACTLY
% equal to psi_child, subsampled 3:1
 
%        x_rho: [356Ã—420 double]
%        x_u  : [356Ã—419 double]
%        x_v  : [355Ã—420 double]
%        x_psi: [355Ã—419 double]
 
clear *atpsi*
hatpsi1 = (grd1.h(2:end,2:end)+grd1.h(1:end-1,1:end-1))/2;
hatpsi2 = (grd2.h(2:end,2:end)+grd2.h(1:end-1,1:end-1))/2;
xatpsi1 = (grd1.x_rho(2:end,2:end)+grd1.x_rho(1:end-1,1:end-1))/2;
xatpsi2 = (grd2.x_rho(2:end,2:end)+grd2.x_rho(1:end-1,1:end-1))/2;
yatpsi1 = (grd1.y_rho(2:end,2:end)+grd1.y_rho(1:end-1,1:end-1))/2;
yatpsi2 = (grd2.y_rho(2:end,2:end)+grd2.y_rho(1:end-1,1:end-1))/2;
 
whos *atpsi1
whos *atpsi2
 
figure(2);clf;set(gcf,'color','w')
buf = 0%.025
subplot(2,2,1);
               plot(grd1.x_psi/1e3,grd1.y_psi/1e3, 'r.','markersi',12);rect;hold on
               plot(xatpsi1/1e3+buf,yatpsi1/1e3+buf, 'ro','linew',2,'markersi',12);rect;hold on
               plot(xatpsi2/1e3+buf,yatpsi2/1e3-buf, 'k.');rect;hold on
               plot(grd2.x_psi(:,end)/1e3,grd2.y_psi(:,end)/1e3, 'bp-','linew',2,'markersi',12);
               plot(grd2.x_psi(1,:)/1e3,grd2.y_psi(1,:)/1e3, 'bp-','linew',2,'markersi',12);
%legend('parent interpolated to psi points','child interpolated to psi points','child psi points','child psi points')
         hlim([-1.5 1.5 -335 -331]);  
         title('red o (psi_1 from rho_1 points), red . (psi_1 points), black dots (rho_2 from psi_2),bp (psi_2 points)')
subplot(2,2,2)
 
 
plot(grd1.x_psi(jMin:jMin,iMin:iMin)/1e3,...
     grd1.y_psi(jMin:jMin,iMin:iMin)/1e3, 'r.','markersi',12);hold on;rect
plot(grd1.x_psi(jMin:jMax,iMin:iMax)/1e3,...
     grd1.y_psi(jMin:jMax,iMin:iMax)/1e3, 'r.','markersi',12)
hlim([-1.5 1.5 -335 -331]);  
subplot(2,2,3)
plot(grd2.x_psi(1,:)/1e3,hatpsi2(1,:),'bp-','linew',2,'markersi',12);;hold on
plot(grd1.x_psi(jMin:jMin,iMin:iMin)/1e3,...
        hatpsi1(jMin:jMin,iMin:iMin),'ro-','linew',2)
ylim([5670 5725]);axis ij
xlim([-15 1])
title('southern boundary')
subplot(2,2,4)
% plot(grd2.x_psi(:,end)/1e3,hatpsi2(:,end),'bp-','linew',2,'markersi',12);;hold on
% plot(grd1.x_psi(jMin:jMax,iMin:iMax)/1e3,...
%         hatpsi1(jMin:jMax,iMin:iMax),'ro-','linew',2)
plot(grd2.y_psi(:,end)/1e3,hatpsi2(:,end),'bp-','linew',2,'markersi',12);;hold on
plot(grd1.y_psi(jMin:jMax,iMin:iMax)/1e3,...
        hatpsi1(jMin:jMax,iMin:iMax),'ro-','linew',2)
 
ylim([5884 5900]);axis ij
xlim([-290 -283])
title('h at psi, eastern boundary')
%%
 
figure(3);clf;set(gcf,'color','w')
clear tmp*
ishift=0;jshift=0; % hail mary that there might be a shift-by-one indexing problem. NOPE
tmph1 = hatpsi1(jshift+[jMin:jMax],ishift+[iMin:iMax]);
tmpx1 = xatpsi1(jshift+[jMin:jMax],ishift+[iMin:iMax]);
tmpy1 = yatpsi1(jshift+[jMin:jMax],ishift+[iMin:iMax]);
tmph2 = hatpsi2   (1:3:end,1:3:end);
tmpx2 = grd2.x_psi(1:3:end,1:3:end);
tmpy2 = grd2.y_psi(1:3:end,1:3:end);
whos tmp*
 
clear ax;cm1=colormap(lansey);cm2=rwb; % you will need my rwb.m colormap or choose your own
ax(1)=subplot(1,3,1);pcolorjw(tmpx1/1e3,tmpy1/1e3,tmph1);shading flat;rect;colorbar;caxis([5700 6000]);title('parent grid h at psi points')
ax(2)=subplot(1,3,2);pcolorjw(tmpx2/1e3,tmpy2/1e3,tmph2);shading flat;rect;colorbar;caxis([5700 6000]);title('child grid subsampled 3-to-1 at psi points')
ax(3)=subplot(1,3,3);pcolorjw(tmpx1/1e3,tmpy1/1e3,tmph2-tmph1);shading flat;rect;colorbar;caxis([-10,10]);title('parent minus child grid')
linkaxes(ax,'xy')
colormap(ax(1),cm1);colormap(ax(2),cm1)
suptitle('Note that I did NO interpolation on the parent grid, I subsampled the child grid')


