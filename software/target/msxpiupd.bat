echo Updating MSXPi client and server software...
echo Setting date & time...
pdate
echo
echo Updating MSXPIUPD.BAT
pcopy https://github.com/costarc/MSXPi/raw/master/software/target/msxpiupd.tmp?raw=true
DEL MSXPIRFH.BAT
pcopy https://github.com/costarc/MSXPi/raw/master/software/target/msxpirfh.bat?raw=true
MSXPIRFH.BAT
