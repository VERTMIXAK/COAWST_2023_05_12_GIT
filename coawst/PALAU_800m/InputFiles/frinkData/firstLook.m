tabwindow;
clear; close all

%% %%% compare freq spectrum of UH detided bdry file to UHfilt detided bdry file

fileUH = 'bdry_08049/fleat_bdry_08049_tided_n50.nc';
fileUHfilt = 'bdry_08049/fleat_bdry_08049_detided_n50.nc';

timesUHfilt = nc_varget(fileUHfilt,'ocean_time');
timesUHfilt = timesUHfilt/3600;
timesUHfilt = timesUHfilt - timesUHfilt(1);

timesUH = nc_varget(fileUH,'ocean_time');
timesUH = timesUH/3600;
timesUH = timesUH - timesUH(1);


%% plot ubar

UHfield = nc_varget(fileUH,'ubar_west');
UHfiltfield = nc_varget(fileUHfilt,'ubar_west');

[nt,ny] = size(UHfiltfield);

% plot ubar

datUH = UHfield(:,350);
datUHfilt = UHfiltfield(:,350);

[f,G_UH]=hls_spectra(datUH);
[f,G_UHfilt]=hls_spectra(datUHfilt);

nFreq = 150;

figure(2);clf

subplot(2,1,1)
semilogy(f(1:nFreq),G_UH(1:nFreq),'b');hold on
semilogy(f(1:nFreq),G_UHfilt(1:nFreq),'r')
text(1/12.42,.1,'M2')
text(1/24,.1,'S1')
xlabel('freq (1/hour)')
title(['freq spectrum - ubar west'])

subplot(2,1,2)
plot(timesUH,datUH,'b');
xlabel('time (hour)')
ylabel('amplitude (m/s)')

%% plot vbar

UHfield = nc_varget(fileUH,'vbar_west');
UHfiltfield = nc_varget(fileUHfilt,'vbar_west');

[nt,ny] = size(UHfiltfield);

% plot ubar

datUH = UHfield(:,350);
datUHfilt = UHfiltfield(:,350);

[f,G_UH]=hls_spectra(datUH);
[f,G_UHfilt]=hls_spectra(datUHfilt);

nFreq = 150;

figure(3);clf

subplot(2,1,1)
semilogy(f(1:nFreq),G_UH(1:nFreq),'b');
text(1/12.42,.1,'M2')
text(1/24,.1,'S1')
xlabel('freq (1/hour)')
title(['freq spectrum -vbar west'])

subplot(2,1,2)
plot(timesUH,datUH,'b');
xlabel('time (hour)')
ylabel('amplitude (m/s)')

%% plot zeta

UHfield = nc_varget(fileUH,'zeta_west');
UHfiltfield = nc_varget(fileUHfilt,'zeta_west');

[nt,ny] = size(UHfiltfield);

% plot ubar

datUH = UHfield(:,350);
datUHfilt = UHfiltfield(:,350);

[f,G_UH]=hls_spectra(datUH);
[f,G_UHfilt]=hls_spectra(datUHfilt);

nFreq = 150;

figure(4);clf

subplot(2,1,1)
semilogy(f(1:nFreq),G_UH(1:nFreq),'b');
text(1/12.42,.1,'M2')
text(1/24,.1,'S1')
xlabel('freq (1/hour)')
title(['freq spectrum - zeta west'])

subplot(2,1,2)
plot(timesUH,datUH,'b');
xlabel('time (hour)')
ylabel('amplitude (m/s)')

%% plot Salt

UHfield = nc_varget(fileUH,'salt_west');
UHfiltfield = nc_varget(fileUHfilt,'salt_west');

[nt,nz,ny] = size(UHfiltfield);

% plot u(kk)

myZ = nz - 25;

datUH = UHfield(:,myZ,350);
datUHfilt = UHfiltfield(:,myZ,350);

[f,G_UH]=hls_spectra(datUH);
[f,G_UHfilt]=hls_spectra(datUHfilt);

nFreq = 150;

figure(10);clf

subplot(2,1,1)
semilogy(f(1:nFreq),G_UH(1:nFreq),'b')
legend('UHfilt tided','UHfilt detided')
text(1/12.42,.1,'M2')
text(1/24,.1,'S1')
xlabel('freq (1/hour)')
title(['freq spectrum - salt(',num2str(myZ),') west'])

subplot(2,1,2)
plot(timesUH,datUH,'b');hold on
xlabel('time (hour)')
ylabel('amplitude (m/s)')

%% plot Temp

UHfield = nc_varget(fileUH,'temp_west');
UHfiltfield = nc_varget(fileUHfilt,'temp_west');

[nt,nz,ny] = size(UHfiltfield);

% plot u(kk)

myZ = nz-0;

datUH = UHfield(:,myZ,350);
datUHfilt = UHfiltfield(:,myZ,350);

[f,G_UH]=hls_spectra(datUH);
[f,G_UHfilt]=hls_spectra(datUHfilt);

nFreq = 150;

figure(11);clf

subplot(2,1,1)
semilogy(f(1:nFreq),G_UH(1:nFreq),'b')
legend('UHfilt tided','UHfilt detided')
text(1/12.42,.1,'M2')
text(1/24,.1,'S1')
xlabel('freq (1/hour)')
title(['freq spectrum - temp(',num2str(myZ),') west'])

subplot(2,1,2)
plot(timesUH,datUH,'b');hold on
xlabel('time (hour)')
ylabel('amplitude (m/s)')

%% plot u

UHfield = nc_varget(fileUH,'u_west');
UHfiltfield = nc_varget(fileUHfilt,'u_west');

UHfieldBar = nc_varget(fileUH,'ubar_west');

[nt,nz,ny] = size(UHfield);

UHbaroclinic = UHfield;
for jj=1:ny; for kk=1:nz; %for tt=1:nt;
    UHbaroclinic(tt,:,jj) = UHfield(tt,:,jj) - UHfieldBar(tt,jj);
%     UHbaroclinic(tt,kk,jj) = UHfield(tt,kk,jj) - UHfieldBar(tt,jj);
end;end;%end;

%% plot u(kk)

myZ = nz-25;

datUH = UHfield(:,myZ,350);
datUHbc = UHbaroclinic(:,myZ,350);
datUHfilt = UHfiltfield(:,myZ,350);

[f,G_UH]=hls_spectra(datUH);
[f,G_UHbc]=hls_spectra(datUHbc);
[f,G_UHfilt]=hls_spectra(datUHfilt);

nFreq = 150;

figure(30);clf

subplot(2,1,1)
semilogy(f(1:nFreq),G_UH(1:nFreq),'b');hold on;
semilogy(f(1:nFreq),G_UHbc(1:nFreq),'r')
legend('u','u baroclinic')
text(1/12.42,.1,'M2')
text(1/24,.1,'S1')
xlabel('freq (1/hour)')
title(['freq spectrum - u(',num2str(myZ),') west'])

subplot(2,1,2)
plot(timesUH,datUH,'b');hold on
plot(timesUH,datUHbc,'r');
xlabel('time (hour)')
ylabel('amplitude (m/s)')

