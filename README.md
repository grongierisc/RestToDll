# RestToDll
Proof of Concept of an .Net Gateway on IRIS

## Prerequisite
- IRIS 2019.1
- .NET 4.5

## Install
Disable the configuration security in :  
System Administration -> Security -> System Security -> System-wide Security Parameters  
Uncheck the _Enable configuration security_ checkbox  

Open the install.bat file in a text editor  
Change the **IRIS_DIR** value to the path of the directory where Intersystems IRIS is installed.  
Change the **USERNAME** and **PASSWORD** values to the IRIS credentials.  

Then double-click on the install.bat file to launch the installation.

When the installation is complete, start the production if it is not already running.

## Usage
The api is on :  
localhost:<IRIS Web Server Port>/api/allergies

## Uninstall
In progress ...