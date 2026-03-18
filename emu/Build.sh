#!/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR/.."

# for Emulib15
export set BUILD_HOME=$PROJECT_ROOT
source ~cscdev/setup_emulib_env.sh
if [ "$1" = "clean" ]; then
	Set=framework make -j 8 clean
	echo "Cleaned"
	exit 0
fi
Set=framework bear -- make -j 8 install >&make-install-framework.log
grep error: make-install-framework.log
if [ "$1" = "build" ]; then
	echo "Built"
	exit 0
fi
#### ME11 test configuratoion (modified by Ange)
xdaq.exe -h 10.119.64.4 -p 20016 -e $PROJECT_ROOT/xml/default.profile_cc7_noXMAS -c $PROJECT_ROOT/xml/tamu_test2019_GEM.xml
####ME21 test configuration
#xdaq.exe -h 10.119.64.4 -p 20016 -e $PROJECT_ROOT/xml/default.profile_cc7_noXMAS -c $PROJECT_ROOT/xml/tamu_test2021_MEX1_SLHCon.xml
#xdaq.exe -h 10.119.64.4 -p 20016 -e $PROJECT_ROOT/xml/default.profile_cc7_noXMAS  -c $PROJECT_ROOT/xml/tamu_test2019_GEM.xml
#Set=framework make -j 8 clean
