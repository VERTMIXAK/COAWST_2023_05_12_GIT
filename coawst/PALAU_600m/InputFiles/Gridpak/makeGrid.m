clear;

% The strategy is a bit different here compared to PALAU_800m. I am
% anticipating a two-way nesting experiment on this grid and I would like
% to make pm and pn as uniform as possible in the vicinity of the child
% grid. To that end, I'm not going to screw around with latitude and
% longitude. Everything is going to hinge on the x and y.

% Very generally, the PALAU_800m grid has a (more or less) regular central 
% the size of the PALAU_120C grid from, like, 5 years ago with a 25 km
% boundary that telescopes out to 2500 m. 

%% Size the core area

xPsiMin=  -276600; 
xPsiMax =  276600;	
yPsiMin = -47033900;  
yPsiMax = -46533500;

Lm = 922;
Mm = 834;

% Double check
(yPsiMax - yPsiMin)/Mm;
(xPsiMax - xPsiMin)/Lm;

xCore = [xPsiMin:600:xPsiMax];
yCore = [yPsiMin:600:yPsiMax];

aaa=5;

%% Transition region

% Here is a vector that makes a nice Sigmoid from 600m to 2500m

inner = 600;
outer = 2600;
myN = 16;
myX = [-4.5:7.5/myN:3];
myTele = cumsum(inner + (outer-inner)./(1+exp(-myX)));

fig(1);clf;plot(myTele)

lhs = xCore(1) - fliplr(myTele)
rhs = xCore(end) + myTele
fullX = [lhs xCore rhs];
fig(2);clf;plot(fullX)
 
lhs = yCore(1) - fliplr(myTele)
rhs = yCore(end) + myTele
fullY = [lhs yCore rhs];
fig(3);clf;plot(fullY)
    
aaa=5;

%% Create the sqgrid.in file

% the data write begins in the upper left corner, runs counterclockwise
% until you get back (almost) to the starting point.


nx=length(fullX); ny=length(fullY);

%
dumWest = zeros(ny,2);
for jj=1:ny
    dumWest(jj,2) = fullY(ny-jj+1);
    dumWest(jj,1) = fullX(1);
end


dumSouth = zeros(nx,2);
for ii=1:nx
    dumSouth(ii,2) = fullY(1);
    dumSouth(ii,1) = fullX(ii);
end

dumEast = zeros(ny,2);
for jj=1:ny
    dumEast(jj,2) = fullY(jj);
    dumEast(jj,1) = fullX(end);
end

dumNorth = zeros(nx,2);
for ii=1:nx
    dumNorth(ii,2) = fullY(end);
    dumNorth(ii,1) = fullX(nx-ii+1);
end



%%
coast = vertcat(dumWest,dumSouth,dumEast,dumNorth);

['Include/gridparam.h:  Lm=',num2str(nx-1),'   Mm=',num2str(ny-1)]

save('west.in','dumWest','-ascii')
save('east.in','dumEast','-ascii')
save('north.in','dumNorth','-ascii')
save('south.in','dumSouth','-ascii')



%% Plot perimeter


fig(10);clf;

plot(dumWest(:,2),dumWest(:,1),'r' );hold on
plot(dumSouth(:,2),dumSouth(:,1),'g' );
plot(dumEast(:,2),dumEast(:,1),'b' );
plot(dumNorth(:,2),dumNorth(:,1),'k' );


