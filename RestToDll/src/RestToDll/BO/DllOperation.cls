Class RestToDll.BO.DllOperation Extends Ens.BusinessOperation
{

Property DllPath As %String(MAXLEN = "");

Property OG As %Net.Remote.ObjectGateway;

Property GW As %Net.Remote.Gateway;

Property proxyGateway As %Net.Remote.Object;

Parameter SETTINGS = "DllPath";

Method OnInit() As %Status
{
    $$$ThrowOnError(..CreateGateWay())
    $$$ThrowOnError(..StartGateWay())
    $$$ThrowOnError(..ConnectGetWay())
    $$$ThrowOnError(..SetProxy())
    Quit $$$OK
}

Method CreateGateWay() As %Status
{
    //jhk
    If '##class(%Net.Remote.ObjectGateway).GatewayExists("NetGate")
    {

        set ..OG =  ##class(%Net.Remote.ObjectGateway).%New()

        // Properties used in all server definitions
        set ..OG.Type = "2"   // Defines a .NET server
        set ..OG.Name  = "NetGate"
        set ..OG.Server  = "127.0.0.1"
        set ..OG.Port  = "55602" // port number must be unique

        // .NET-only properties
        set ..OG.AllowedIPAddresses = "127.0.0.1"
        // keep Exec64 default value
        set ..OG.DotNetVersion = "4.5"

        $$$ThrowOnError(..OG.%Save())
    }
    
    Quit $$$OK
}

Method StartGateWay() As %Status
{
        // Get a ObjectGateway instance that defines the NetGate server
        $$$ThrowOnError(##class(%Net.Remote.Service).OpenGateway("NetGate",.tOG))

        if ('##class(%Net.Remote.Service).IsGatewayRunning(tOG.Server,tOG.Port,,.status)) {
            // Instantiate the server on the host machine
            $$$ThrowOnError(##class(%Net.Remote.Service).StartGateway(tOG.Name))
        }

        set ..OG = tOG

        Quit $$$OK
}

Method ConnectGetWay() As %Status
{
        // define the location of the file containing the Fruit class
        set tPaths = ##class(%ListOfDataTypes).%New()
        do tPaths.Insert(..DllPath)

        // Connect a Gateway instance to server NetGate on the host machine
        set tGW = ##class(%Net.Remote.Gateway).%New()
        $$$ThrowOnError(tGW.%Connect(..OG.Server, ..OG.Port, "USER",,tPaths))
        set ..GW = tGW

        Quit $$$OK
}

Method SetProxy() As %Status
{
    if '$ISOBJECT(..proxyGateway)
    {
        // Use GW connection to create a proxy for the Fruit class
        set ..proxyGateway = ##class(%Net.Remote.Object).%New(..GW,"Allergie.Allergie")
    }

    Quit $$$OK
}

Method OnGetReaction(pRequest As RestToDll.Msg.ReactionRequest, Output pResponse As RestToDll.Msg.AlimentResponse) As %Status
{
        set tStatus = $$$OK
        
        try{
    
            $$$ThrowOnError(..GetAllergie(pRequest.Name,"Reaction",.pResponse))
                        
        }
        catch exp
        {
            Set tStatus = exp.AsStatus()
            
        }
        
        Quit tStatus
}

Method OnAddReaction(pRequest As RestToDll.Msg.AddReactionRequest, Output pResponse As RestToDll.Msg.AlimentResponse) As %Status
{
            set tStatus = $$$OK
            
            try{
        
                $$$ThrowOnError(..AddAllergie(pRequest.Name,"Reaction",.pResponse))
                            
            }
            catch exp
            {
                Set tStatus = exp.AsStatus()
                
            }
            
            Quit tStatus
}

Method OnAddAliment(pRequest As RestToDll.Msg.AddAlimentRequest, Output pResponse As RestToDll.Msg.AlimentResponse) As %Status
{
            set tStatus = $$$OK
            
            try{
        
                $$$ThrowOnError(..AddAllergie(pRequest.Name,"Aliment",.pResponse))
                            
            }
            catch exp
            {
                Set tStatus = exp.AsStatus()
                
            }
            
            Quit tStatus
}

Method OnGetAliment(pRequest As RestToDll.Msg.AlimentRequest, Output pResponse As RestToDll.Msg.AlimentResponse) As %Status
{
            set tStatus = $$$OK
        
            try{
        
                $$$ThrowOnError(..GetAllergie(pRequest.Name,"Aliment",.pResponse))
                            
            }
            catch exp
            {
                Set tStatus = exp.AsStatus()
                
            }
            
            Quit tStatus
}

Method GetAllergie(pName As %String, tType As %String, Output pResponse As RestToDll.Msg.AlimentResponse) As %Status
{
                set tStatus = $$$OK
                
                Set pResponse = ##class(RestToDll.Msg.AlimentResponse).%New()

        
                Set pResponse.Results = ##class(%ListOfDataTypes).%New()
            
                try{

            
                    if tType = "Aliment"
                    {
                        set tReturn = ..proxyGateway.getReactions(pName)
                    }   
                    else
                    {
                        set tReturn = ..proxyGateway.getAliments(pName)
                    } 
        
                    For x=0:1:tReturn.Count-1 {
                        do pResponse.Results.Insert(tReturn.%get(x))
                    }
                                
                }
                catch exp
                {
                    Set tStatus = exp.AsStatus()
                    
                }
                
                Quit tStatus
}

Method AddAllergie(pName As %String, tType As %String, Output pResponse As RestToDll.Msg.AlimentResponse) As %Status
{
        set tStatus = $$$OK
        
        Set pResponse = ##class(Ens.Response).%New()
    
        try{
    
            if tType '= "Aliment"
            {
                do ..proxyGateway.addReaction(pName)
            }   
            else
            {
                do ..proxyGateway.addAliment(pName)
            } 
                        
        }
        catch exp
        {
            Set tStatus = exp.AsStatus()
            
        }
        
        Quit tStatus
}

Method OnTearDown() As %Status
{
	
	    do ..GW.%Disconnect()
        do ##class(%Net.Remote.Service).StopGatewayObject(..OG)
        
        Quit $$$OK
}

XData MessageMap
{
<MapItems>
        <MapItem MessageType="RestToDll.Msg.ReactionRequest"> 
            <Method>OnGetReaction</Method>
        </MapItem>
       
        <MapItem MessageType="RestToDll.Msg.AlimentRequest"> 
            <Method>OnGetAliment</Method>
        </MapItem>

        <MapItem MessageType="RestToDll.Msg.AddReactionRequest"> 
            <Method>OnAddReaction</Method>
        </MapItem>
       
        <MapItem MessageType="RestToDll.Msg.AddAlimentRequest"> 
            <Method>OnAddAliment</Method>
        </MapItem>
    </MapItems>
}

}
