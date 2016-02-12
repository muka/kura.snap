
DIST_SRC="https://s3.amazonaws.com/kura_downloads/raspbian/release/1.3.0/kura_1.3.0_raspberry-pi-2_installer.deb"

echo "* Fetch kura"
if [ ! -f "/tmp/kura.deb" ]; then
  wget -O /tmp/kura.deb $DIST_SRC
fi

echo "* Extracting release"
dpkg -x /tmp/kura.deb ./kuradeb
unzip kuradeb/tmp/kura_*.zip -d ./ > /dev/null

mv kura_* kura

mkdir -p $DESTDIR/opt/eclipse

mkdir -p $DESTDIR/var/log
mkdir -p $DESTDIR/etc/network

cp -ar kura $DESTDIR/opt/eclipse

echo "* Finished setup"

exit 0
