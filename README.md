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


### Supporting Videos For Microsoft SQL

Please watch the following videos:

* https://youtu.be/f0lj6bRFxGQ
* https://youtu.be/sh1_vk-1QY8
* https://youtu.be/VqxYX1L-mWA



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

DataVeil needs to be unzip onto your masking server.  Unzip it and then create folders to hold your working files and logs.

The steps we follow will be:

1. Unzip DataVeil onto your masking server (you also need JRE 1.8)
1. License DataVeil and note where you put the license file
1. Mount production database to masking server using the ‘middle’ name (i.e. mount ‘prod’ as ‘CPROD’)
1. Connect to the database and create Project using Actifio DataVeil and note the Project key name
1. Save Project and note where you save the project
1. Install shell script onto masking server and customize it

The script file must be located in /act/scripts


There are six customizations needed in the bat file:

1. Change dataveil path to match yours
1. Change Project path and name to match yours
1. Change key defined in project to match yours
1. Change license path and name to match yours
1. Change log file path

If you change the .sh file name you need to change the workflow to point to the new name of the script
You must use the /act/scripts folder, no other folder can be used

Note that the string to start DataVeil can be in the sheel script in either of these formats:

With all commands in one line:
```
/opt/dataveil/bin/dataveil --nosplash --nogui -J-Dnetbeans.logger.console=true -J-Dorg.level=WARNING -J-Xms64m -J-Xmx512m --refreshschema=false --compilewarning=continue --createdirs=true --project="/opt/dataveil/userfiles/prodmask.dvp" --key="actifio" --log="/opt/dataveil/log/CPROD.log" --license="/opt/dataveil/userfiles/license.dvl"
```

Or each parameter on a separate line separated with a backslash.   While this makes it visually eaiser to edit, if there are any spaces to the right of a baskclash, the command will be split and errors will occur.   If using vi editor turn on visual spaces with:

```
:set list
```
Then confirm there are no spaces after each backlash.

```
/opt/dataveil/bin/dataveil --nosplash --nogui -J-Dnetbeans.logger.console=true -J-Dorg.level=WARNING -J-Xms64m -J-Xmx512m --refreshschema=false --compilewarning=continue --createdirs=true \
--project="/opt/dataveil/userfiles/prodmask.dvp" \
--key="actifio" \
--log="/opt/dataveil/log/CPROD.log" \
--license="/opt/dataveil/userfiles/license.dvl"
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
