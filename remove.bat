::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off

:: Parameter to modify (the directory where Intersystems IRIS is installed)
set IRIS_DIR=C:\Intersystems\IRIS

set USERNAME=superuser
set PASSWORD=SYS

:: Pre-configured variables
set NAMESPACE_TO_REMOVE=DEMO
set REST_API=/api/allergies

:: Removing application from IRIS
echo Removing project...
(
echo %USERNAME%
echo %PASSWORD%

echo set NsExist = ##class(Config.Namespaces^^^).Exists("%NAMESPACE_TO_REMOVE%"^^^)
echo do:NsExist ##class(Config.Namespaces^^^).Delete("%NAMESPACE_TO_REMOVE%"^^^)
echo do:NsExist ##class(%%Library.EnsembleMgr^^^).DisableNamespace("%NAMESPACE_TO_REMOVE%"^^^) 

echo set CspExist = ##class(Security.Applications^^^).Exists("/csp/%NAMESPACE_TO_REMOVE%"^^^)
echo do:CspExist ##class(Security.Applications^^^).Delete("/csp/%NAMESPACE_TO_REMOVE%"^^^)

echo set DbExist = ##class(Config.Databases^^^).Exists("%NAMESPACE_TO_REMOVE%"^^^)
echo set Directory = ##class(Config.Databases^^^).GetDirectory("%NAMESPACE_TO_REMOVE%"^^^)
echo do:DbExist ##class(Config.Databases^^^).Delete("%NAMESPACE_TO_REMOVE%"^^^)
echo do ##class(SYS.Database^^^).DeleteDatabase(Directory^^^)

echo set CspExist = ##class(Security.Applications^^^).Exists("%REST_API%"^^^)
echo do:CspExist ##class(Security.Applications^^^).Delete("%REST_API%"^^^)

echo halt
) | "%IRIS_DIR%\bin\irisdb.exe" -s "%IRIS_DIR%\mgr" -U "%%SYS"

