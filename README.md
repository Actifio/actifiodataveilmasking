# Masking with DataVeil

This readme contains a section for Microsoft SQL and a section for Oracle.

## Microsoft SQL Masking with Actifio and DataVeil

This readme describes how to use the bat file in this respository along with the DataVeil software to perform data masking with Actifio.

### Requirements

One Microsoft SQL Source Database we can mask.  This is our Production Database.
We need three Windows Servers, each with Microsoft SQL installed.  In general always use the same version of MS SQL on each server, as you may not be able to mount from a higher version to a lower version (although the reverse is normally possible, meaning production could a be a lower version than the masking server).


* Production Server (Production Side – hosts the source DB)
* Masking Server (Production Side – masks the source DB)
* Development Server (Non-Production Side – uses the masked DB)

For PoC we could use just one server (we don’t need three).
But in production you would never mask and run non-prod on the production server.

For each stage of the process use a different database name.  For instance:

* Production Name:   Finance
* Name when mounted to masking server:   maskfinance
* Name when mounted to development server:   devfinance

DataVeil needs to be copied onto your masking server.  Unpack it and then create folders to hold your working files and logs.

The steps we follow will be:

1. Install DataVeil onto your masking server (you also need JRE 1.8)
1. License DataVeil and note where you put the license file
1. Mount production database to masking server using the ‘middle’ name (i.e. mount ‘finance’ as ‘maskfinance’)
1. Create Project using Actifio DataVeil and note the Project key name
1. Save Project and note where you save the project
1. Install bat file onto masking server and customize it

The bat file must be located in C:\Program Files\Actifio\Scripts\dvmask.bat


There are five customizations needed in the bat file:

1. Change dataveil64.exe path to match yours
1. Change Project path and name to match yours
1. Change key defined in project to match yours
1. Change license path and name to match yours
1. Change log file path

If you change the .bat file name you need to change the workflow to point to the new name of the script
You must use the C:\Program Files\Actifio\Scripts folder, no other folder can be used
DO NOT put any other files called by the Batch file into C:\Program Files

### Test your bat file

Presuming we have created the project file and placed the bat file in the correct spot.
Presuming the relevant database is still mounted and ready. 
Run the bat file with the word ‘test’ as shown in the example:

~~~
c:
cd “Program Files\Actifio\Scripts”
dvmask.bat test
~~~

Now check the DataVeil log file defined in your bat file to ensure good masking has occurred.  You should actually see the result in your CMD prompt window anyway, but it is good to evaluate the logs were created.

This is an example of succesful masking execution:

```
2019-08-14 19:16:14.569 GEN-DEBUG [4924] Job_3399316 WinImpersonator: domain: au, username: actadmin
2019-08-14 19:16:14.647 GEN-INFO  [4924] Job_3399316 WinImpersonator: Ending impersonation of au\actadmin
2019-08-14 19:16:14.662 GEN-INFO  [4924] Job_3399316 Launched script with arguments [0]="C:\Program Files\Actifio\scripts\dvmask.bat" [1]=post pid 1572
2019-08-14 19:16:14.694 GEN-INFO  [4924] Job_3399316 Script: 
2019-08-14 19:16:14.694 GEN-INFO  [4924] Job_3399316 C:\Windows\system32>echo on 
2019-08-14 19:16:14.694 GEN-INFO  [4924] Job_3399316 
2019-08-14 19:16:14.694 GEN-INFO  [4924] Job_3399316 C:\Windows\system32>if "mount" == "scrub-mount" if "true" == "true" if "post" == "post" (GOTO maskcommand  ) 
2019-08-14 19:16:14.694 GEN-INFO  [4924] Job_3399316 
2019-08-14 19:16:14.694 GEN-INFO  [4924] Job_3399316 C:\Windows\system32>if "mount" == "mount" if "true" == "true" if "post" == "post" (GOTO maskcommand  ) 
2019-08-14 19:16:14.694 GEN-INFO  [4924] Job_3399316 Script:  is on.
2019-08-14 19:16:14.694 GEN-INFO  [4924] Job_3399316 Script: FinMask_av.dvp" --key="actifio" --license="D:\\DV_Files\\license.dvl" --log="D:\\logs\\dvlog.txt!" 
2019-08-14 19:16:16.756 GEN-INFO  [6476] Job_3399316 End eventloop ( Provider: VssConnector ServiceType:RESTORE )
2019-08-14 19:16:18.772 GEN-INFO  [4916] Job_3399316 Terminated connection with host 10.65.5.35 (ipaddress 10.65.5.35:56538) 
2019-08-14 19:16:28.287 GEN-INFO  [4924] Job_3399316 Script: 
2019-08-14 19:16:28.287 GEN-INFO  [4924] Job_3399316 C:\Windows\system32>IF 0 EQU 0 (GOTO cleanexit ) 
2019-08-14 19:16:28.287 GEN-INFO  [4924] Job_3399316 
```

