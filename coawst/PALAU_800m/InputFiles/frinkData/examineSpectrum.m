tabwindow;
clear; close all

%% %%% compare freq spectrum of UH detided bdry file to UW detided bdry file

fileUH = 'bdry_08049/fleat_bdry_08049_tided_n50.nc';
fileUW = 'bdry_08049/fleat_bdry_08049_detided_n50.nc';

timesUW = nc_varget(fileUW,'ocean_time');
timesUW = timesUW/3600;
timesUW = timesUW - timesUW(1);

timesUH = nc_varget(fileUH,'ocean_time');
timesUH = timesUH/3600;
timesUH = timesUH - timesUH(1);


%% plot ubar

UHfield = nc_varget(fileUH,'ubar_west');
UWfield = nc_varget(fileUW,'ubar_west');

[tt,ny] = size(UWfield);

% plot ubar

datUH = UHfield(:,350);
datUW = UWfield(:,350);

[f,G_UH]=hls_spectra(datUH);
[f,G_UW]=hls_spectra(datUW);

nFreq = 150;

figure(2);clf

subplot(2,1,1)
semilogy(f(1:nFreq),G_UH(1:nFreq),'b');hold on;
semilogy(f(1:nFreq),G_UW(1:nFreq),'r')
legend('UW tided','UW detided')
text(1/12.42,.1,'M2')
text(1/24,.1,'S1')
xlabel('freq (1/hour)')
title(['freq spectrum - ubar west'])

subplot(2,1,2)
plot(timesUH,datUH,'b');hold on
plot(timesUW,datUW,'r');hold on
xlabel('time (hour)')
ylabel('amplitude (m/s)')




%% plot usur

UHfield = nc_varget(fileUH,'u_west');
UWfield = nc_varget(fileUW,'u_west');

[tt,nz,ny] = size(UWfield);

% plot u(kk)

myZ = nz-16';

datUH = UHfield(:,myZ,350);
datUW = UWfield(:,myZ,350);

[f,G_UH]=hls_spectra(datUH);
[f,G_UW]=hls_spectra(datUW);

nFreq = 150;

figure(2);clf

subplot(2,1,1)
semilogy(f(1:nFreq),G_UH(1:nFreq),'b');hold on;
semilogy(f(1:nFreq),G_UW(1:nFreq),'r')
legend('UW tided','UW detided')
text(1/12.42,.1,'M2')
text(1/24,.1,'S1')
xlabel('freq (1/hour)')
title(['freq spectrum - u(',num2str(myZ),') west'])

subplot(2,1,2)
plot(timesUH,datUH,'b');hold on
plot(timesUW,datUW,'r');hold on
xlabel('time (hour)')
ylabel('amplitude (m/s)')

