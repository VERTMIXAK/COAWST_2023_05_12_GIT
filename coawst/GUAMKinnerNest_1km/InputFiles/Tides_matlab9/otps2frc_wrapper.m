
gfile='../Gridpak_nest2/GUAMKinnerNest_1km.nc'

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


% mid-time of experiment set
% The  experiment runs from
%   2022 05 15     44694    8170    135
% to
%   2022 05 21     44700    8176    181
% The middle of this interval is
%	(8170+8176)/2 = 8173 = 2022 05 18


pred_date=datenum(2022,05,18);

ofile='AllComponents_2022_05_18.nc';
% model_file='DATA/Model_tpxo7.2';
model_file='/import/VERTMIXFS/jgpender/ROMS/OTIS_DATA/Model_tpxo9.v1';
otps2frc_v5(gfile,base_date,pred_date,ofile,model_file,'GUAMKinnerNest')
