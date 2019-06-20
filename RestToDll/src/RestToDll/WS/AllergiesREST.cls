Class RestToDll.WS.AllergiesREST Extends %CSP.REST
{

Parameter BsName = "WS_REST";

Parameter CHARSET = "utf-8";

/// This parameter controls the CSP session support. By default the CSP session will be
/// ended after each request in accordance with the spirit of REST. However this CAN be
/// overridden by the user. To use a session, it's necessary to manage the CSPSESSION cookie.
/// Browsers do this automatically but command line tools such as CURL require the setting of
/// options.
Parameter UseSession As %Integer = 1;

Parameter HandleCorsRequest As %Integer = 1;

/// 
/// The UrlMap determines how a Url should map to a HTTP Method and a Target ClassMethod
/// indicated by the 'Call' attribute. 
/// In this Route Entry GET requests to /class/namespace/classname will call the GetClass method
/// 
/// <Route Url="/class/:namespace/:classname" Method="GET" Call="GetClass"/>
XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/patients/:id" Method="GET" Cors="true" Call="GetInformations"/>
</Routes>
}

/* <Route Url="/reactions/:name" Method="GET" Cors="true" Call="GetFromAllergie"/>
<Route Url="/reactions" Method="POST" Cors="true" Call="AddAllergies"/>
<Route Url="/aliments/:name" Method="GET" Cors="true" Call="GetFromAliment"/>
<Route Url="/aliments" Method="POST" Cors="true" Call="AddAliments"/> */
ClassMethod GetFromAllergie(pName As %String) As %Status
{
	set status = $$$OK
	try {

		$$$ThrowOnError(##class(Ens.Director).CreateBusinessService(..#BsName,.tService))
		
		set tRequest = ##class(RestToDll.Msg.RestGetRequest).%New()
		set tRequest.Type = "allergie"
		set tRequest.Name = pName
		
		$$$ThrowOnError(tService.ProcessInput(tRequest,.output))	
	
		$$$ThrowOnError(##CLASS(%ZEN.Auxiliary.jsonProvider).%ObjectToJSON(output,,,"iuweloa"))

	} catch(ex) {
		set status = ex.AsStatus()
	}
	return status
}

ClassMethod GetFromAliment(pName As %String) As %Status
{
	set status = $$$OK
	try {

		$$$ThrowOnError(##class(Ens.Director).CreateBusinessService(..#BsName,.tService))
		
		set tRequest = ##class(RestToDll.Msg.RestGetRequest).%New()
		set tRequest.Type = "aliment"
		set tRequest.Name = pName
		
		$$$ThrowOnError(tService.ProcessInput(tRequest,.output))
	
		$$$ThrowOnError(##CLASS(%ZEN.Auxiliary.jsonProvider).%ObjectToJSON(output,,,"iuweloa"))

	} catch(ex) {
		set status = ex.AsStatus()
	}
	return status
}

ClassMethod GetInformations(pId As %String) As %Status
{
	set status = $$$OK
	try {

		$$$ThrowOnError(##class(Ens.Director).CreateBusinessService(..#BsName,.tService))
		
		set tRequest = ##class(RestToDll.Msg.RestGetRequest).%New()
		set tRequest.Id = pId
		
		$$$ThrowOnError(tService.ProcessInput(tRequest,.output))
	
		$$$ThrowOnError(##CLASS(%ZEN.Auxiliary.jsonProvider).%ObjectToJSON(output,,,"iuweloa"))

	} catch(ex) {
		set status = ex.AsStatus()
	}
	return status
}

/// This method Gets called prior to dispatch of the request. Put any common code here
/// that you want to be executed for EVERY request. If pContinue is set to 0, the
/// request will NOT be dispatched according to the UrlMap. If this case it's the
/// responsibility of the user to return a response.
ClassMethod OnPreDispatch(pUrl As %String, pMethod As %String, ByRef pContinue As %Boolean) As %Status
{
	set status = $$$OK
	
	try {
		#; MUST unlock the session
        Do %session.Unlock()
        If ('..AcceptsContentType("application/json")) {
	        	set pContinue = 0
            } else {
             	#; We always return json
             	Set %response.ContentType="application/json"
             	set pContinue = 1
            }
	} catch(ex) {
		set status = ex.AsStatus()
	}
    Quit status
}

/// Sets the response's localization domain (something that %CSP.REST should do, in theory) and then invokes default super class behavior
ClassMethod Page(skipheader As %Boolean = 1) As %Status [ ProcedureBlock = 0 ]
{
    #dim %response As %CSP.Response
    Set %response.Domain = ..#DOMAIN
    Quit ##super(skipheader)
}

}
