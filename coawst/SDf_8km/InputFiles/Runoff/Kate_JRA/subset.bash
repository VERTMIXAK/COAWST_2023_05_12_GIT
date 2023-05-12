sourceDir='/import/AKWATERS/kshedstrom/JRA55-flooded'


# SD limits
#
region='SD'

latMin=30
latMax=35
lonMin=235
lonMax=245

year="2018"





# The runoff files are on a somewhat different grid

# lat goes from -89.875 to 89.875 on a perfectly regular .25 degree grid
# lon goes from .125 to 359.875 on a perfectly regular .25 degree grid

xmin=`echo "$lonMin / .25 " | bc`
xmax=`echo "$lonMax / .25 " | bc`
ymin=`echo "( $latMin + 89.875 ) / .25 + 1" | bc`
ymax=`echo "( $latMax + 89.875 ) / .25 + 1" | bc`

echo $xmin
echo $xmax
echo $ymin
echo $ymax



for file in `ls $sourceDir/runoff*$year.nc`
do

    echo "sourceFile =" $file

    shortName=`echo $file | rev | cut -d '/' -f1 | rev `
    echo $file  $shortName

    part1=`echo $shortName | cut -d '.' -f1-2`
    newName=`echo "runoff_"$year"_"$region".nc"`

    echo "newName=" $newName

	echo " ncks -O -d lon,$xmin,$xmax -d lat,$ymin,$ymax $file $newName  "

    ncks -O -d lon,$xmin,$xmax -d lat,$ymin,$ymax $file $newName
done

