parentFile = 'netcdfOutput/guam_his2_00003.nc';
childFile  = 'netcdfOutput/guam_his2_nest_00003.nc';

usurP = nc_varget(parentFile,'u_sur');
usurC = nc_varget(childFile,'u_sur');

imin = 101;
imax = 120;
jmin = 55;
jmax = 88;

tt=5;

fig(1);clf;
pcolor(sq(usurP(tt,jmin:jmax+1,imin:imax)));shading flat;colorbar
title(['last snapshot on parent frame tt= ',num2str(tt)])

fig(2);clf;
pcolor(sq(usurC(tt,:,:)));shading flat;colorbar
title(['last snapshot on child frame tt= ',num2str(tt)'])

fig(3);clf;
pcolor(sq(usurP(tt,jmin:jmax+1,imin:imax)-usurC(tt,:,:)));shading flat;colorbar
title(['last snapshot difference tt= ',num2str(tt)'])