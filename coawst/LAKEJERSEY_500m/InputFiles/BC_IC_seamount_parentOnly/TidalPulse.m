clear;close all;tabwindow;

oldFile = 'lake_jersey_bdry_a.nc';
newFile = 'lake_jersey_bdry_a_pulse.nc';
unix(['cp ',oldFile,' ',newFile]);

fig(1);clf;
plot(hann(100)); hold on;
x = [0:100];
plot((1-cos(x/100 *2* 3.14159))/2,'r')

%% Make a 12-hour pulse using the hann function
%   The data in the BC file is pretty simple: it's "dead still" conditions
%   with a temp/salt profile that never changes, which means I can put in
%   any times I like in the TidalPulse.nc file.
% 
%   As it sits, there's 275 time stamps and if I confine myself to 5-day
%   runs that means I can have half-hour intervals. That should do a good
%   job of resolving a 12-hour Hanning window. A 12-hour window would have
%   25 Hanning points. The experiments are starting on day 44633, so why
%   don't I make some new times that start at noon the previous day.

ubar = nc_varget(newFile,'ubar_west');
u    = nc_varget(newFile,'u_west');
[nt,nz,ny] = size(u);

myStartDate = 0;

tNew = [myStartDate-.5:1/48:myStartDate+10];
tNew = tNew(1:nt);
% ttStart = find(myStartDate == tNew)
ttStart = 3

nc_varput(newFile,'ocean_time',tNew);

% When you use tidal forcing then the max ubar at the western edge is about
% .03 m/s.

pulse = .03 *[ (hann(10))' (-hann(10))' ] ;
fig(2);clf;plot(pulse)

for tt = 1:length(pulse)
    ubar(tt+ttStart,:)    = pulse(tt);
    u(   tt+ttStart,:,:)  = pulse(tt);
end;

fig(3);clf;
plot(sq(ubar(:,10)))

fig(4);clf;
plot(sq(u(:,6,10)))

nc_varput(newFile,'u_west',u);
nc_varput(newFile,'ubar_west',ubar);


time = nc_varget(oldFile,'ocean_time');
nc_varput(newFile,'ocean_time',time);


