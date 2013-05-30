#!/bin/sh
CONF=/etc/config/qpkg.conf
QPKG_NAME="ruby"
QPKG_DIR=$(/sbin/getcfg $QPKG_NAME Install_Path -d "" -f $CONF)
PATH_RUBY=/opt/bin/ruby
PATH_GEM=/opt/bin/gem

case "$1" in
  start)
    ENABLED=$(/sbin/getcfg $QPKG_NAME Enable -u -d FALSE -f $CONF)
    if [ "$ENABLED" != "TRUE" ]; then
        echo "$QPKG_NAME is disabled."
        exit 1
    fi
    cp $QPKG_DIR/ruby $PATH_RUBY
    cp $QPKG_DIR/gem $PATH_GEM
    : ADD START ACTIONS HERE
    ;;

  stop)
    rm $PATH_RUBY
    rm $PATH_GEM
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
