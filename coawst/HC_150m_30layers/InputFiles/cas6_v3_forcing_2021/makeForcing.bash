\rm *.nc

echo "Pair"
ncrcat archive/P*2020* archive/P*2021.01.0*	Pair.nc
echo "Qair"
ncrcat archive/Q*2020* archive/Q*2021.01.0*   Qair.nc
echo "Tair"
ncrcat archive/T*2020* archive/T*2021.01.0*   Tair.nc
echo "rain"
ncrcat archive/r*2020* archive/r*2021.01.0*   rain.nc
echo "lwrad"
ncrcat archive/l*2020* archive/l*2021.01.0*   lwrad_down.nc
echo "swrad"
ncrcat archive/sw*2020* archive/sw*2021.01.0*   swrad.nc
echo "Uwind"
ncrcat archive/U*2020* archive/U*2021.01.0*   Uwind.nc
echo "Vwind"
ncrcat archive/V*2020* archive/V*2021.01.0*   Vwind.nc
