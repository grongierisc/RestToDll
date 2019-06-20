Class RestToDll.DT.UniformStringCase Extends Ens.DataTransformDTL [ DependsOn = RestToDll.Msg.RestGetRequest ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='RestToDll.Msg.RestGetRequest' targetClass='RestToDll.Msg.RestGetRequest' create='new' language='objectscript' >
<assign value='source.Id' property='target.Id' action='set' />
</transform>
}

}
