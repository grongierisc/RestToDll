::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off

:: Parameter to modify (the directory where Intersystems IRIS is installed)
set IRIS_DIR=C:\Intersystems\IRIS

set USERNAME=superuser
set PASSWORD=SYS

:: Pre-configured variables
set BUILD_DIR=install\App
set NAMESPACE=USER

set XML_EXPORT_DIR=docs
set INSTALL_PACKAGE_NAME=App

set NAMESPACE_TO_CREATE=DEMO
set SOURCE_DIR=RestToDll\src

:: Build and import application to IRIS
copy Allergie\Allergie.dll %IRIS_DIR%\mgr\

echo Importing project...
(
echo zn "%NAMESPACE%" set st = $system.Status.GetErrorText($system.OBJ.ImportDir("%~dp0%BUILD_DIR%",,"ck",,1^^^)^^^) w "IMPORT STATUS: "_$case(st="",1:"OK",:st^^^), ! 
echo set pVars("NAMESPACE"^^^) = "%NAMESPACE_TO_CREATE%"
echo set pVars("SourceDir"^^^) = "%~dp0%SOURCE_DIR%"
echo do ##class(App.Installer^^^).setup(.pVars^^^)
echo halt
) | "%IRIS_DIR%\bin\irisdb.exe" -s "%IRIS_DIR%\mgr" -U %NAMESPACE%

