oldFile = 'rivers.nc_ORIG';
newFile = 'rivers.nc';

oldVar  = nc_varget(oldFile,'river_transport');
oldTime = nc_varget(oldFile,'river_time');

riv4 = oldVar(:,4);


fig(1);clf;
plot(oldTime,oldVar)

diff(oldTime)

newTime = [oldTime(1):1/24:oldTime(end)];

ntNew = length(newTime)
ntOld = length(oldTime)

newRiv4 = interp1(oldTime,riv4,newTime,'spline');

fig(2);clf
plot(oldTime,riv4);hold on
plot(newTime,newRiv4,'r');


%% Make new file

unix(['ncrcat -O ',oldFile,' ',oldFile,' ',newFile]);

for ii=1:22
    unix(['ncrcat -O ',oldFile,' ',newFile,' ',newFile]);
end;

unix(['ncks -O -d river_time,1,745 ',newFile,' ',newFile]);

nc_varput(newFile,'river_time',newTime);

%%

vars = { 'river_CaCO3' ,...
    'river_Ldetritus' ,...
    'river_NO3' ,...
    'river_TIC' ,...
    'river_alkalinity' ,...
    'river_detritus' ,...
    'river_oxygen' ,...
    'river_phytoplankton' ,...
    'river_salt' ,...
    'river_temp' ,...
    'river_transport' ,...
    'river_zooplankton'   };

for nn=1:12
    nn
    oldVar  = nc_varget(oldFile,char(vars(nn)));
    newVar = interp1(oldTime,oldVar,newTime,'spline');
    nc_varput(newFile,char(vars(nn)),newVar);
end;

fig(3);clf;
plot(newTime,rum)




