#!/bin/bash
Q2DIR=/home/quake2/.q2pro
BASEQ2DIR=$Q2DIR/baseq2
OPENTDMDIR=$Q2DIR/opentdm

baseq2content=(condumps demos env maps players save sound textures)

if [ ! -d "$BASEQ2DIR" ]; then
    mkdir -p $BASEQ2DIR
    for directory in ${baseq2content[@]}
    do
	mkdir -p $BASEQ2DIR/$directory
    done
fi
if [ ! -d "$OPENTDMDIR" ]; then
  mkdir -p $OPENTDMDIR

  cp /opt/q2pro/opentdm/gamex86_64-opentdm-r*.so $OPENTDMDIR/gamex86_64.so
  cp /opt/q2pro/opentdm/README.md $OPENTDMDIR/
  cp /opt/q2pro/share/q2pro/opentdm.cfg $BASEQ2DIR/
fi

/opt/q2pro/bin/q2proded +exec opentdm.cfg +set dedicated 1 +set deathmatch 1
