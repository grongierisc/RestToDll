Class RestToDll.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="RestToDll.Production" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="WS_REST" Category="" ClassName="RestToDll.BS.RestToDll" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="DLL_ALLERGIE" Category="" ClassName="RestToDll.BO.DllOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="DllPath">C:\Users\training\git\RestToDll\Allergie\Allergie.dll</Setting>
  </Item>
  <Item Name="REST_TO_DLL" Category="" ClassName="RestToDll.BP.RestToDll" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
