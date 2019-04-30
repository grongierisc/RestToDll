Class RestToDll.Msg.RestGetRequest Extends Ens.Request
{

// Type is either aliment or allergie

Property Type As %String;

Property Name As %String;

Storage Default
{
<Data name="AlimentRequestDefaultData">
<Subscript>"AlimentRequest"</Subscript>
<Value name="1">
<Value>Name</Value>
</Value>
<Value name="2">
<Value>Type</Value>
</Value>
</Data>
<DefaultData>AlimentRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
