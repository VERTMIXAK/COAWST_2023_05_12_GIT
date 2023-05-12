source ~/.runROMSintel

url='https://tds.marine.rutgers.edu/thredds/dodsC/roms/doppio/2017_da/his/History_Best?s_rho[0:1:39],s_w[0:1:40],lon_rho[0:1:105][0:1:241],lat_rho[0:1:105][0:1:241],lon_u[0:1:105][0:1:240],lat_u[0:1:105][0:1:240],lon_v[0:1:104][0:1:241],lat_v[0:1:104][0:1:241],lon_psi[0:1:104][0:1:240],lat_psi[0:1:104][0:1:240],spherical,xl,el,Vtransform,Vstretching,theta_s,theta_b,Tcline,hc,grid,Cs_r[0:1:39],Cs_w[0:1:40],h[0:1:105][0:1:241],f[0:1:105][0:1:241],pm[0:1:105][0:1:241],pn[0:1:105][0:1:241],angle[0:1:105][0:1:241],mask_rho[0:1:105][0:1:241],mask_u[0:1:105][0:1:240],mask_v[0:1:104][0:1:241],mask_psi[0:1:104][0:1:240]'

#url2='https://tds.marine.rutgers.edu/thredds/dodsC/roms/doppio/2017_da/his/History_Best'

echo $url
echo " "
echo " "
echo " "
echo " "


nccopy  $url  grid_DOPPIO.nc

exit
