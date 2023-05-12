tabwindow;
clear; close all

%% %%% compare freq spectrum of UH detided bdry file to UW detided bdry file

fileUH = 'bry/palau_bry_08049_detide.nc';
fileUW = 'bdry_08049/fleat_bdry_08049_detided_n50.nc';

timesUW = nc_varget(fileUW,'ocean_time');
timesUW = timesUW/3600;
timesUW = timesUW - timesUW(1);

timesUH = nc_varget(fileUH,'bry_time');
timesUH = timesUH/3600;
timesUH = timesUH - timesUH(1);

%% plot ubar

ubarUH = nc_varget(fileUH,'ubar_west');
ubarUW = nc_varget(fileUW,'ubar_west');
datUH = ubarUH(:,350);
datUW = ubarUW(:,350);

[f,G_UH]=hls_spectra(datUH);
[f,G_UW]=hls_spectra(datUW);

nFreq = 150;

figure(1);clf

subplot(2,1,1)
semilogy(f(1:nFreq),G_UH(1:nFreq),'b');hold on;
semilogy(f(1:nFreq),G_UW(1:nFreq),'r')
legend('UH detided','UW detided')
text(1/12.42,.1,'M2')
text(1/24,.1,'S1')
xlabel('freq (1/hour)')
title('freq spectrum - ubar west')

subplot(2,1,2)
plot(timesUH,datUH,'b');hold on
plot(timesUW,datUW,'r');hold on
xlabel('time (hour)')
ylabel('amplitude (m/s)')

%% plot usur

uUH = nc_varget(fileUH,'u_west');
uUW = nc_varget(fileUW,'u_west');
datUH = uUH(:,end,350);
datUW = uUW(:,end,350);

[f,G_UH]=hls_spectra(datUH);
[f,G_UW]=hls_spectra(datUW);

nFreq = 150;

figure(2);clf

subplot(2,1,1)
semilogy(f(1:nFreq),G_UH(1:nFreq),'b');hold on;
semilogy(f(1:nFreq),G_UW(1:nFreq),'r')
legend('UH detided','UW detided')
text(1/12.42,.1,'M2')
text(1/24,.1,'S1')
xlabel('freq (1/hour)')
title('freq spectrum - usur west')

subplot(2,1,2)
plot(timesUH,datUH,'b');hold on
plot(timesUW,datUW,'r');hold on
xlabel('time (hour)')
ylabel('amplitude (m/s)')


%% plot T

tUH = nc_varget(fileUH,'temp_west');
tUW = nc_varget(fileUW,'temp_west');
datUH = tUH(:,end,350);
datUW = tUW(:,end,350);

[f,G_UH]=hls_spectra(datUH);
[f,G_UW]=hls_spectra(datUW);

nFreq = 150;

figure(3);clf

subplot(2,1,1)
semilogy(f(1:nFreq),G_UH(1:nFreq),'b');hold on;
semilogy(f(1:nFreq),G_UW(1:nFreq),'r')
legend('UH detided','UW detided')
text(1/12.42,.1,'M2')
text(1/24,.1,'S1')
xlabel('freq (1/hour)')
title('freq spectrum - Tsur west')

subplot(2,1,2)
plot(timesUH,datUH,'b');hold on
plot(timesUW,datUW,'r');hold on
xlabel('time (hour)')
ylabel('amplitude (deg C)')

%% plot S

sUH = nc_varget(fileUH,'salt_west');
sUW = nc_varget(fileUW,'salt_west');
datUH = sUH(:,end,350);
datUW = sUW(:,end,350);

[f,G_UH]=hls_spectra(datUH);
[f,G_UW]=hls_spectra(datUW);

nFreq = 150;

figure(4);clf

subplot(2,1,1)
semilogy(f(1:nFreq),G_UH(1:nFreq),'b');hold on;
semilogy(f(1:nFreq),G_UW(1:nFreq),'r')
legend('UH detided','UW detided')
text(1/12.42,.1,'M2')
text(1/24,.1,'S1')
xlabel('freq (1/hour)')
title('freq spectrum - Ssur west')

subplot(2,1,2)
plot(timesUH,datUH,'b');hold on
plot(timesUW,datUW,'r');hold on
xlabel('time (hour)')
ylabel('amplitude (PSU)')




