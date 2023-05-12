#!/bin/csh
#################################################################
# Csh Script to retrieve 2 online Data files of 'ds633.0',
# total 2.14G. This script uses 'wget' to download data.
#
# Highlight this script by Select All, Copy and Paste it into a file;
# make the file executable and run it on command line.
#
# You need pass in your password as a parameter to execute
# this script; or you can set an environment variable RDAPSWD
# if your Operating System supports it.
#
# Contact davestep@ucar.edu (Dave Stepaniak) for further assistance.
#################################################################


set pswd = $1
if(x$pswd == x && `env | grep RDAPSWD` != '') then
 set pswd = $RDAPSWD
endif
if(x$pswd == x) then
 echo
 echo Usage: $0 YourPassword
 echo
 exit 1
endif
set v = `wget -V |grep 'GNU Wget ' | cut -d ' ' -f 3`
set a = `echo $v | cut -d '.' -f 1`
set b = `echo $v | cut -d '.' -f 2`
if(100 * $a + $b > 109) then
 set opt = 'wget --no-check-certificate'
else
 set opt = 'wget'
endif
set opt1 = '-O Authentication.log --save-cookies auth.rda_ucar_edu --post-data'
set opt2 = "email=jgpender@alaska.edu&passwd=$pswd&action=login"
$opt $opt1="$opt2" https://rda.ucar.edu/cgi-bin/login
set opt1 = "-N --load-cookies auth.rda_ucar_edu"
set opt2 = "$opt $opt1 https://rda.ucar.edu/dsrqst/PENDER492736/"
set filelist = ( \
  TarFiles/492736.SP.e5.oper.an.sfc.128_134_sp.ll025sc.2018010100_2018013123-VAR_10V.e5.oper.an.sfc.128_166_10v.ll025sc.2018110100_2018113023.nc.tar \
  TarFiles/492736.VAR_10V.e5.oper.an.sfc.128_166_10v-2T.e5.oper.an.sfc.128_167_2t.ll025sc.2018120100_2018123123.nc.tar \
)
while($#filelist > 0)
 set syscmd = "$opt2$filelist[1]"
 echo "$syscmd ..."
 $syscmd
 shift filelist
end

