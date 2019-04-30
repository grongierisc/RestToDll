Class RestToDll.BS.RestToDll Extends Ens.BusinessService
{

Parameter TARGET;

Method OnProcessInput(pInput As RestToDll.Msg.RestGetRequest, Output pOutput As RestToDll.Msg.ResultResponse) As %Status
{
	set status = $$$OK
	try {
		$$$ThrowOnError(..SendRequestSync(..#TARGET, pRequest, .pOutput))
	} catch ex {
		set status = ex.AsStatus()
	}
	
	Quit status
}

}
