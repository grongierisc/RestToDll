Class RestToDll.DT.UniformStringCase Extends Ens.DataTransformDTL [ DependsOn = RestToDll.Msg.RestGetRequest ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='RestToDll.Msg.RestGetRequest' targetClass='RestToDll.Msg.RestGetRequest' create='new' language='objectscript' >
<assign value='..ToUpper(source.Name)' property='target.Name' action='set' />
<assign value='source.Type' property='target.Type' action='set' />
</transform>
}

}
