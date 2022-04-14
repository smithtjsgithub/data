declare -i _finalnum=0
declare -i _ctfront=0
declare -i _pics=0
declare -i _blues=0
declare -i _rap=0
declare -i _itall=0
clear
echo "Front"
for i in `cat /tmp/front.txt`
do
let _ctfront++
#echo $i
echo $_ctfront " "$i; done
echo "Total :" $_ctfront

echo "Pictures"
for i in `cat /tmp/pics.txt`
do
let _pics++
#echo $i
echo $_pics " "$i;done
echo "Total :" $_pics

echo "Blues"
for i in `cat /tmp/blues.txt`
do
let _blues++
#echo $i
echo $_blues " "$i;done
echo "Total :" $_blues

echo "Rap"
for i in `cat /tmp/rap.txt`
do
let _rap++
#echo $i
echo $_rap " "$i;done
echo "Total :" $_rap

echo "itALL"
for i in `cat /tmp/front.txt && cat /tmp/itall.txt`
do
let _itall++
#echo $i
echo $_itall " "$i;done
#$_finalnum=$($_ctfront + $_itall)
#echo "Total :" $_finalnum
echo " "
#_current=$(ps -ef | egrep -m 1 -i '/usr/bin/omxplayer.bin|"*.mp4"' | awk '{print $9}')
ps -ef | egrep -m 1 -i '/usr/bin/omxplayer.bin|"*.mp4"' | awk '{print "On Screen Now: " $10}'
