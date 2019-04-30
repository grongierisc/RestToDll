Class RestToDll.Msg.ResultResponse Extends Ens.Response
{

Property Results As list Of %String;

Storage Default
{
<Data name="ResultResponseDefaultData">
<Subscript>"ResultResponse"</Subscript>
<Value name="1">
<Value>Results</Value>
</Value>
</Data>
<DefaultData>ResultResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