### TroubleShooting 

This section will contain some suggestions for troubleshooting

#### Unmount or reprovision fails with permissions errors

During unmount or unmount portion of reprovision job, you may get an error like this:

```
5242: Actifio Connector: Failed to unmount applications for mounted image. SQL detach script failed with error Msg 5011, Level 14, State 9, Server SYDWINDV1, Line 1 User does not have permission to alter database 'pmbigdb', the database does not exist, or the database is not in a state that allows access checks. Msg 5069, Level 16, State 1, Server SYDWINDV1, Line 1 ALTER DATABASE statement failed. Msg 916, Level 14, State 1, Server SYDWINDV1, Line 1 The server principal "NT AUTHORITY\SYSTEM" is not able to access the database "pmbigdb" under the current security context.
```
Solution:  When mounting with the workflow, make sure the workflow has a valid user/password in the Advanced Setting that has the right to manage SQL DBs.


### Supporting Videos For Microsoft SQL

Please watch the following videos:

* https://youtu.be/f0lj6bRFxGQ
* https://youtu.be/sh1_vk-1QY8
* https://youtu.be/VqxYX1L-mWA


### DataVeil Native Functions

DataVeil has the option  to use a Native Library to accelerate masking.  To use this you need to run an installation process against the database being masked.   However given we do not want to bring masking software anywhere near a production system and inserting this function into the database being masked would require additional post-script activity, the solution is to do the following:

1. On the masking server create a dummy database called 'dummydb'.  This database does not need any data in it.
1. In your dataveil folder there is a file located in a location similar to:   d:\dataveil\native\sqlserver\install_01_assembly.sql
Edit this file and change the database name to 'dummydb' and the location of the relevant dll called DataVeilNativeCLR.dll
You will need to make a total of three edits.
1. Having edited the install_01_assembly.sql file, you need to load and run it using Microsoft SQL Server Manager
1. Presuming the first SQL file runs without error, then load and run the second SQL file called install_02_udf.sql
1. Presuming this also runs without error then we have loaded the native functions into a local DB which can be used for masking other DBs.
1. The final step is to edit your project to reference this DB during masking.  This is done by supplying the dummydb name in the relevant section of the project with .dbo at the end.   So in this example we used dummydb and it appears in the project as shown in the image below:

