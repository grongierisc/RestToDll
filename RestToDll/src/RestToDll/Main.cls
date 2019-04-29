Class RestToDll.Main
{

ClassMethod Test(gatewayName As %String = "") As %Status
{
        Set tSc = $$$OK

        try {

            /*set OG =  ##class(%Net.Remote.ObjectGateway).%New()

            // Properties used in all server definitions
            set OG.Type = "2"   // Defines a .NET server
            set OG.Name  = "NetGate2"
            set OG.Server  = "127.0.0.1"
            set OG.Port  = "55602" // port number must be unique

            // .NET-only properties
            set OG.AllowedIPAddresses = "127.0.0.1"
            set OG.FilePath  = "C:\InterSystems\IRIS\dev\dotnet\bin\v4.5\"
            // keep Exec64 default value
            set OG.DotNetVersion = "4.5"

            $$$ThrowOnError(OG.%Save())*/
            


        // Get a ObjectGateway instance that defines the NetGate server
        $$$ThrowOnError(##class(%Net.Remote.Service).OpenGateway("NetGate",.OG))

        write !, "Using "_OG.Name_" server definition"

        // Test to make sure the server is running. If not, start it
        if ('##class(%Net.Remote.Service).IsGatewayRunning(OG.Server,OG.Port,,.status)) {
            // Instantiate the server on the host machine
            $$$ThrowOnError(##class(%Net.Remote.Service).StartGateway(OG.Name))
            } 
        ELSE {
            write !,"GateWay all ready started"
        }
        

        
                // define the location of the file containing the Fruit class
        set fruitPath = ##class(%ListOfDataTypes).%New()
        do fruitPath.Insert("C:\Users\training\git\RestToDll\Allergie\Allergie\bin\Debug\net45\Allergie.dll")

        // Connect a Gateway instance to server NetGate on the host machine
        set GW = ##class(%Net.Remote.Gateway).%New()
        $$$ThrowOnError(GW.%Connect(OG.Server, OG.Port, "USER",,fruitPath))

        // Use GW connection to create a proxy for the Fruit class
        set proxyAllergie = ##class(%Net.Remote.Object).%New(GW,"Allergie.Allergie")

        set tReturn = proxyAllergie.getReactions("frugfsgdsit")

        FOR x=0:1:tReturn.Count {
            w !,tReturn.%get(x)
        }
        

        w tReturn.Count

        }
        catch ex {
            set tSc = ex.AsStatus() 
            
        }

        do GW.%Disconnect()
        do ##class(%Net.Remote.Service).StopGatewayObject(OG)
        Quit tSc
}

}
