templateFile = 'NG_runoff_2020.nc_template';
newFile      = 'NG_runoff_2020.nc';
gridFile     = '../Gridpak/NG_100m.nc';

pm = nc_varget(gridFile,'pm');
pn = nc_varget(gridFile,'pn');

sourceFile = '../riverData_2020/flow_Blackstone_dailyAve.txt';
importdata(sourceFile); time = ans(:,1);

nTimes = length(time);

unix(['\rm ',newFile]);
unix(['ncks -d time,1,',num2str(nTimes),' ',templateFile,' ',newFile])

nc_varput(newFile,'time',time);

% make sure to start with friver all zeros.
dum = nc_varget(newFile,'friver');
dum = 0*dum;
nc_varput(newFile,'friver',dum);



%% Taunton river

% NOTE: these source files have the total freshwater flow in 
%       m^3/s
%  I need to divide these numbers by the area of tile where I dump this
%  water.

myI = 454;
myJ = 800;

sourceFile = '../riverData_2020/flow_Taunton_dailyAve.txt';
dum = importdata(sourceFile);
flow = dum(:,2);

area = 1/ ( pn(myJ,myI) * pm(myJ,myI) );

flow = flow/area;
dum = nc_varget(newFile,'friver');

dum(:,myJ,myI) = flow;
nc_varput(newFile,'friver',dum);

done('Taunton')


%% Pawtuxet river

myI = 266;
myJ = 823;

sourceFile = '../riverData_2020/flow_Pawtuxet_dailyAve.txt';
dum = importdata(sourceFile);
flow = dum(:,2);

area = 1/ ( pn(myJ,myI) * pm(myJ,myI) );

flow = flow/area;
dum = nc_varget(newFile,'friver');

dum(:,myJ,myI) = flow;
nc_varput(newFile,'friver',dum);


done('Pawtuxet')

%% Blackstone river

myI = 254;
myJ = 913;

sourceFile = '../riverData_2020/flow_Blackstone_dailyAve.txt';
dum = importdata(sourceFile);
flow = dum(:,2);

area = 1/ ( pn(myJ,myI) * pm(myJ,myI) );

flow = flow/area;
dum = nc_varget(newFile,'friver');

dum(:,myJ,myI) = flow;
nc_varput(newFile,'friver',dum);


done('Blackstone')

%% Try to plot

% friver = nc_varget(newFile,'friver');
% max(friver(:))
% 
% [a,b] = find(sq(friver(1,:,:)) > 0);
% 
% jraFile  = '../Runoff_JRA/JRA-1.4_NG_rivers_2020.nc';
% myI = nc_varget(jraFile,'river_Xposition');
% myJ = nc_varget(jraFile,'river_Eposition');
% 
% fig(1);clf;
% plot(myI,myJ)
% hold on
% plot(b,a,'.r')



