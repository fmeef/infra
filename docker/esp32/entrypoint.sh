DEVICE=/dev/esp0
while true
do
  socat  TCP-LISTEN:4001,fork,keepalive,nodelay,reuseaddr pty,rawer,link=$DEVICE,mode=660 > /tmp/socat.log
done &
fish
