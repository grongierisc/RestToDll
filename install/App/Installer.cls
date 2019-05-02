Include %occInclude

Class App.Installer
{

ClassMethod CreateRESTApp() As %Status
{
    zn "USER"
    write "Create web application ...",!
    set webName = "/api/allergies"
    set webProperties("NameSpace") = "DEMO"
    set webProperties("Enabled") = $$$YES
    set webProperties("IsNameSpaceDefault") = $$$NO
    set webProperties("CSPZENEnabled") = $$$YES
    set status = ##class(Security.Applications).Create(webName, .webProperties)
    write:'status $system.Status.DisplayError(status)
    write "Web application "_webName_" was created!",!
    zn "USER"
    quit $$$OK
}

ClassMethod CSPAppConfigureAsREST(pCSPAppName) As %Status
{
    Set tSC = $System.Status.OK()
    Try
    {
        zn "%SYS"
        Set oCSPApp = ##class(Security.Applications).%OpenId(pCSPAppName, , .tSC)
        Set oCSPApp.DispatchClass = "RestToDll.WS.AllergiesREST"
        Set oCSPApp.UseCookies = 1
        Set tSC = oCSPApp.%Save()
        Quit:$System.Status.IsError(tSC)
    }
    Catch (oException)
    {
        Set tSC = oException.AsStatus()
    }
    Quit tSC
}

ClassMethod ConfigureAutoStart(pNamespace As %String) As %Status
{
    Set tSC = $$$OK
    Try 
    {
        ZN pNamespace
        Set tSC = $CLASSMETHOD("Ens.Director", "SetAutoStart", "RestToDll.Production", 0)
    } 
    Catch (oException) 
    {
        Set tSC = oException.AsStatus()
    }
    Quit tSC
}

XData Install [ XMLNamespace = INSTALLER ]
{
<Manifest>

    <Role Name="AppRole" Description="Role to access and use the App" Resources="%DB_IRISSYS:RW,%Admin_Secure:U,%DB_%DEFAULT:RW,%DB_IRISLIB:RW" />

    <If Condition='$L("${NAMESPACE}")=0'>
        <Error Status="$$$NamespaceDoesNotExist">
            <Arg Value="${NAMESPACE}"/>
        </Error>
    </If>

    <If Condition='(##class(Config.Namespaces).Exists("${NAMESPACE}")=0)'>
        <Log Text="Configuring namespace ${NAMESPACE} ..." Level="0"/>
        <Namespace Name="${NAMESPACE}" Create="yes" Code="${NAMESPACE}" Ensemble="1" Data="${NAMESPACE}">
            <Configuration>
                <Database Name="${NAMESPACE}" Dir="${MGRDIR}${NAMESPACE}" Create="yes"/>
            </Configuration>
        </Namespace>
    </If>

    <Namespace Name="${NAMESPACE}" Create="no">
        <Log Text="Configuring CSP applications for ${NAMESPACE} ..." Level="0"/>
        <CSPApplication Url="/api/allergies" Directory="${CSPDIR}allergies" AuthenticationMethods="64" IsNamespaceDefault="false" Grant="AppRole" Recurse="true" CookiePath="${CSPDIR}/allergies" DispatchClass="RestToDll.WS.AllergiesREST"/> 
        <!--<Invoke Class="App.Installer" Method="CreateRESTApp" CheckStatus="true">
        </Invoke>-->

        <IfDef Var="SourceDir">
            <Log Text="SourceDir defined, offline install from ${SourceDir} ..." Level="0"/>
            <Import File="${SourceDir}" Flags="cukb" Recurse="true"/>
        </IfDef>
    </Namespace>

    <Namespace Name="USER" Create="no">
        <Log Text="Applying additional configurations to the new REST CSP applications ..." Level="0"/>
        <Invoke Class="App.Installer" Method="CSPAppConfigureAsREST" CheckStatus="true">
            <Arg name="pCSPAppName" Value="/api/allergies"/>
        </Invoke>
    </Namespace>

    <Namespace Name="USER" Create="no">
        <Log Text="Configuring production to auto-start ..." Level="0"/>
        <Invoke Class="App.Installer" Method="ConfigureAutoStart" CheckStatus="true">
            <Arg name="pNamespace" Value="${NAMESPACE}"/>
        </Invoke>
    </Namespace>

</Manifest>
}

ClassMethod setup(ByRef pVars, pLogLevel As %Integer = 0, pInstaller As %Installer.Installer) As %Status [ CodeMode = objectgenerator, Internal ]
{
     Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "Install")
}

}
