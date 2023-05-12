\rm *reduce.nc

# This is now done on frinkiac
#oldFile=HISend.nc
#newFile=HISend_reduce.nc
#
#ncks -d xi_rho,206,280 -d eta_rho,42,112 -d xi_psi,206,280 -d eta_psi,42,112 -d xi_u,206,280 -d eta_u,42,112 -d xi_v,206,280 -d eta_v,42,112 $oldFile $newFile


oldFile=HIS0.nc
newFile=HIS0_reduce.nc

ncks -d xi_rho,206,280 -d eta_rho,42,112 -d xi_psi,206,280 -d eta_psi,42,112 -d xi_u,206,280 -d eta_u,42,112 -d xi_v,206,280 -d eta_v,42,112 $oldFile $newFile

# This is now done on frinkiac
#oldFile=surfaceTSUVZ.nc
#newFile=surfaceTSUVZ_reduce.nc
#
#ncks -d xi_rho,206,280 -d eta_rho,42,112 -d xi_psi,206,280 -d eta_psi,42,112 -d xi_u,206,280 -d eta_u,42,112 -d xi_v,206,280 -d eta_v,42,112 $oldFile $newFile


