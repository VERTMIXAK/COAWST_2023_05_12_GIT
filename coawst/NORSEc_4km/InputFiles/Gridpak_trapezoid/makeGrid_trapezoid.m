clear;

% The idea here is to take an existing grid 
%       ../Gridpak/NORSEc_1km.nc
% and regularize the shape of each cell.


% The corners for the original BARROW_2km grid are:
p1=[1075.335502,   -1646690.743];
p2=[-672472.438,   -2470359.];
p3=[434795.9097,   -3112509.143];
p4=[1108343.683,   -2288840.886];

% If these corners are properly placed, then the edge lengths should be
% integer multiples of 4000m

ny = norm(p1-p2)/4000;
nx = norm(p2-p3)/4000;
norm(p3-p4)/4000;
norm(p4-p1)/4000;

ny = round(ny);
nx = round(nx);

% set p2 as the anchor and define a pair of non-orthogonal unit vectors
uvNS = (p1-p2)/norm(p1-p2)
uvEW = (p3-p2)/norm(p3-p2)

p2 = p2;
p1 = p2 + ny*4000*uvNS
p3 = p2 + nx*4000*uvEW
p4 = p3 + ny*4000*uvNS

aaa=5;



%% Create the coast.in file - i.e. generate the x,y pairs around the perimeter

% the data write begins in the upper left corner, runs counterclockwise
% until you get back (almost) to the starting point.

% Remember that you ARE supposed to duplicate the corners!!

dumWest = zeros(ny+1,2);
dumWest(:,2) = [p1(2):(p2(2)-p1(2))/ny:p2(2)];
dumWest(:,1) = [p1(1):(p2(1)-p1(1))/ny:p2(1)];

dumSouth = zeros(nx+1,2);
dumSouth(:,2) = [p2(2):(p3(2)-p2(2))/nx:p3(2)];
dumSouth(:,1) = [p2(1):(p3(1)-p2(1))/nx:p3(1)];

dumEast = zeros(ny+1,2);
dumEast(:,2) = [p3(2):(p4(2)-p3(2))/ny:p4(2)];
dumEast(:,1) = [p3(1):(p4(1)-p3(1))/ny:p4(1)];

dumNorth = zeros(nx+1,2);
dumNorth(:,2) = [p4(2):(p1(2)-p4(2))/nx:p1(2)];
dumNorth(:,1) = [p4(1):(p1(1)-p4(1))/nx:p1(1)];

aaa=5;

%%
% 
% fig(10);clf;
% plot(dumWest(:,2),dumWest(:,1),'*');hold on
% plot(dumSouth(:,2),dumSouth(:,1),'*')
% plot(dumEast(:,2),dumEast(:,1),'*')
% plot(dumNorth(:,2),dumNorth(:,1),'*')

fig(11);clf;
plot(dumWest(:,1),dumWest(:,2),'*');hold on
plot(dumSouth(:,1),dumSouth(:,2),'*')
plot(dumEast(:,1),dumEast(:,2),'*')
plot(dumNorth(:,1),dumNorth(:,2),'*')


aaa=5;

%%

% coast = vertcat(dumWest,dumSouth,dumEast,dumNorth);

['Include/gridparam.h:  Lm=',num2str(nx),'   Mm=',num2str(ny)]

% save('coast.in','coast','-ascii')


%% Create the sqgrid.in file

% Note that I can skip the fort2sq.bash script. What this does is convert
% lat/lon to x/y, but I've already got x/y for this grid.

save('west.in','dumWest','-ascii');
save('east.in','dumEast','-ascii');
save('north.in','dumNorth','-ascii');
save('south.in','dumSouth','-ascii');

unix(['echo "',num2str(ny+1),' " > sqgrid.in']);
% unix(['echo "',num2str(ny-1),' " > sqgrid.in']);
unix(['cat west.in >> sqgrid.in']);

unix(['echo "',num2str(nx+1),' " >> sqgrid.in']);
% unix(['echo "',num2str(ny-1),' " > sqgrid.in']);
unix(['cat south.in >> sqgrid.in']);

unix(['echo "',num2str(ny+1),' " >> sqgrid.in']);
% unix(['echo "',num2str(ny-1),' " >> sqgrid.in']);
unix(['cat east.in >> sqgrid.in']);

unix(['echo "',num2str(nx+1),' " >> sqgrid.in']);
% unix(['echo "',num2str(nx-1),' " >> sqgrid.in']);
unix(['cat north.in >> sqgrid.in']);


