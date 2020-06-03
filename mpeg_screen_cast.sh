ffmpeg -f x11grab -s 1280x800 -framerate 15 -i :0.0 -c:v libx264 -preset fast -pix_fmt yuv420p -s 1280x800 -threads 0 -f mpegts -listen 1 -f mpegts http://192.168.1.4:7000

