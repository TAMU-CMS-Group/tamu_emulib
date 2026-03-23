#!/usr/bin/bash

PROJECT_ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# for Emulib15
export set BUILD_HOME="$PROJECT_ROOT_DIR"
source "$PROJECT_ROOT_DIR/env.sh"

[ -n "$PC_IP" ] || {
	echo "No IPv4 address found on $IFACE" >&2
	exit 1
}

if [ "$1" = "clean" ]; then
	Set=framework make -j 8 clean
	echo "Cleaned"
	exit 0
fi
Set=framework bear -- make -j 8 install >&./logs/make-install-framework.log
grep error: ./logs/make-install-framework.log
if [ "$1" = "build" ]; then
	echo "Built"
	exit 0
fi

export set XDAQ_ENV="$PROJECT_ROOT_DIR/xml/default.profile_cc7_noXMAS"
export set XDAQ_CONF="$PROJECT_ROOT_DIR/xml/tamu_test2019_GEM.xml"
export set CRATE_CONF="tamu_crate_config_1otmbs2019_GEM.xml"

sed -i "s|url=\"http://[^\"]*:$XDAQ_PORT\"|url=\"http://$PC_IP:$XDAQ_PORT\"|g" "$XDAQ_CONF"

## ME11 test configuratoion (modified by Ange)
xdaq.exe -h $PC_IP -p $XDAQ_PORT -e $XDAQ_ENV -c $XDAQ_CONF
