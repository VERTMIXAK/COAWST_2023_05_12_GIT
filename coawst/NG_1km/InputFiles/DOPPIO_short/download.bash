part1='http://tds.marine.rutgers.edu/thredds/ncss/roms/doppio/2017_da/his/runs/History_RUN_'
part2a='?var=angle&var=f&var=h&var=mask_psi&var=mask_rho&var=mask_u&var=mask_v&var=pm&var=pn&var=zeta&var=salt&var=temp'
part2b='?var=u_eastward&var=v_northward&var=ubar_eastward&var=vbar_northward&var=shflux&var=ssflux&var=sustr&var=svstr&var=swrad_daily'
part3='&disableLLSubset=on&disableProjSubset=on&horizStride=1&time_start='
part4='&time_end='
part5='&time_Stride=1&vertCoord=&accept=netcdf'

year='2020'
month='06'

for day in `seq -w 25 30`
do
	date=$year'-'$month'-'$day
	dayNumber=`grep $date /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f4`
    file=$date'T00:00:00Z'
	timeStamp1=$date'T00%3A00%3A00Z'
    timeStamp2=$date'T23%3A00%3A00Z'

	site=$part1$file$part2a$part3$timeStamp1$part4$timeStamp2$part5
	echo $site
    while [ ! -f MERRA*$date*.nc ]
    do
		wget --load-cookies ~/.urs_cookies --save-cookies ~/.urs_cookies --auth-no-challenge=on --keep-session-cookies --content-disposition $site
	done

    site=$part1$file$part2b$part3$timeStamp1$part4$timeStamp2$part5
    echo $site
	while [ ! -f MERRA*$date*.nc.1 ]
	do
    	wget --load-cookies ~/.urs_cookies --save-cookies ~/.urs_cookies --auth-no-challenge=on --keep-session-cookies --content-disposition $site
	done
done




#: <<'COMMENTBLOCK'


year='2020'
month='07'

for day in `seq -w 1 31`
do
    date=$year'-'$month'-'$day
    dayNumber=`grep $date /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f4`
    file=$date'T00:00:00Z'
    timeStamp1=$date'T00%3A00%3A00Z'
    timeStamp2=$date'T23%3A00%3A00Z'

    site=$part1$file$part2a$part3$timeStamp1$part4$timeStamp2$part5
    echo $site
    while [ ! -f MERRA*$date*.nc ]
    do
        wget --load-cookies ~/.urs_cookies --save-cookies ~/.urs_cookies --auth-no-challenge=on --keep-session-cookies --content-disposition $site
    done

    site=$part1$file$part2b$part3$timeStamp1$part4$timeStamp2$part5
    echo $site
    while [ ! -f MERRA*$date*.nc.1 ]
    do
        wget --load-cookies ~/.urs_cookies --save-cookies ~/.urs_cookies --auth-no-challenge=on --keep-session-cookies --content-disposition $site
    done
done


year='2020'
month='08'

for day in `seq -w 1 10`
do
    date=$year'-'$month'-'$day
    dayNumber=`grep $date /import/VERTMIXFS/jgpender/roms-kate_svn/addl_Scripts/dayConverterCommas.txt | cut -d ',' -f4`
    file=$date'T00:00:00Z'
    timeStamp1=$date'T00%3A00%3A00Z'
    timeStamp2=$date'T23%3A00%3A00Z'

    site=$part1$file$part2a$part3$timeStamp1$part4$timeStamp2$part5
    echo $site
    while [ ! -f MERRA*$date*.nc ]
    do
        wget --load-cookies ~/.urs_cookies --save-cookies ~/.urs_cookies --auth-no-challenge=on --keep-session-cookies --content-disposition $site
    done

    site=$part1$file$part2b$part3$timeStamp1$part4$timeStamp2$part5
    echo $site
    while [ ! -f MERRA*$date*.nc.1 ]
    do
        wget --load-cookies ~/.urs_cookies --save-cookies ~/.urs_cookies --auth-no-challenge=on --keep-session-cookies --content-disposition $site
    done
done

#COMMENTBLOCK

bash tidyUp.bash

bash getGrid.bash
