DEVICE=/dev/ttyUSB0
while true
do
  socat  TCP-LISTEN:4001,fork,keepalive,nodelay,reuseaddr pty,rawer,link=$DEVICE > /tmp/socat.log
done &
fish
