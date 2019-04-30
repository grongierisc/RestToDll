Class RestToDll.Msg.RestPostRequest Extends Ens.Request
{

// Type is either aliment or allergie

Property Type As %String;

Property Names As list Of %String;

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
<Value name="3">
<Value>Names</Value>
</Value>
</Data>
<DefaultData>AlimentRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
