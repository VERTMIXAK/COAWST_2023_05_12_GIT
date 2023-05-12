
gfile='../Gridpak/GUAMLinner_1km.nc'

% t0 date for tide data base. 1992-01-01 for TPXO
base_date=datenum(1992,1,1);


% mid-time of experiment set
% The  experiment runs from
%   2022 03 15     44633    8109    074
% to
%   2022 04 20     44672    8145    111
% The middle of this interval is
%	(8109+8145)/2 = 8127 = 2022 04 02


pred_date=datenum(2022,04,02);

ofile='AllComponents_2022_04_02.nc';
% model_file='DATA/Model_tpxo7.2';
model_file='/import/VERTMIXFS/jgpender/ROMS/OTIS_DATA/Model_tpxo9.v1';
otps2frc_v5(gfile,base_date,pred_date,ofile,model_file,'GUAMKinnerNest')
