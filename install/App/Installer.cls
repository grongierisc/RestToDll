Include %occInclude

Class App.Installer
{

ClassMethod CSPAppConfigureAsREST(pCSPAppName) As %Status
{
    Set tSC = $System.Status.OK()
    Try
    {
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

XData Install [ XMLNamespace = INSTALLER ]
{
<Manifest>

    <Role Name="AppRole" Description="Role to access and use the App" Resources="%DB_IRISSYS:RW,%Admin_Secure:U,%DB_%DEFAULT:RW,%DB_IRISLIB:RW" />

    <If Condition='(##class(Config.Namespaces).Exists("${NAMESPACE}")=0)'>
        <Log Text="Configuring namespace ${NAMESPACE} ..." Level="0"/>
        <Namespace Name="${NAMESPACE}" Create="yes" Code="${NAMESPACE}" Ensemble="1" Data="${NAMESPACE}">
            <Configuration>
                <Database Name="${NAMESPACE}" Dir="${MGRDIR}/${NAMESPACE}" Create="yes"/>
            </Configuration>
        </Namespace>

        <Log Text="Configuring CSP applications for ${NAMESPACE} ..." Level="0"/>
        <CSPApplication Url="/api/allergies" Directory="${CSPDIR}allergies" AuthenticationMethods="64" IsNamespaceDefault="true" Grant="AppRole"/>

        <Log Text="Applying additional configurations to the new REST CSP applications ..." Level="0"/>
        <Invoke Class="App.Installer" Method="CSPAppConfigureAsREST" CheckStatus="true">
            <Arg name="pCSPAppName" Value="/api/allergies"/>
        </Invoke>

        
        
    </If>

</Manifest>
}

ClassMethod setup(ByRef pVars, pLogLevel As %Integer = 0, pInstaller As %Installer.Installer) As %Status [ CodeMode = objectgenerator, Internal ]
{
	
     Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "Install")
}

}
