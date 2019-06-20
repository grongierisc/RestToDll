/// 
Class RestToDll.BP.RestToDll Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='RestToDll.Msg.RestGetRequest' response='RestToDll.Msg.ResultResponse' height='2000' width='2000' >
<context>
<property name='height' type='%Integer' instantiate='0' />
<property name='weight' type='%Integer' instantiate='0' />
<property name='firstname' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='lastname' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='allergicReaction' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='CG' type='%Library.GlobalCharacterStream' instantiate='1' />
</context>
<sequence xend='200' yend='850' >
<transform name='ToLowerCase' class='RestToDll.DT.UniformStringCase' source='request' target='request' xpos='200' ypos='250' />
<sql name='Get Patient Info' xpos='200' ypos='350' >
<![CDATA[SELECT HEIGHT, WEIGHT, FIRSTNAME, LASTNAME, ALLERGIC_REACTION INTO :context.height, :context.weight, :context.firstname, :context.lastname, :context.allergicReaction 
FROM SQLUser.Patient 
WHERE PATIENTID=:request.Id]]>
</sql>
<call name='GetAliments' target='DLL_ALLERGIE' async='0' xpos='200' ypos='450' >
<request type='RestToDll.Msg.AlimentRequest' >
<assign property="callrequest.Name" value="context.allergicReaction" action="set" />
</request>
<response type='RestToDll.Msg.AlimentResponse' >
<assign property="response.Aliments" value="callresponse.Results" action="set" />
</response>
</call>
<code name='Message to send' xpos='200' ypos='550' >
<![CDATA[ d context.CG.Write(context.weight_" "_context.height)]]>
</code>
<call name='GetIMC' target='JBH_IMC' async='0' xpos='200' ypos='650' disabled="true">
<request type='Ens.StreamContainer' >
<assign property="callrequest.Stream" value="context.CG" action="set" />
</request>
<response type='Ens.StringResponse' >
<assign property="response.IMC" value="callresponse.StringValue" action="set" />
</response>
</call>
<sequence name='Set response values' xpos='200' ypos='750' xend='200' yend='850' >
<assign name="Set firstname" property="response.FirstName" value="context.firstname" action="set" xpos='200' ypos='250' />
<assign name="Set lastname" property="response.LastName" value="context.lastname" action="set" xpos='200' ypos='350' />
<assign name="Set height" property="response.Height" value="context.height" action="set" xpos='200' ypos='450' />
<assign name="Set weight" property="response.Weight" value="context.weight" action="set" xpos='200' ypos='550' />
<assign name="Set allergic reaction" property="response.AllergicReaction" value="context.allergicReaction" action="set" xpos='200' ypos='650' />
<assign name="Set imc" property="response.IMC" value="context.weight/(context.height*0.01*context.height*0.01)" action="set" xpos='200' ypos='750' />
</sequence>
</sequence>
</process>
}

}
