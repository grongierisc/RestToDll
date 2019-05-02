# RestToDll
Proof of Concept of an .Net Gateway on IRIS

## Prerequisite
- IRIS 2019.1
- .NET 4.5

## Install
Allow the Operating System Authentification in :  
System Administration -> Security -> System Security -> Authentication/Web Session Options  
Check the _Allow Operating System authentication_ checkbox.  

Open the install.bat file in a text editor  
Change the **IRIS_DIR** value to the path of the directory where Intersystems IRIS is installed.  
Change the **USERNAME** and **PASSWORD** values to the IRIS credentials.  

Then double-click on the install.bat file to launch the installation.  

When the installation is complete, start the production if it is not already running.  

## Usage
The api is on :  
localhost:<IRIS Web Server Port>/api/allergies

## Uninstall
Open the install.bat file in a text editor  
Change the **IRIS_DIR** value to the path of the directory where Intersystems IRIS is installed.  
Change the **USERNAME** and **PASSWORD** values to the IRIS credentials.  

Double-click on the remove.bat file to remove the demo in your IRIS instance.  