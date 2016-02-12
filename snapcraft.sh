#!/bin/sh

#
# Running from a shared vagrant folder causes the jdk plugin to fail
# This allow to copy files and run from a local folder
#
# USAGE: ./snapcraft.sh <command>
#

OP=$1
RUNDIR=~/kura.snap

mkdir -p $RUNDIR

cp ./Makefile $RUNDIR/
cp -r ./bin $RUNDIR/
cp ./snapcraft.yaml $RUNDIR/
cp ./logo.png $RUNDIR/
cp ./start.sh $RUNDIR/

cd $RUNDIR
snapcraft $OP

mv $RUNDIR/eclipse-kura_1.0_amd64.snap ./
