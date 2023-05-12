clear; close all

file = 'riversLO.nc';
LOgridFile = '../cas6_v3_originalGrid/grid.nc';
LOHISFile =  '../cas6_v3_originalGrid/ocean_his_0001.nc';

HCgridFile = '../Gridpak_Mercator/HC_100mME_wetDry.nc';
HCHISFile  = '/import/c1/VERTMIX/jgpender/coawst/HC_100m_30layers/Experiments/HC_100m_WorkingSystem/netcdfOutput/hc_his_00001.nc';
% HCHISFile  = '../BC_IC_HC_2021/ini_074_wetDry/HISstart.nc';


time = nc_varget(file,'river_time');
xOrig = nc_varget(file,'river_Xposition');
yOrig = nc_varget(file,'river_Eposition');

gridLO = roms_get_grid(LOgridFile,LOHISFile,0,1);

gridHC = roms_get_grid(HCgridFile,HCHISFile,0,1);


% fig(1);clf;plot(diff(time))

maskOrig = nc_varget(LOgridFile,'mask_rho');

fig(2);clf;
pcolor(maskOrig);shading flat;hold on
plot(xOrig,yOrig)

% The Hood Canal points are sequential and sit near (x,y) ~ (500,700)

[1:length(xOrig)]';
[ans xOrig yOrig]




fig(3);clf;
range=[17:20];
pcolor(maskOrig);shading flat;hold on
plot(xOrig(range),yOrig(range),'*g')



fig(4);clf;
range=[17:20];
imagesc(maskOrig);axis xy;xlim([490 525]);ylim([670  780]);
hold on
plot(xOrig(range),yOrig(range),'*g')


[xOrig(range) yOrig(range)]



aaa = 5;


% Create a subsetted rivers.nc file with just these points.

fileNew = 'rivers.nc';
unix(['rm ',fileNew]);
unix('ls -l')
unix(['ncks -d river,16,19 ',file,' ',fileNew]);

rivTrans = nc_varget(fileNew,'river_transport');
size(rivTrans);
rivTrans(:,4) = 0;
nc_varput(fileNew,'river_transport',rivTrans);
aaa=5;


%% Fix the X and E positions

oldX = nc_varget(fileNew,'river_Xposition');
oldY = nc_varget(fileNew,'river_Eposition');

myGrid = '../Gridpak_Mercator/HC_100mME_wetDry.nc';
newMask = nc_varget(myGrid,'mask_rho');

fig(10);clf;
imagesc(newMask);axis xy;

newX = 0*oldX;
newY = 0*oldY;



%% first point (From topmost, then work your way down)
delta=8;
nn=1;

fig(21);clf;
imagesc(maskOrig);axis xy;xlim([xOrig(range(nn))-delta xOrig(range(nn))+delta ]);ylim([yOrig(range(nn))-delta yOrig(range(nn))+delta]);
hold on;plot(xOrig(range(nn)),yOrig(range(nn)),'*g')

newX(nn) = 186;
newY(nn) = 453;
fig(11);clf;
imagesc(newMask);axis xy;xlim([newX(nn)-delta newX(nn)+delta ]);ylim([newY(nn)-delta newY(nn)+delta]);
hold on;
plot(newX(nn),newY(nn),'*g')

%% second point
delta=3;
nn=2;

fig(22);clf;
imagesc(maskOrig);axis xy;xlim([xOrig(range(nn))-delta xOrig(range(nn))+delta ]);ylim([yOrig(range(nn))-delta yOrig(range(nn))+delta]);
hold on;plot(xOrig(range(nn)),yOrig(range(nn)),'*g')

newX(nn) = 147;
newY(nn) = 416;
fig(12);clf;
imagesc(newMask);axis xy;xlim([newX(nn)-delta newX(nn)+delta ]);ylim([newY(nn)-delta newY(nn)+delta]);
hold on;
plot(newX(nn),newY(nn),'*g')

%% third point
delta=3;
nn=3;

fig(23);clf;
imagesc(maskOrig);axis xy;xlim([xOrig(range(nn))-delta xOrig(range(nn))+delta ]);ylim([yOrig(range(nn))-delta yOrig(range(nn))+delta]);
hold on;plot(xOrig(range(nn)),yOrig(range(nn)),'*g')

newX(nn) = 80;
newY(nn) = 301;
fig(13);clf;
imagesc(newMask);axis xy;xlim([newX(nn)-delta newX(nn)+delta ]);ylim([newY(nn)-delta newY(nn)+delta]);
hold on;
plot(newX(nn),newY(nn),'*g')

%% fourth point
delta=10;
nn=4;

fig(21);clf;
imagesc(maskOrig);axis xy;xlim([xOrig(range(nn))-delta xOrig(range(nn))+delta ]);ylim([yOrig(range(nn))-delta yOrig(range(nn))+delta]);
hold on;plot(xOrig(range(nn)),yOrig(range(nn)),'*g')

newX(nn) = 24;
newY(nn) = 20;
fig(11);clf;
imagesc(newMask);axis xy;xlim([newX(nn)-delta newX(nn)+delta ]);ylim([newY(nn)-delta newY(nn)+delta]);
hold on;
plot(newX(nn),newY(nn),'*g')




%%

nc_varput(fileNew,'river_Xposition',newX);
nc_varput(fileNew,'river_Eposition',newY);



%% Double check

newX = nc_varget(fileNew,'river_Xposition');
newY = nc_varget(fileNew,'river_Eposition');

riv = nc_varget(fileNew,'river_transport');
fig(99);clf;plot(riv)
% riv = abs(riv);
% fig(98);clf;plot(riv)
% nc_varput(fileNew,'river_transport',riv);


fig(20);clf;
imagesc(newMask);axis xy;%xlim([10 150]);ylim([1 300]);
hold on; plot(newX,newY,'*g')

