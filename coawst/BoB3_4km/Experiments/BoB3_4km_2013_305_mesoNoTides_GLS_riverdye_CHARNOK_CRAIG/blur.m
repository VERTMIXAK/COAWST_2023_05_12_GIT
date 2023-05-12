clear; close all

rstFile = 'netcdfOutput_days063_270/bob_rst.nc';
newRSTFile = 'netcdfOutput_days063_270/bob_rst2.nc';

gridFile = 'BoB3_4km.nc';
HISFile = 'netcdfOutput_days001_DT20/bob_his_00001.nc';

grd = roms_get_grid(gridFile,HISFile,0,1);

unix(['\rm ',newRSTFile]);
unix(['ncks -d ocean_time,0 ',rstFile,' ',newRSTFile]);


%% Target the problem

ru    = nc_varget(rstFile,   'ru');
rubar = nc_varget(rstFile,'rubar');

[ntU,nU,nzU,nyU,nxU] = size(ru);
[ntUbar,nUbar,nzUbar,nyUbar,nxUbar] = size(rubar);

delta=5;
myY = 156;
myX = 90;
myZ = nzU;

% myY = 100;
% myX = 200;

% fig(1);clf;imagesc(1:nxU,1:nyU,sq(ru(3,1,30,:,:)));axis xy;xlim([myX-delta myX+delta]);ylim([myY-delta myY+delta]);colorbar;
% fig(2);clf;imagesc(1:nxU,1:nyU,sq(ru(2,1,30,:,:)));axis xy;xlim([myX-delta myX+delta]);ylim([myY-delta myY+delta]);colorbar;
fig(3);clf;imagesc(1:nxU,1:nyU,sq(ru(3,1,myZ,myY-delta:myY+delta,myX-delta:myX+delta)));axis xy;colorbar;caxis([-500 500])
fig(4);clf;imagesc(1:nxU,1:nyU,sq(ru(2,1,myZ,myY-delta:myY+delta,myX-delta:myX+delta)));axis xy;colorbar;caxis([-500 500])

%% check defn of ubar

% myI=100; myJ = 150;
% dot(sq(u(1,1,:,myJ,myI)),diff(grd.z_uw(:,myJ,myI))) / sum(diff(grd.z_uw(:,myJ,myI)))
% ubar(1,1,myJ,myI)?

%%

Ulimit = 1000;
dum = sq(ru(3,1,myZ,:,:));
fig(10);clf;imagesc(1:nxU,1:nyU,dum);axis xy;colorbar;caxis(1*Ulimit*[-1 1])

dum(abs(dum)>Ulimit) = Ulimit* sign(dum(abs(dum)>Ulimit)) ;
fig(11);clf;imagesc(1:nxU,1:nyU,dum);axis xy;colorbar;caxis(10*Ulimit*[-1 1])



