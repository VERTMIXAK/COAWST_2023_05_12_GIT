clear;

fileIn  = 'DOPPIO_2020_bdry_NG_100m.nc';
fileOut = 'DOPPIO_2020_bdry_NG_100m_detided.nc';

unix(['cp ',fileIn,' ',fileOut])

times=nc_varget(fileIn,'ocean_time');
nt = length(times)

% dt = (times(2)-times(1))*24    % time step in hours

diff(times);dt = mean(ans)*24

nb = 9;

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
% If flo is the highpass corner freq then win = 1/flo must be the highpass
% corner period, which is 4 days for the daily HYCOM source as I received
% this script.
%
% As written, a 3-hour sampling (the frinkiac data) gives 
%       win = 1/(36/3) = 1/12
% which is obviously wrong because it must be true that
%       0 < 1/win < 1
% Perhaps I should try to make the highpass corner period fixed, so win
% equals however many intervals add up to 4 days, like this:
%       win = 4* 24/dt


% win = dt / 36;
win = 4* 24/dt

% if dt==24;
%     win = 4*dt/24   ;else
%     win = 1/(36/dt);
% end

%% make variable list

varNames={'zeta_north' ...
'zeta_south' ...
'zeta_east' ...
'zeta_west' ...
'temp_north' ...
'temp_south' ...
'temp_east' ...
'temp_west' ...
'salt_north' ...
'salt_south' ...
'salt_east' ...
'salt_west' ...
'u_north' ...
'u_south' ...
'u_east' ...
'u_west' ...
'ubar_north' ...
'ubar_south' ...
'ubar_east' ...
'ubar_west' ...
'v_north' ...
'v_south' ...
'v_east' ...
'v_west' ...
'vbar_north' ...
'vbar_south' ...
'vbar_east' ...
'vbar_west'};

%%

for vv=1:length(varNames)
    old = nc_varget(fileIn,varNames{vv} );
    new = old;
    [~,nvar] = size(size(old));
    varNames{vv}
    if nvar==2
        [nt,nx] = size(old);
        for ii=1:nx
            new(:,ii) = hls_lowpassbutter(old(:,ii),1/win,1,nb); 
        end;
    else
        [nt,nz,nx] = size(old);
        for ii=1:nx; for zz=1:nz
            new(:,zz,ii) = hls_lowpassbutter(old(:,zz,ii),1/win,1,nb); 
        end;end;
    end;
    
    nc_varput(fileOut,varNames{vv},new);
end;


%% make some plots of the smoothed data

file_smoo = fileOut;
file_ORIG = fileIn;

z_west_ORIG = nc_varget(file_ORIG,'zeta_west');done('ORIG')
z_west_smoo = nc_varget(file_smoo,'zeta_west');done('smoo')

dat_ORIG = z_west_ORIG(1:240,350);
dat_smoo = z_west_smoo(1:240,350);

[dat_smoo_hls]=hls_lowpassbutter(dat_ORIG,1/32,3,9);

[f,G_ORIG]=hls_spectra(dat_ORIG);
[f,G_smoo]=hls_spectra(dat_smoo);
[f,G_smoo_hls]=hls_spectra(dat_smoo_hls);
figure(2);clf
subplot(2,1,1)
semilogy(f/3,G_ORIG,'b');hold on;
semilogy(f/3,G_smoo_hls,'k');hold on;
semilogy(f/3,G_smoo,'r');hold on;
legend('orig','hls','JGP')
plot([1 1]/12.42,[1e-3 1e0])
plot([1 1]/24,[1e-3 1e0]);ylim([1e-12,1e2])
subplot(2,1,2)
plot(3*(1:240)/24,dat_ORIG,'b');hold on
plot(3*(1:240)/24,dat_smoo,'r');hold on
plot(3*(1:240)/24,dat_smoo_hls,'k');

print('detidePix/tidalFiltering','-djpeg');
