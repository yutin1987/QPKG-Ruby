#!/bin/sh
CONF=/etc/config/qpkg.conf
QPKG_NAME="ruby"
QPKG_DIR=$(/sbin/getcfg $QPKG_NAME Install_Path -d "" -f $CONF)
BIN_PATH=/bin

case "$1" in
  start)
    ENABLED=$(/sbin/getcfg $QPKG_NAME Enable -u -d FALSE -f $CONF)
    if [ "$ENABLED" != "TRUE" ]; then
        echo "$QPKG_NAME is disabled."
        exit 1
    fi
    cp $QPKG_DIR/ruby $BIN_PATH/ruby
    cp $QPKG_DIR/gem $BIN_PATH/gem
    : ADD START ACTIONS HERE
    ;;

  stop)
    rm $BIN_PATH/ruby
    rm $BIN_PATH/gem
    : ADD STOP ACTIONS HERE
    ;;

  restart)
    $0 stop
    $0 start
    ;;

  *)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
esac

exit 0
