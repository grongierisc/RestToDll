/// 
Class RestToDll.BP.RestToDll Extends Ens.BusinessProcessBPL
{

/// This BPLError block indicates that a BPL Diagram 
/// containing errors was saved.
/// To correct this class:
/// * Open it using the Studio BPL Editor,
/// * Correct the errors, and,
/// * Save the diagram.
/// Do not edit the contents of the BPLError block
/// or you may lose your diagram.
XData BPLError
{
<diagram Name="RestToDll.BP.RestToDll" Width="2000" Height="2000" Layout="automatic" Language="objectscript" Request="RestToDll.Msg.RestGetRequest" Response="RestToDll.Msg.ResultResponse" LastModified="" Version="" Includes="" ShowAnnotation="0">
<shape _index="0" _Type="start" Name="" xPos="200" yPos="150" />
<shape _index="1" _Type="end" Name="" xPos="200" yPos="700" />
<shape _index="2" _Type="transform" Name="ToUpperCase" xPos="200" yPos="250" Class="RestToDll.DT.UniformStringCase" Source="request" Target="request" />
<shape _index="3" _Type="if" Name="Aliment vs Allergie" xPos="200" yPos="350" Condition="request.Type = &quot;aliment&quot;" />
<shape _index="4" _Type="join" Name="" xPos="200" yPos="600" />
<shape _index="5" _Type="call" Name="GetAllergiesFromAliment" xPos="200" yPos="500" Async="1" Target="" Timeout="" >
<request type='RestToDll.Msg.AlimentRequest' >
<assign property="callrequest.Name" value="request.Name" action="set" />
</request>
<response type='RestToDll.Msg.ResultResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</shape>
<shape _index="6" _Type="call" Name="GetAlimentsFromAllergie" xPos="470" yPos="500" Async="1" Target="" Timeout="" >
<request type='Ens.Request' />
<response type='Ens.Response' />
</shape>
<connection _Type="connector" Name="" from="0" to="2"/>
<connection _Type="connector" Name="" from="2" to="3"/>
<connection _Type="connector" Name="false" from="3" to="5" ConnectType="branch"/>
<connection _Type="connector" Name="true" from="3" to="6" ConnectType="branch"/>
<connection _Type="connector" Name="" from="4" to="1"/>
<connection _Type="connector" Name="" from="5" to="4"/>
<connection _Type="connector" Name="" from="6" to="4"/>
</diagram>
}

}
