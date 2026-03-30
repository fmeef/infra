DEVICE=/dev/flipper0
while true
do
  sudo  socat  TCP-LISTEN:4001,fork,keepalive,nodelay,reuseaddr pty,rawer,link=$DEVICE,group-late=user,mode=660 > /tmp/socat.log
done &
pyenv shell 3.11
fish
