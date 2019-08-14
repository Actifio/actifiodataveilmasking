echo on

@rem this section ensures data masking is run at the correct time during the mount.   Manual run is done using the parameter: test
if "%ACT_MULTI_OPNAME%" == "scrub-mount" if "%ACT_MULTI_END%" == "true" if "%ACT_PHASE%" == "post" ( GOTO maskcommand )
if "%ACT_MULTI_OPNAME%" == "mount" if "%ACT_MULTI_END%" == "true" if "%ACT_PHASE%" == "post" ( GOTO maskcommand )
if "%1" == "test" ( GOTO maskcommand )
exit /B 0

:maskcommand
@ECHO

@rem   you need to change four parameters, project, key, license and log
@rem   do not change or remove any of the ^ characters, make sure the format remains exactly the same
@rem   project should be the location of the project file.  Do not put the file in any c:\program files   folders 
@rem   key is the key defined when you created the project.    Do not put the file in any c:\program files   folders
@rem   license is the data masking license.  Do not put the file in any c:\program files   folders
@rem   log is the location of the data masking software logs.  Do not put the file in any c:\program files   folders

@rem   finally you may also need to change location of dataveil64.exe to match where you unpacked it

START "MaskWindow" /WAIT "D:\\DataVeil\\bin\\dataveil64.exe" ^
--nosplash --nogui -J-Dnetbeans.logger.console=true -J-Dorg.level=WARNING -J-Xms64m -J-Xmx512m --compilewarning=continue --createdirs=true ^
--project="D:\\DV_Files\\FinMask_av.dvp" ^
--key="actifio" ^
--license="D:\\DV_Files\\license.dvl" ^
--log="D:\\logs\\dvlog.txt!"

@rem 
IF %ERRORLEVEL% EQU 0 (GOTO cleanexit)
exit /B 1

:cleanexit
exit /B 0
