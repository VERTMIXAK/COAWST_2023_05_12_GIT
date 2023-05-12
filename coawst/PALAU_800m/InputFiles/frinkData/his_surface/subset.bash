#ncks -d eta_u,43,112 -d xi_u,206,280 -d eta_v,43,112 -d xi_v,206,280 -d eta_rho,43,112 -d xi_rho,206,280 fleat_08049_surfaceTSUV.nc justPalau2.nc

ncks -O -d eta_rho,40,115 -d xi_rho,200,290 -d eta_u,40,115 -d xi_u,200,289  -d eta_v,40,114 -d xi_v,200,290     -x -v temp,u,v,ubar,vbar,zeta fleat_08049_surfaceTSUV.nc dum.nc
echo "a"
ncwa -O -a s_rho dum.nc dum.nc
echo "b"
ncrename -O -h -v salt,SSS -v ocean_time,frc_time dum.nc dum.nc
echo "c"
ncrename -O -h -d eta_rho,Yrho -d xi_rho,Xrho -d eta_v,Yv -d xi_v,Xv -d eta_u,Yu -d xi_u,Xu -d ocean_time,frc_time dum.nc palau_frc.nc
