
% addpath /home/hunter/roms/tides/tmd_toolbox
% addpath /home/hunter/roms/tides/tmd_toolbox/FUNCTIONS
% addpath /home/hunter/roms/tides/t_tide_v1.3beta

gfile='../Gridpak/SD_1km.nc'

% t0 date for tide data base. 1992-01-01 for TPXO
base_date=datenum(1992,1,1);

% mid-time of experiment set
% The  experiment runs from
%   2018 05 15     43233    6709    135 
% to
%   2018 07 14     43293    6769    195
% The middle of this interval is 
%		(6709+6769)/2 = 6739 = 2018 06 14



% mid-time of experiment set
% The  experiment runs from
%   2019 05 15     43598    7074    135 
% to
%   2019 06 30     43293    7120    181
% The middle of this interval is 
%		(7074+7120)/2 = 7097 = 2018 06 07


pred_date=datenum(2020,02,01);

ofile='AllComponents_2020_02_01.nc';
% model_file='DATA/Model_tpxo7.2';
model_file='/import/VERTMIXFS/jgpender/ROMS/OTIS_DATA/Model_tpxo9.v1';
otps2frc_v5(gfile,base_date,pred_date,ofile,model_file,'SD_1km')
