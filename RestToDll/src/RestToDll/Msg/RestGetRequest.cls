Class RestToDll.Msg.RestGetRequest Extends Ens.Request
{

Property Id As %Integer;

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
<Value>Id</Value>
</Value>
</Data>
<DefaultData>AlimentRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
