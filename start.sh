#!/bin/sh
set -e

export MALLOC_ARENA_MAX=1

DIR="$SNAP_APP_DATA_PATH/opt/eclipse/kura"

LOGDIR=$SNAP_APP_USER_DATA_PATH/var/log
TMPDIR=$SNAP_APP_USER_DATA_PATH/tmp

cd $DIR

# set up the configuration area
mkdir -p $TMPDIR/.kura/configuration
cp ${DIR}/kura/config.ini $TMPDIR/.kura/configuration/

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
