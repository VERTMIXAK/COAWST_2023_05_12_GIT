file8  = 'PALAU_800m_tides.nc';
fileM2 = 'PALAU_800m_tides_M2.nc';

unix(['cp ',file8,' ',fileM2])

dum = nc_varget(fileM2,'tide_Eamp');

% M2 is 6th plane

fig(1);clf;
pcolor(sq(dum(6,:,:)));shading flat;colorbar

% zero out the other plane

dum(1,:,:) = 0;
dum(2,:,:) = 0;
dum(3,:,:) = 0;
dum(4,:,:) = 0;
dum(5,:,:) = 0;
dum(7,:,:) = 0;
dum(8,:,:) = 0;

nc_varput(fileM2,'tide_Eamp',dum);
