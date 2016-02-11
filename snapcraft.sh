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
cp ./build.sh $RUNDIR/
cp ./snapcraft.yaml $RUNDIR/
cp ./logo.png $RUNDIR/

cd $RUNDIR
snapcraft $OP
