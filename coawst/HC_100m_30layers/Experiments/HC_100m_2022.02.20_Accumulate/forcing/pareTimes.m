close all;

names= {'Pair',       'Qair',     'Tair',      'Uwind',     'Vwind',       'rain',  'lwrad_down', 'swrad',    'HC_bdry'};
times= {'pair_time','qair_time', 'tair_time', 'wind_time', 'wind_time', 'rain_time', 'lrf_time', 'srf_time', 'ocean_time'};


% for ff=1:length(names)
for ff=4:4
        
    unix(['\rm dum*']);

    fileOrig = [char(names(ff)),'.nc_ORIG'];
    
    tOrig = nc_varget(fileOrig,char(times(ff)));
    fig(1);clf;
    plot(tOrig)
    
    myMax = 0;
    keepers = [];
    
    for tt=1:length(tOrig)
        tt;
        if tOrig(tt) > myMax
            keepers = [ keepers tt];
            myMax = tOrig(tt);
        end;
    end;
    
    fig(2);clf;
    plot(keepers,tOrig(keepers))
    
    [~,breaks] =  find(diff(keepers) > 1);
    
    
    keepers(0+1:breaks(1))
    keepers(breaks(1)+1:breaks(2))
    keepers(breaks(2)+1:breaks(3))
    keepers(breaks(3)+1:breaks(4))
    keepers(breaks(4)+1:end)
    
    breaks = [0 breaks length(keepers)]
    
    keepers(breaks(1)+1:breaks(2))
    keepers(breaks(2)+1:breaks(3))
    keepers(breaks(3)+1:breaks(4))
    keepers(breaks(4)+1:breaks(5))
    keepers(breaks(5)+1:breaks(6))
    
    for ii=1:length(breaks)-1
        if ii<10
            index=['0',num2str(ii)];
        else
            index=num2str(ii);
        end;
        ['ncks -O -d ',char(times(ff)),',',num2str(keepers(breaks(ii)+1)-1),',',num2str(keepers(breaks(ii+1)-1)),' ',fileOrig,' dum_',index,'.nc']
        unix(['ncks -O -d ',char(times(ff)),',',num2str(keepers(breaks(ii)+1)-1),',',num2str(keepers(breaks(ii+1)-1)),' ',fileOrig,' dum_',index,'.nc']);  
        aaa=5;
    end;    
    
    aaa=5;
    
    
    
%     for ii=1:length(breaks)-1
%         ['ncks -O -d ',char(times(ff)),',',num2str(keepers(breaks(ii)+1)-1),',',num2str(keepers(breaks(ii+1)-1)),' ',fileOrig,' dum_',num2str(ii),'.nc']
%         unix(['ncks -O -d ',char(times(ff)),',',num2str(keepers(breaks(ii)+1)-1),',',num2str(keepers(breaks(ii+1)-1)),' ',fileOrig,' dum_',num2str(ii),'.nc']);
%         aaa=5;
%     end;
   
    unix(['ncrcat -O dum_*.nc ',char(names(ff)),'.nc'])
    
    
    % Double check
    fig(3);clf;
    dum=nc_varget([char(names(ff)),'.nc'],char(times(ff)));plot(dum)
    
end;

unix(['\rm *ORIG dum*'])


