# Microsoft SQL Masking with Actifio and DataVeil

This readme describes hwo to use the bat file in this respository along with the DataVeil software to perform data masking with Actifio.

## Requirements

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
DO NOT put any other files called by the Batch file into C:\Program Files

## Test your bat file

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


## Supporting Videos

Please watch the following videos:

https://youtu.be/f0lj6bRFxGQ
https://youtu.be/sh1_vk-1QY8
