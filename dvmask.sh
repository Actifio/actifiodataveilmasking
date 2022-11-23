# Copyright 2022 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#!/bin/bash
#  this is the masking function.
# You need to update the following:
#  1.  The path to dataveil
#  2.  The path to and filename of the project file
#  3.  The keyname saved with the project
#  4.  Log file location and name
#  5.  The path to and filename of the license key
#  6.  Optionally you need to unhash the native functions loader and edit it

maskfunc()
{
###  native functions loader, SID and SQL script name and file path to the native library folders may need to chnage
# su - oracle -c 'cd /opt/dataveil/native/oracle;export ORACLE_SID=CPROD;sqlplus / as sysdba @/act/scripts/loadnativefunctions.sql;exit'

/opt/dataveil/bin/dataveil --nosplash --nogui -J-Dnetbeans.logger.console=true -J-Dorg.level=WARNING -J-Xms64m -J-Xmx512m --refreshschema=false --compilewarning=continue --createdirs=true --project="/opt/dataveil/userfiles/prodmask.dvp" --key="actifio" --log="/opt/dataveil/log/CPROD.log" --license="/opt/dataveil/userfiles/license.dvl"

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

# if we are manually running the script remind the user how to test it
if [ -z "$1" ]; then
	echo "If you want to run this script as a test then please use the following command:"
	echo "$0 test"
fi


# this lets us run this script manually
if [ "$1" == "test" ]; then
	maskfunc
	exit $?
fi

exit 0
