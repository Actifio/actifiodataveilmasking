# actifiodataveilmasking


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
