# bodge

LEFT='DP-2'
RIGHT='DP-3'

xrandr --output $RIGHT --primary --right-of $LEFT --mode 2560x1440 --rate 144 --output $LEFT --mode 1920x1080 --rate 75 --rotate left

xrandr --output $RIGHT --pos 1080x240

noisetorch -i
openrgb -p default

