Gnames = {'../Gridpak/GUAMKinner_1km.nc','../Gridpak/GUAMKinnerNest_1km.nc'};
Hnames = {'ini_074/Flat_2022_074_ic_GUAMKinner_1km.nc','ini_074_nest/Flat_2022_074_ic_GUAMKinnerNest_1km.nc'};

Vname = 'v';
Tindex = 1;
Level = 7;

F = plot_nesting(Gnames, Hnames, Vname, Tindex, Level);shading flat