#!/bin/bash

#  this is the masking function.
# You need to update the following:
#  1.  The path to dataveil
#  2.  The path to and filename of the project file
#  3.  The keyname saved with the project
#  4.  Log file location and name
#  5.  The path to and filename of the license key
#  6.  The connection string used to login to the Oracle Database

maskfunc()
{

/opt/dataveil/bin/dataveil --nosplash --nogui -J-Dnetbeans.logger.console=true -J-Dorg.level=WARNING -J-Xms64m -J-Xmx512m --refreshschema=false --compilewarning=continue --createdirs=true --project="/opt/dataveil/userfiles/prodmask.dvp" --key="actifio" --log="/opt/dataveil/log/CPROD.log" --license="/opt/dataveil/userfiles/license.dvl" --con="{sid=CPROD,host=10.65.5.125,port=1521,user=scott,password=tiger}"

}

# this part of the script ensures we run the masking during a scrub mount after the database is started on the scrubbing server
if [ "$ACT_MULTI_OPNAME" == "scrub-mount" ] && [ "$ACT_MULTI_END" == "true" ] && [ "$ACT_PHASE" == "post" ]; then
	maskfunc
	exit $?
fi

# this part of the script ensures we run the masking during a direct mount after the database is started on the scrubbing server
if [ "$ACT_MULTI_OPNAME" == "mount" ] && [ "$ACT_MULTI_END" == "true" ] && [ "$ACT_PHASE" == "post" ]; then
	maskfunc
	exit $?
fi

# this lets us run this script manually
if [ "$1" == "test" ]; then
	maskfunc
	exit $?
fi

exit 0
