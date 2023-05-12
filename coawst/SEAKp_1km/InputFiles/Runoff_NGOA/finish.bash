source ~/.runPycnal

#dates='09012013_08312014'
#
#cp make_river_clim.py_template make_river_clim.py
#sed -i "s/DATES/$dates/g" make_river_clim.py
#
#outName="SEAKp_rivers_"$dates".nc"
#echo $outName
#
#python add_rivers.py 		$outName
#python make_river_clim.py
#python add_temp.py         	$outName
#python set_temp.py       	$outName
#python set_vshape.py      	$outName


dates='09012014_08312015'

cp make_river_clim.py_template make_river_clim.py
sed -i "s/DATES/$dates/g" make_river_clim.py

outName="SEAKp_rivers_"$dates".nc"
echo $outName

python add_rivers.py        $outName
python make_river_clim.py
python add_temp.py          $outName
python set_temp.py          $outName
python set_vshape.py        $outName





dates='09012015_08312016'

cp make_river_clim.py_template make_river_clim.py
sed -i "s/DATES/$dates/g" make_river_clim.py

outName="SEAKp_rivers_"$dates".nc"
echo $outName

python add_rivers.py        $outName
python make_river_clim.py
python add_temp.py          $outName
python set_temp.py          $outName
python set_vshape.py        $outName





dates='09012016_08312017'

cp make_river_clim.py_template make_river_clim.py
sed -i "s/DATES/$dates/g" make_river_clim.py

outName="SEAKp_rivers_"$dates".nc"
echo $outName

python add_rivers.py        $outName
python make_river_clim.py
python add_temp.py          $outName
python set_temp.py          $outName
python set_vshape.py        $outName




dates='09012017_08312018'

cp make_river_clim.py_template make_river_clim.py
sed -i "s/DATES/$dates/g" make_river_clim.py

outName="SEAKp_rivers_"$dates".nc"
echo $outName

python add_rivers.py        $outName
python make_river_clim.py
python add_temp.py          $outName
python set_temp.py          $outName
python set_vshape.py        $outName


