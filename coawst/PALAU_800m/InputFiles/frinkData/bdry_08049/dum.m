clear;


%% initialize

% DO EVERYTHING IN HOURS !!!!!!!

fileIn  = 'fleat_bdry_08049_tided_n50.nc';

times=nc_varget(fileIn,'ocean_time');

% convert seconds to hours
times = times/3600;
times = times - times(1);

nt = length(times)

% get sampling interval
diff(times);
dt = mean(ans)

% order of butterworth filter
nb = 9;

% Use the in-house butterworth filter. set to low-pass

% The cutoff shoulder frequency is set near the S1 frequency.
% I include a fudge factor out front to sneak up on the desired cutoff
% The idea is to get the S1 peak to juuuust disappear.

fCutoff =  1/24;

win = (1/dt) / (.5 * fCutoff)


zeta = nc_varget(fileIn,'zeta_west');

%% original version

old = zeta(:,350);
new = hls_lowpassbutter(old,1.3 *1/win,1/dt,nb); 

[f,G_old]=hls_spectra(old);
[f,G_new]=hls_spectra(new);

figure(2);clf
subplot(2,1,1)
nPoints = 100;
semilogy(f(1:nPoints),G_old(1:nPoints),'b');hold on;
semilogy(f(1:nPoints),G_new(1:nPoints),'r')

subplot(2,1,2)
plot(old,'b');hold on
plot(new,'r');hold on


%% new version

old = zeta(:,350);
new2 = hls_lowpassbutter(old,fCutoff /1,dt,nb); 

[f,G_old]=hls_spectra(old);
[f,G_new2]=hls_spectra(new2);

figure(3);clf
subplot(2,1,1)
nPoints = 100;
semilogy(f(1:nPoints),G_old(1:nPoints),'b');hold on;
semilogy(f(1:nPoints),G_new2(1:nPoints),'r')

subplot(2,1,2)
plot(old,'b');hold on
plot(new2,'r');hold on