%% %%% compare freq spectrum of UH tided file vs UH detided file

fileUH = 'bry/palau_bry_08049.nc';
fileUW = 'bry/palau_bry_08049_detide.nc';


timesUW = nc_varget(fileUW,'bry_time');
timesUW = timesUW/3600;
timesUW = timesUW - timesUW(1);

timesUH = nc_varget(fileUH,'bry_time');
timesUH = timesUH/3600;
timesUH = timesUH - timesUH(1);

%% plot ubar

ubarUH = nc_varget(fileUH,'ubar_west');
ubarUW = nc_varget(fileUW,'ubar_west');
datUH = ubarUH(:,350);
datUW = ubarUW(:,350);

[f,G_UH]=hls_spectra(datUH);
[f,G_UW]=hls_spectra(datUW);

nFreq = 150;

figure(11);clf

subplot(2,1,1)
semilogy(f(1:nFreq),G_UH(1:nFreq),'b');hold on;
semilogy(f(1:nFreq),G_UW(1:nFreq),'r')
legend('UH tided','UH detided')
text(1/12.42,.1,'M2')
text(1/24,.1,'S1')
xlabel('freq (1/hour)')
title('freq spectrum - ubar west')

subplot(2,1,2)
plot(timesUH,datUH,'b');hold on
plot(timesUW,datUW,'r');hold on
xlabel('time (hour)')
ylabel('amplitude (m/s)')

%% plot usur

uUH = nc_varget(fileUH,'u_west');
uUW = nc_varget(fileUW,'u_west');
datUH = uUH(:,end,350);
datUW = uUW(:,end,350);

[f,G_UH]=hls_spectra(datUH);
[f,G_UW]=hls_spectra(datUW);

nFreq = 150;

figure(12);clf

subplot(2,1,1)
semilogy(f(1:nFreq),G_UH(1:nFreq),'b');hold on;
semilogy(f(1:nFreq),G_UW(1:nFreq),'r')
legend('UH tided','UH detided')
text(1/12.42,.1,'M2')
text(1/24,.1,'S1')
xlabel('freq (1/hour)')
title('freq spectrum - usur west')

subplot(2,1,2)
plot(timesUH,datUH,'b');hold on
plot(timesUW,datUW,'r');hold on
xlabel('time (hour)')
ylabel('amplitude (m/s)')

%% plot T

tUH = nc_varget(fileUH,'temp_west');
tUW = nc_varget(fileUW,'temp_west');
datUH = tUH(:,end,350);
datUW = tUW(:,end,350);

[f,G_UH]=hls_spectra(datUH);
[f,G_UW]=hls_spectra(datUW);

nFreq = 150;

figure(13);clf

subplot(2,1,1)
semilogy(f(1:nFreq),G_UH(1:nFreq),'b');hold on;
semilogy(f(1:nFreq),G_UW(1:nFreq),'r')
legend('UH tided','UH detided')
text(1/12.42,.1,'M2')
text(1/24,.1,'S1')
xlabel('freq (1/hour)')
title('freq spectrum - Tsur west')

subplot(2,1,2)
plot(timesUH,datUH,'b');hold on
plot(timesUW,datUW,'r');hold on
xlabel('time (hour)')
ylabel('amplitude (deg C)')

%% plot S

sUH = nc_varget(fileUH,'salt_west');
sUW = nc_varget(fileUW,'salt_west');
datUH = sUH(:,end,350);
datUW = sUW(:,end,350);

[f,G_UH]=hls_spectra(datUH);
[f,G_UW]=hls_spectra(datUW);

nFreq = 150;

figure(14);clf

subplot(2,1,1)
semilogy(f(1:nFreq),G_UH(1:nFreq),'b');hold on;
semilogy(f(1:nFreq),G_UW(1:nFreq),'r')
legend('UH tided','UH detided')
text(1/12.42,.1,'M2')
text(1/24,.1,'S1')
xlabel('freq (1/hour)')
title('freq spectrum - Ssur west')

subplot(2,1,2)
plot(timesUH,datUH,'b');hold on
plot(timesUW,datUW,'r');hold on
xlabel('time (hour)')
ylabel('amplitude (PSU)')

