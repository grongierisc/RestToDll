/// 
Class RestToDll.BP.RestToDll Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='RestToDll.Msg.RestGetRequest' response='RestToDll.Msg.ResultResponse' height='2000' width='2000' >
<sequence xend='200' yend='700' >
<transform name='ToLowerCase' class='RestToDll.DT.UniformStringCase' source='request' target='request' xpos='200' ypos='250' />
<if name='Aliment vs Allergie' condition='request.Type = "aliment"' xpos='200' ypos='350' xend='200' yend='600' >
<true>
<call name='GetAlimentsFromAllergie' target='DLL_ALLERGIE' async='0' xpos='470' ypos='500' >
<request type='RestToDll.Msg.AlimentRequest' >
<assign property="callrequest.Name" value="request.Name" action="set" />
</request>
<response type='RestToDll.Msg.ResultResponse' >
<assign property="response.Results" value="callresponse.Results" action="set" />
</response>
</call>
</true>
<false>
<call name='GetAllergiesFromAliment' target='DLL_ALLERGIE' async='0' xpos='200' ypos='500' >
<request type='RestToDll.Msg.ReactionRequest' >
<assign property="callrequest.Name" value="request.Name" action="set" />
</request>
<response type='RestToDll.Msg.ResultResponse' >
<assign property="response.Results" value="callresponse.Results" action="set" />
</response>
</call>
</false>
</if>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
