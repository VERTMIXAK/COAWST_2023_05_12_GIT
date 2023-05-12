Gnames = {'../Gridpak/GUAMLinner_1km.nc','../Gridpak/GUAMLinnerNest_1km.nc'};
Hnames = {'ini_074/Flat_2022_074_ic_GUAMLinner_1km.nc','ini_074_nest/Flat_2022_074_ic_GUAMLinnerNest_1km.nc'};

Vname = 'v';
Tindex = 1;
Level = 7;

F = plot_nesting(Gnames, Hnames, Vname, Tindex, Level);shading flat