![DataVeil Native Function](https://github.com/Actifio/actifiodataveilmasking/blob/master/dv_sql_native.jpg)


Now when running masking, in the log file you should see a line like this:
```
Fri Aug 23 12:02:23 AEST 2019 INFO Found DataVeil native function library version 1.0.0 on dummydb.dbo
```

#### Upgrading MS SQL Native Functions

A new version of dataveil may bring a new version of native function, in which case the old native functions will no longer work. In this example Native Functions 1.0.0 is installed, but DataVeil is now expecting 1.0.1:
```
Tue Sep 03 09:00:13 AEST 2019 INFO DataVeil native function library is not available on dummydb.dbo. Expecting DataVeil Native Library version 1.0.1 or later. Found incompatible version 1.0.0
```
To upgrade the simplest procedure is to:
1.  Delete 'dummydb' 
1.  Reinstall Native Functions as per the instructions above.


## Oracle Masking with Actifio and DataVeil

This readme describes how to use the shell script in this respository along with the DataVeil software to perform data masking with Actifio.

### Requirements

One Oracle Source Database we can mask.  This is our Production Database.
We need three Oracle Servers, each with Oracle installed.  Match the versions between all servers.


* Production Server (Production Side – hosts the source DB)
* Masking Server (Production Side – masks the source DB)
* Development Server (Non-Production Side – uses the masked DB)

For PoC we could use just one server (we don’t need three).
But in production you would never mask and run non-prod on the production server.

For each stage of the process use a different database name.  For instance:

* Production Name:   prod
* Name when mounted to masking server:   CPROD
* Name when mounted to development server:   MPROD

The steps we follow will be:

1. Unzip DataVeil onto your masking server.   Set permission and test for correct JAVA.  Install JAVA if needed and setup an X11 server to access DataVeil.
1. License DataVeil and note where you put the license file.  Do not put it into the same folder a DataVeil as this will complicate upgrades.
1. Mount production database to masking server using the ‘middle’ name (i.e. mount ‘prod’ as ‘CPROD’)
1. Connect to the database and create Project using Actifio DataVeil and note the Project key name
1. Save Project and note where you save the project
1. Install shell script onto masking server and customize it


DataVeil needs to be unzip onto your masking server.  Unzip it and then create folders to hold your working files and logs.
After unziping the DataVeil zip file (which in this example we placed into the /opt folder), we need to run the three commands in the chmod_nix file:

```
# pwd
/opt/dataveil
# cat chmod_nix
chmod +x DataVeilLaunchNix
chmod +x bin/dataveil
chmod +x batch/dataveil_cmd_nix
# chmod +x DataVeilLaunchNix
# chmod +x bin/dataveil
# chmod +x batch/dataveil_cmd_nix
```

Now test for the correct JAVA.  In this example we clearly don't have it:

```
[root@oracle-mask-stg bin]# ./dataveil
cp: cannot stat `/root/.dataveil/dev/config/Preferences/com/dataveil/dataveil.properties': No such file or directory
which: no javac in (/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin)
Exception in thread "main" java.lang.UnsupportedClassVersionError: org/openide/filesystems/FileUtil : Unsupported major.minor version 52.0
```

We resolve this with:

```yum install java-1.8.0-openjdk```

We then test again but are till missing javac:

```
# cd /opt/dataveil/bin/
# ./dataveil
cp: cannot stat `/root/.dataveil/dev/config/Preferences/com/dataveil/dataveil.properties': No such file or directory
which: no javac in (/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin)
```
We resolve this with
```yum install java-1.8.0-openjdk-devel```

We now need an X11 client if we are going to use a Windows host to manage DataVeil.   XMing is a good choice.   Once you have it installed, SSH to the Linux server where DataVeil is installed with X11 forwarding enabled in PuTTY.  DataVeil should open on your Windows host, but running on the Linux host.   

```
# cd /opt
# cd dataveil
# cd bin
# ./dataveil
```
Some Oracle commands that might be helpful (display current schema, display users, set password for users):

```
SQL> select sys_context( 'userenv', 'current_schema' ) from dual;
SQL> select username from dba_users;
SQL> alter user scott identified by password;
```

Once we have created a project file we are now ready to create our script
The script file must be located in /act/scripts


There are six customizations needed in the sh file:

1. Change dataveil path to match yours
1. Change Project path and name to match yours.    Make sure the project files are not in the DataVeil folder as this will complicate upgrades.   In this example we use /opt/dataveilfiles
1. Change key defined in project to match yours
1. Change license path and name to match yours.   Make sure the license file is not in the DataVeil folder as this will complicate upgrades.   In this example we use /opt/dataveilfiles
1. Change log file path.  Make sure the log folder is not in the DataVeil folder as this will complicate upgrades.   In this example we use /opt/dataveillogs

If you change the .sh file name you need to change the workflow to point to the new name of the script
You must use the /act/scripts folder, no other folder can be used

Note that the string to start DataVeil can be in the sheel script in either of these formats:

With all commands in one line:
```
/opt/dataveil/bin/dataveil --nosplash --nogui -J-Dnetbeans.logger.console=true -J-Dorg.level=WARNING -J-Xms64m -J-Xmx512m --refreshschema=false --compilewarning=continue --createdirs=true --project="/opt/dataveilfiles/prodmask.dvp" --key="actifio" --log="/opt/dataveillogs/CPROD.log" --license="/opt/dataveilfiles/license.dvl"
```

Or each parameter on a separate line separated with a backslash.   While this makes it visually easier to edit, if there are any spaces to the right of a baskclash, the command will be split and errors will occur.   If using vi editor turn on visual spaces with:

```
:set list
```
Then confirm there are no spaces after each backlash.

```
/opt/dataveil/bin/dataveil --nosplash --nogui -J-Dnetbeans.logger.console=true -J-Dorg.level=WARNING -J-Xms64m -J-Xmx512m --refreshschema=false --compilewarning=continue --createdirs=true \
--project="/opt/dataveilfiles/prodmask.dvp" \
--key="actifio" \
--log="/opt/dataveillogs/CPROD.log" \
--license="/opt/dataveilfiles/license.dvl"
```

### Test your shell script

Presuming we have created the project file and placed the script file in the correct spot.
Presuming the relevant database is still mounted and ready. 
Run the shell script file with the word ‘test’ as shown in the example:

~~~
/act/scripts/dvmask.sh test
~~~

Now check the DataVeil log file defined in your bat file to ensure good masking has occurred.  You should actually see the result in your shell window anyway, but it is good to evaluate the logs were created.

This is an example of succesful masking execution:

```
Fri Aug 16 13:17:58 AEST 2019 INFO DataVeil started in batch mode.
Fri Aug 16 13:17:58 AEST 2019 INFO Using param --project=/opt/dataveil/userfiles/prodmask.dvp
Fri Aug 16 13:17:58 AEST 2019 INFO Using param --con={sid=CPROD,host=10.65.5.125,port=1521,user=scott,password=XXXXXX}
Fri Aug 16 13:17:58 AEST 2019 INFO Using param --key=<specified>
Fri Aug 16 13:17:58 AEST 2019 INFO Using param --refreshschema=false
Fri Aug 16 13:17:58 AEST 2019 INFO Using param --compilewarning=continue
Fri Aug 16 13:17:58 AEST 2019 INFO Using param --createdirs=true
Fri Aug 16 13:17:58 AEST 2019 INFO Using param --log=/opt/dataveil/log/CPROD.log
Fri Aug 16 13:17:58 AEST 2019 INFO Using param --reportdir=/opt/dataveil/DataVeil User Data/Masking/Results/Masking Current
Fri Aug 16 13:17:58 AEST 2019 INFO Using param --reportkeep=20
Fri Aug 16 13:17:58 AEST 2019 INFO Using param --license=/opt/dataveil/userfiles/license.dvl
Fri Aug 16 13:17:59 AEST 2019 INFO Loading project file /opt/dataveil/userfiles/prodmask.dvp
Fri Aug 16 13:18:00 AEST 2019 INFO Checking schema on "SCOTT (10.65.5.125:1521:CPROD)" for changes that could affect masking definitions...
Fri Aug 16 13:18:01 AEST 2019 INFO Compile completed successfully.
Fri Aug 16 13:18:01 AEST 2019 INFO DataVeil version 4.0.2
Fri Aug 16 13:18:01 AEST 2019 INFO Schema SCOTT (10.65.5.125:1521:CPROD) is on Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
Fri Aug 16 13:18:01 AEST 2019 INFO DataVeil native function library is not available on "SCOTT".
Fri Aug 16 13:18:01 AEST 2019 INFO Project prodmask: Schema SCOTT has defined 2 sensitive columns containing a combined total of 28 values
Fri Aug 16 13:18:01 AEST 2019 INFO Preparing Person Family Name data..
Fri Aug 16 13:18:01 AEST 2019 INFO Preparing Date data..
Fri Aug 16 13:18:06 AEST 2019 INFO Started column masking for "SCOTT"."EMP"."HIREDATE" (0 null); containing 14 rows...
Fri Aug 16 13:18:06 AEST 2019 INFO Started column masking for "SCOTT"."EMP"."ENAME" (0 null); containing 14 rows...
Fri Aug 16 13:18:06 AEST 2019 INFO ...completed RandomizeDateTime SQL mask for column "SCOTT"."EMP"."HIREDATE"; 14 of 14 rows processed in 0 seconds
Fri Aug 16 13:18:06 AEST 2019 INFO .completed column masking for "SCOTT"."EMP"."HIREDATE" (0 null); 14 of 14 rows processed in 0 seconds
Fri Aug 16 13:18:06 AEST 2019 INFO ...completed PersonLastName SQL mask for column "SCOTT"."EMP"."ENAME"; 14 of 14 rows processed in 0 seconds
Fri Aug 16 13:18:06 AEST 2019 INFO .completed column masking for "SCOTT"."EMP"."ENAME" (0 null); 14 of 14 rows processed in 0 seconds
Fri Aug 16 13:18:06 AEST 2019 INFO Started writing table "SCOTT"."EMP" using Update table IO mode, 14 rows...
Fri Aug 16 13:18:06 AEST 2019 INFO .completed writing masked values to table "SCOTT"."EMP" (as update of original table, 14 rows in 0 seconds)
Fri Aug 16 13:18:07 AEST 2019 INFO Project summary: Sensitive values with configured masks = 28. Sensitive values masked = 28.
Fri Aug 16 13:18:07 AEST 2019 INFO Masking Run of project "prodmask" completed on August 16, 2019 1:18:07 PM AEST, elapsed time = 6 seconds. No errors or warnings.
Fri Aug 16 13:18:07 AEST 2019 INFO DataVeil terminating with exit code = 0
```


### Supporting Videos For Oracle

Please watch the following videos:

* https://youtu.be/VNzXm4PR1V0
* https://youtu.be/rbhKSlT8C90
* https://youtu.be/8_jyF1EKO-M
* https://youtu.be/MIGDfGtPA88

### DataVeil Native Functions

DataVeil has the option  to use a Native Library to accelerate masking.  To use this you need to run an installation process against the database being masked.   This comes in two parts.   Firstly you need to add /act/scripts/loadnativefunctions.sql
using the file found here in Github.   There are two things to customize:

1. In the first line the DVNative.jar file path may need to be updated
1. In the second line, the schema name needs to match the one being used by the DataVeil profile
```
exec dbms_java.loadjava('-verbose -synonym -grant PUBLIC /opt/dataveil/native/oracle/DVNative.jar');
ALTER SESSION SET CURRENT_SCHEMA = scott;
@setup_functions.sql
exit;
```

Once you have set this file up,  there is a hashed line in dvmask.sh that needs to be unhashed and edited:

1.  It uses su - oracle.   Normally the oracle user is used for mounts, but this might not be the case
1.  It switches to /opt/dataveil/native/oracle but your DataVeil install location may be different
1.  It uses an SID of CPROD.   Yours will be different
1.  It calls /act/scripts/loadnativefunctions.sql   Clearly if you used a different name and location these need to be set correctly.

```
su - oracle -c 'cd /opt/dataveil/native/oracle;export ORACLE_SID=CPROD;sqlplus / as sysdba @/act/scripts/loadnativefunctions.sql;exit'
```

You can validate it worked by examining the DataVeil logs and looking for a line like this (where scott is the schema name, yours may be different):
```
Fri Aug 23 15:30:15 AEST 2019 INFO Found DataVeil native function library version 1.0.0 on "SCOTT"
```

#### Handling Upgrades
If upgrading DataVeil, do not forget to run the chmodnix commands again.   You will not need to do anything to upgrade the Native Library, this should work without modification.

# Trouble Shooting

### When starting DataVeil on Linux you get a no javac message

You may see this error:

```
[root@sydoradv2 dataveil]# ./DataVeilLaunchNix
which: no javac in (/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin)
```
This actually doesn't appear to block anything from working.   To prevent this message from appearing, you can install the following package:
```
sudo yum install java-1.8.0-openjdk-devel
```

### While manually masking missing XSLT messages appear

You may see this error:

```
Wed Aug 21 11:01:23 AEST 2019 INFO FATAL ERROR:  '/act/xslt/masking_result_xhtml.xslt (No such file or directory)'
Wed Aug 21 11:01:23 AEST 2019 INFO            :/act/xslt/masking_result_xhtml.xslt (No such file or directory)
```
This doesn't block successful masking.  However report generation may not have occurred.
To prevent this error, you can copy two files to the relevant location.  Presuming you unzipped dataveil into /opt/dataveil then:

```
mkdir /act/xslt
cp /opt/dataveil/xslt/masking_result_xhtml.xslt /act/xslt/.
cp /opt/dataveil/xslt/reports.css /act/xslt/.
```

