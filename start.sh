#!/bin/sh
set -e

export MALLOC_ARENA_MAX=1

echo "[kura] --------- STARTING ECLIPSE KURA ---------"

# echo "[kura] --------- VARS ---------"
# printenv
# echo "[kura] --------- /VARS ---------"

# SNAP_ORIGIN=sideload
# SNAP_APP=eclipse-kura_kura_IMaGHPFIBKHW
# TEMPDIR=/tmp
# LD_LIBRARY_PATH=/snaps/eclipse-kura.sideload/IMaGHPFIBKHW/usr/lib/arm-linux-gnueabihf/mesa:/snaps/eclipse-kura.sideload/IMaGHPFIBKHW/lib:/snaps/eclipse-kura.sideload/IMaGHPFIBKHW/usr/lib:/snaps/eclipse-kura.sideload/IMaGHPFIBKHW/lib/arm-linux-gnueabihf:/snaps/eclipse-kura.sideload/IMaGHPFIBKHW/usr/lib/arm-linux-gnueabihf:
# SNAP_USER_DATA=//snaps/eclipse-kura.sideload/IMaGHPFIBKHW
# SNAP_APP_PATH=/snaps/eclipse-kura.sideload/IMaGHPFIBKHW
# TMPDIR=/tmp
# SNAP_VERSION=IMaGHPFIBKHW
# SNAP_APP_TMPDIR=/tmp
# SNAPP_APP_TMPDIR=/tmp
# PATH=/snaps/eclipse-kura.sideload/IMaGHPFIBKHW/usr/lib/jvm/default-java/bin:/snaps/eclipse-kura.sideload/IMaGHPFIBKHW/usr/lib/jvm/default-java/jre/bin:/snaps/eclipse-kura.sideload/IMaGHPFIBKHW/bin:/snaps/eclipse-kura.sideload/IMaGHPFIBKHW/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# SNAP_APP_USER_DATA_PATH=//snaps/eclipse-kura.sideload/IMaGHPFIBKHW
# SNAP_DATA=/var/lib/snaps/eclipse-kura.sideload/IMaGHPFIBKHW
# LANG=C.UTF-8
# SNAP_FULLNAME=eclipse-kura.sideload
# SNAP_ARCH=armhf
# SNAP_NAME=eclipse-kura
# PWD=/snaps/eclipse-kura.sideload/IMaGHPFIBKHW
# JAVA_HOME=/snaps/eclipse-kura.sideload/IMaGHPFIBKHW/usr/lib/jvm/default-java
# MALLOC_ARENA_MAX=1
# SNAP=/snaps/eclipse-kura.sideload/IMaGHPFIBKHW
# SNAP_APP_DATA_PATH=/var/lib/snaps/eclipse-kura.sideload/IMaGHPFIBKHW


DIR="${SNAP}/opt/eclipse/kura"

LOGDIR=${SNAP_APP_DATA_PATH}/var/log
TMPDIR=${SNAP_APP_TMPDIR}

echo "[kura] dirs:"
echo "[kura] ------------------------------------------"
# echo "[kura] > app path       $SNAP_APP_PATH"
# echo "[kura] > app data path  $SNAP_APP_DATA_PATH"
# echo "[kura] ---"
echo "[kura] > app dir path   $DIR"
echo "[kura] > logs           $LOGDIR"
echo "[kura] > tmp            $TMPDIR"

mkdir -p $LOGDIR
mkdir -p $TMPDIR

cd $DIR

# set up the configuration area
echo "[kura] set up the configuration area"
mkdir -p $TMPDIR/.kura/configuration
cp ${DIR}/kura/config.ini $TMPDIR/.kura/configuration/

echo "[kura] start OSGi service"
java -Xms512m -Xmx512m -XX:MaxPermSize=64m \
      -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=$LOGDIR/kura-heapdump.hprof \
      -XX:ErrorFile=$LOGDIR/kura-error.log \
      -Dkura.os.version=raspbian \
      -Dkura.arch=armv7_hf \
      -Dtarget.device=raspberry-pi-2 \
      -Declipse.ignoreApp=true \
      -Dkura.home=${DIR}/kura \
      -Dkura.configuration=file:${DIR}/kura/kura.properties \
      -Dkura.custom.configuration=file:${DIR}/kura/kura_custom.properties \
      -Dkura.data.dir=${DIR}/data \
      -Ddpa.configuration=${DIR}/kura/dpa.properties \
      -Dlog4j.configuration=file:${DIR}/kura/log4j.properties \
      -Djava.security.policy=${DIR}/kura/jdk.dio.policy \
      -Djdk.dio.registry=${DIR}/kura/jdk.dio.properties \
      -Djdk.tls.trustNameService=true \
      -jar ${DIR}/plugins/org.eclipse.osgi_3.8.1.v20120830-144521.jar \
      -configuration  $TMPDIR/.kura/configuration \
      -console 5002 \
      -consoleLog
