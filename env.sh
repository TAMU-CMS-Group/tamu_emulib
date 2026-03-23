#!/bin/bash

export JAVA_HOME=/etc/alternatives/jre

# For DQM:
export ROOTSYS=/opt/cern/root_v6.18.04
export DQMCONFIG=$HOME/config/dqm
export SQLITE=$HOME/sqlite

# For XDAQ
export XDAQ_OS=linux
slc=cc7
[[ $(uname -m) == "x86_64" ]] && export XDAQ_PLATFORM="x86_64_$slc" || export XDAQ_PLATFORM="x86_$slc"
export $XDAQ_PLATFORM
export XDAQ_ROOT=/opt/xdaq
export XDAQ_SETUP_ROOT=$XDAQ_ROOT/share
export XDAQ_DOCUMENT_ROOT=$XDAQ_ROOT/htdocs
export XDAQ_PORT=20016

export BUILD_SUPPORT=build
export LD_LIBRARY_PATH=${BUILD_HOME}/${XDAQ_PLATFORM}/lib:$ROOTSYS/lib:$XDAQ_ROOT/lib:$LD_LIBRARY_PATH:$SQLITE/lib
export PATH=/usr/kerberos/bin:$JAVA_HOME/bin:$ROOTSYS/bin:$ANT_HOME/bin:$XDAQ_ROOT/bin:$PATH

export IFACE="em1"
export PC_IP="$(ip -4 addr show dev "$IFACE" | awk '/inet / { sub(/\/.*/, "", $2); print $2; exit }')"

#scl enable devtoolset-8 bash
