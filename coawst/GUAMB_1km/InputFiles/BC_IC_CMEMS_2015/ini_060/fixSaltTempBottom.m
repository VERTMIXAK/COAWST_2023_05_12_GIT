fileOrig = 'CMEMS_2015_060_ic_GUAMB_1km.nc_ORIG';

file = 'CMEMS_2015_060_ic_GUAMB_1km.nc';

unix(['cp ',fileOrig,' ',file])

salt = nc_varget(file,'salt');
temp = nc_varget(file,'temp');
u    = nc_varget(file,'u');
v    = nc_varget(file,'v');

[nz,ny,nx] = size(salt);


%%

fig(1);clf;pcolor(sq(salt(1,:,:)));shading flat
fig(2);clf;pcolor(sq(salt(:,:,10)));shading flat

%%

for ii=1:600; for jj=1:200; for kk=10:-1:1
    if(isnan(salt(kk,jj,ii))) 
        salt(kk,jj,ii) = salt(kk+1,jj,ii);
    end;
    if(isnan(temp(kk,jj,ii))) 
        temp(kk,jj,ii) = temp(kk+1,jj,ii);
    end;
    if(isnan(u(kk,jj,ii))) 
           u(kk,jj,ii) =    u(kk+1,jj,ii);
    end;
    if(isnan(v(kk,jj,ii))) 
           v(kk,jj,ii) =    v(kk+1,jj,ii);
    end;
end;end;end;

% for ii=150:250; for jj=100:200; for kk=10:-1:1
%     if(isnan(salt(kk,jj,ii))) 
%         salt(kk,jj,ii) = salt(kk+1,jj,ii);
%     end;
%     if(isnan(temp(kk,jj,ii))) 
%         temp(kk,jj,ii) = temp(kk+1,jj,ii);
%     end;
%     if(isnan(u(kk,jj,ii))) 
%            u(kk,jj,ii) =    u(kk+1,jj,ii);
%     end;
%     if(isnan(v(kk,jj,ii))) 
%            v(kk,jj,ii) =    v(kk+1,jj,ii);
%     end;
% end;end;end;

fig(11);clf;pcolor(sq(salt(1,:,:)));shading flat;title('salt bottom')
fig(12);clf;pcolor(sq(salt(:,:,10)));shading flat;title('salt slice')
fig(13);clf;pcolor(sq(u(:,:,10)));shading flat;title('u slice');
fig(14);clf;pcolor(sq(v(:,:,10)));shading flat;title('v slice');

fig(21);clf;pcolor(sq(temp(1,:,:)));shading flat;title('temp bottom');
fig(23);clf;pcolor(sq(u(1,:,:)));shading flat;title('u bottom');
fig(24);clf;pcolor(sq(v(1,:,:)));shading flat;title('v bottom');

dum=zeros(1,nz,ny,nx);
dum(1,:,:,:) = salt;
nc_varput(file,'salt',dum);

dum=zeros(1,nz,ny,nx);
dum(1,:,:,:) = temp;
nc_varput(file,'temp',dum);

[nz,ny,nx] = size(u);
dum=zeros(1,nz,ny,nx);
dum(1,:,:,:) = u;
nc_varput(file,'u',dum);

[nz,ny,nx] = size(v);
dum=zeros(1,nz,ny,nx);
dum(1,:,:,:) = v;
nc_varput(file,'v',dum);

