::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off

:: Parameter to modify
set IRIS_DIR="C:\InterSystems\IRIS"
set /p IRIS_DIR= "Please enter the path of the Intersystems IRIS directory [C:\InterSystems\IRIS] : "

set USERNAME="_SYSTEM"
set /p USERNAME= "Please enter your Intersystems IRIS username [_SYSTEM] : "

set /p PASSWORD= "Please enter your Intersystems IRIS password : "

set JAVA_HOME=C:\Progra~1\Java\jdk1.8.0_211
set /p JAVA_HOME= "Please enter the path of the Java Home [C:\Progra~1\Java\jdk1.8.0_211] : "

:: Pre-configured variables
set BUILD_DIR=install\App
set NAMESPACE=USER

set XML_EXPORT_DIR=docs
set INSTALL_PACKAGE_NAME=App

set NAMESPACE_TO_CREATE=DEMO
set SOURCE_DIR=RestToDll\src

:: Build and import application to IRIS
copy Allergie\Allergie.dll %IRIS_DIR%\mgr\
copy java\imcBO.jar %IRIS_DIR%\mgr\

echo Importing project...
(

echo zn "%NAMESPACE%" set st = $system.Status.GetErrorText($system.OBJ.ImportDir("%~dp0%BUILD_DIR%",,"ck",,1^^^)^^^) w "IMPORT STATUS: "_$case(st="",1:"OK",:st^^^), ! 
echo set pVars("NAMESPACE"^^^) = "%NAMESPACE_TO_CREATE%"
echo set pVars("JAVAHOME"^^^) = "%JAVA_HOME%"
echo set pVars("SourceDir"^^^) = "%~dp0%SOURCE_DIR%"
echo do ##class(App.Installer^^^).setup(.pVars^^^)
echo halt
) | "%IRIS_DIR%\bin\irisdb.exe" -s "%IRIS_DIR%\mgr" -U %NAMESPACE%

echo:
echo ... Done
timeout 2 >nul

REM #### CODE INUTILISE ###
REM echo zn "%SYS"
REM echo do ##class(Security.System^^^).Get(,.p^^^)
REM echo set p("AutheEnabled"^^^)=p("AutheEnable"^^^)+16
REM echo do ##class(Security.System^^^).Modify(,.p^^^)
REM #### FIN CODE INUTILE ###