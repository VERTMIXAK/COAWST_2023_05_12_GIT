clear;


%% initialize

% DO EVERYTHING IN HOURS !!!!!!!

fileIn  = 'fleat_bdry_08049_tided_n50.nc';
fileOut = 'fleat_bdry_08049_detided_n50_ZetaUbarVbar.nc';
unix(['cp ',fileIn,' ',fileOut])

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
% I include a fudge factor to sneak up on the desired cutoff
% The idea is to get the S1 peak to juuuust disappear.

fCutoff = 1/24 / 1.5;

% The guts of this script is a custom low-pass filter
%
%   new(:,ii) = hls_lowpassbutter(old(:,ii),1/win,1,nb);
%
% where (from the help file)
%   [d]=lowpass(dat,flo,delt,n)
%  
%   lowpass a time series with an order n butterworth filter
%  
%   dat  = input time series
%   flo  = highpass corner frequency
%   delt = sampling interval of data
%   n    =  butterworth filter order

%% make variable list - zeta, ubar, vbar

varNames={ 'ubar_north' ...
'ubar_south' ...
'ubar_east' ...
'ubar_west' ...
'vbar_north' ...
'vbar_south' ...
'vbar_east' ...
'vbar_west' ...
'zeta_north' ...
'zeta_south' ...
'zeta_east' ...
'zeta_west'};

var2Names={'u_north' ...
'u_south' ...
'u_east' ...
'u_west' ...
'v_north' ...
'v_south' ...
'v_east' ...
'v_west'};

%% Execute ubar, vbar, zeta

for vv=1:length(varNames)
    old = nc_varget(fileIn,varNames{vv} );
    new = old;
    [~,nvar] = size(size(old));
    varNames{vv}
    [nt,nx] = size(old);
    
    for ii=1:nx
        new(:,ii) = hls_lowpassbutter(old(:,ii),fCutoff,dt,nb); 
    end;
    
    nc_varput(fileOut,varNames{vv},new);
end;

%% Execute u and v

for vv=1:length(var2Names)
    
    old = nc_varget(fileIn,var2Names{vv} );
    
    barUnfiltered = nc_varget(fileIn ,varNames{vv} );
    barFiltered   = nc_varget(fileOut,varNames{vv} );
    barDiff = barFiltered - barUnfiltered;
    
    new = old;
    var2Names{vv}

    [nt,nz,nx] = size(old);
    for ii=1:nx; for zz=1:nz; for tt=1:nt
        new(tt,zz,ii) = new(tt,zz,ii) + barDiff(tt,ii); 
    end;end;end;
    
    nc_varput(fileOut,var2Names{vv},new);
end;

%% make some plots of the smoothed data

file_smoo = fileOut;
file_ORIG = fileIn;

field_ORIG = nc_varget(file_ORIG,'zeta_west');done('ORIG')
field_smoo = nc_varget(file_smoo,'zeta_west');done('smoo')

dat_ORIG = field_ORIG(:,350);
dat_smoo = field_smoo(:,350);


[f,G_ORIG]=hls_spectra(dat_ORIG);
[f,G_smoo]=hls_spectra(dat_smoo);

figure(2);clf
subplot(2,1,1)

nPoints = 100;

semilogy(f(1:nPoints),G_ORIG(1:nPoints),'b');hold on;
semilogy(f(1:nPoints),G_smoo(1:nPoints),'r');hold on;
legend('orig','smoo')
xlabel('freq (1/hour)')

text(1/12.42,.1,'M2')
text(1/24,.1,'S1')

title('zeta west')

subplot(2,1,2)
plot(times,dat_ORIG,'b');hold on
plot(times,dat_smoo,'r');hold on
xlabel('time (hour)')
ylabel('m')

%% more plots

u_orig = nc_varget(fileIn,'u_west');
u_filt = nc_varget(fileOut,'u_west');
u_overFilt = nc_varget('fleat_bdry_08049_detided_n50.nc','u_west');

times  = nc_varget(fileIn,'ocean_time');
times = times/3600;
times = times - times(1);


[nt,nz,nx] = size(u_orig);
myZ = nz-25;

dat_orig = sq(u_orig(:,myZ,350));
dat_filt = sq(u_filt(:,myZ,350));
dat_overFilt = sq(u_overFilt(:,myZ,350));

[f,G_orig]=hls_spectra(dat_orig);
[f,G_filt]=hls_spectra(dat_filt);
[f,G_overFilt]=hls_spectra(dat_overFilt);

figure(21);clf
subplot(2,1,1)

nPoints = 100;

semilogy(f(1:nPoints),G_orig(1:nPoints),'b');hold on;
semilogy(f(1:nPoints),G_filt(1:nPoints),'r');hold on;
% semilogy(f(1:nPoints),G_overFilt(1:nPoints),'g');hold on;
legend('orig','filter Ubt','Filter U')
xlabel('freq (1/hour)')
title(['u(t,',num2str(myZ),',350)'])

% plot([1 1]/12.42,[1e-3 1e0],'g')
text(1/12.42,1,'M2')

% plot([1 1]/24,[1e-3 1e0]);ylim([1e-12,1e2],'g')
text(1/24,1,'S1')


subplot(2,1,2)
plot(times,dat_orig,'b');hold on
plot(times,dat_filt,'r');hold on
% plot(times,dat_overFilt,'g');hold on
xlabel('time (hour)')
ylabel('m/s')


% filter u

dat_overFilt = hls_lowpassbutter(dat_orig,fCutoff,dt,nb);
[f,G_overFilt]=hls_spectra(dat_overFilt);

figure(22);clf
subplot(2,1,1)

nPoints = 100;

semilogy(f(1:nPoints),G_orig(1:nPoints),'b');hold on;
semilogy(f(1:nPoints),G_filt(1:nPoints),'r')
semilogy(f(1:nPoints),G_overFilt(1:nPoints),'g')
legend('orig','filter Ubt','Filter U')
xlabel('freq (1/hour)')
title(['u(t,',num2str(myZ),',350)'])

% plot([1 1]/12.42,[1e-3 1e0],'g')
text(1/12.42,1,'M2')

% plot([1 1]/24,[1e-3 1e0]);ylim([1e-12,1e2],'g')
text(1/24,1,'S1')


subplot(2,1,2)
plot(times,dat_orig,'b');hold on
plot(times,dat_filt,'r')
plot(times,dat_overFilt,'g')
xlabel('time (hour)')
ylabel('m/s')




