h = nc_varget('HC_100mME.nc','h');
mask = nc_varget('HC_100mME.nc','mask_rho');
[ny,nx] = size(mask);

% The section of the UW grid mask_rho that corresponds to the 
% top of the channel on my grid is
%       h(211,117:125) =  
UWh =   [ 	31.6142174312767          
            42.7721765246684           
            57.601150816043          
            75.1703415849805          
            94.7844013827707
            112.747844455662          
            83.3353632933151          
            61.5957027378634          
            45.5272575612185     ];

% The cell length is 501.5975794 m
% 
% The idea is to make the cross sectional area of my opening match that of
% the UW grid

UWwidth = length(UWh) * 501.5975794
UWarea = sum( UWh * 501.5975794  )
                        
% That same cross section on my grid is

fig(1);clf;
imagesc(mask);axis xy;ylim([ny-5 ny]);xlim([nx-52 nx])


aaa=5;

jgpRange = [nx-50:nx-10];


mask(end,jgpRange);
% 100 meter grid interval
JGPwidth = length(ans)*100

% So both UW and I have 4500m as the width of the channel.

JGParea = sum( 100 .* h(end,jgpRange)  )

%% Plot h and grid

size(h)
size(mask)


fig(3);clf;imagesc(mask.*h);axis xy; colorbar



                        