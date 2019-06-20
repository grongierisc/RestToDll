Class RestToDll.Msg.ResultResponse Extends Ens.Response
{

Property Aliments As list Of %String;

Property FirstName As %String;

Property LastName As %String;

Property Height As %Integer;

Property Weight As %Integer;

Property AllergicReaction As %String;

Property IMC As %Integer;

Storage Default
{
<Data name="ResultResponseDefaultData">
<Subscript>"ResultResponse"</Subscript>
<Value name="1">
<Value>Results</Value>
</Value>
<Value name="2">
<Value>Aliments</Value>
</Value>
<Value name="3">
<Value>FirstName</Value>
</Value>
<Value name="4">
<Value>LastName</Value>
</Value>
<Value name="5">
<Value>Height</Value>
</Value>
<Value name="6">
<Value>Weight</Value>
</Value>
<Value name="7">
<Value>AllergicReaction</Value>
</Value>
<Value name="8">
<Value>IMC</Value>
</Value>
</Data>
<DefaultData>ResultResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
