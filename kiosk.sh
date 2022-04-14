# Disable any form of screen saver / screen blanking / power management
declare -i _rnum=-20
declare -i _delay=30
_ip_address=($(hostname -I | awk '{print $1}'))
export DISPLAY=':0.0'
xset s off
xset s noblank
xset -dpms
unset links

#Setup Links/Tab Rotation
declare -a front=($(curl http://192.168.0.193/data/software/beauty.txt | sort -R | head "$_rnum" )) 
declare -a local=($(ls /home/pi/*.jpg | sort -R | head "$_rnum" ))
declare -a pics=($(ls /home/pi/pics/*.jpg | sort -R | head "$_rnum" ))
declare -a links=($(curl http://192.168.0.193/data/software/websites.txt | sort -R | head "$_rnum" ))
declare -a monitor="http://192.168.0.210:19999 http://192.168.0.211:19999 http://192.168.0.212:19999 http://192.168.0.55/devices/Alldevices/?dashboard=187&username=librenms&password=password"

echo ${front[@]} > /tmp/k_front.txt
echo ${local[@]} > /tmp/k_local.txt
echo ${pics[@]} > /tmp/k_pics.txt
echo ${links[@]} > /tmp/k_links.txt
echo ${monitor[@]} > /tmp/k_monitor.txt

declare -a itall=(${front[@]} ${pics[@]} ${monitor[@]} ${links[@]})
echo ${itall[@]} > /tmp/itall.txt

#Scrap Yard
#declare -a pics=($(curl http://192.168.0.193/data/software/pics_web.txt | sort -R | head "$_rnum" ))
# --noerrdialogs \
# --remote-debugging-address=$_ip_address \
#--kiosk file:///home/pi/ip_address.jpg file:///home/pi/current_day.jpg file:///home/pi/current_date.jpg ${itall[*]} &
#--kiosk file:///home/pi/ip_address.jpg ${front[*]} ${links[*]} &

#Don't forget to "apt install unclutter"
unclutter -idle 0.5 -root &

# Escape Keys: Quit the X server with CTRL-ATL-Backspace
setxkbmap -option terminate:ctrl_alt_bksp

#Clean Up Failed Chrome Starts
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences

#Launch Chrome Browser
/usr/bin/chromium-browser \
 --start-fullscreen \
 --noerrdialogs \
 --incognito \
 --disable-logging \
 --disable-infobars \
 --disable-overlay-scrollbar \
 --disable-cache \
 --disable-sync \
 --no-managed-user-acknowledgment-check \
 --temp-profile \
 --disable-translate \
 --disk-cache-dir=/dev/null \
 --disable-popup-blocking \
 --disable-session-crashed-bubble \
 --disk-cache-size=1 \
 --disable-notifications \
 --window-size=1920,1080 \
 --disable-prompt-on-repost \
 --no-first-run \
 --noerrors \
 --mute-audio \
 --kiosk  http://192.168.0.173/s15/ http://192.168.0.193/data/pics/dc_inaction.jpg  http://192.168.0.193/data/pics/dc_live.jpg http://192.168.0.193/data/pics/dc_promotion.jpg /home/pi/computerison_flipped.jpg http://nginxrandom.kuntryboi.local/ /home/pi/ip_address.jpg https://www.davisfhofalabama.com/ {local[*]} ${itall[*]} &

#Rotate Tabs
while true; do
   _date=$(date +%Y%m%d:%T)
   xdotool keydown ctrl+Tab; xdotool keyup ctrl+Tab;
   WTITLE=$(xdotool getactivewindow getwindowname)
   echo "$_date:" $WTITLE >> /home/pi/kiosk.log;
   sleep $_delay
done
