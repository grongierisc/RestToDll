/// 
Class User.Patient Extends %Persistent [ ClassType = persistent, DdlAllowed, Final, Owner = {UnknownUser}, ProcedureBlock, SqlRowIdPrivate, SqlTableName = Patient ]
{

Property PATIENTID As %Library.Integer(MAXVAL = 2147483647, MINVAL = 1) [ Identity, Required, SqlColumnNumber = 2 ];

Property FIRSTNAME As %Library.String(MAXLEN = 30) [ Required, SqlColumnNumber = 3 ];

Property LASTNAME As %Library.String(MAXLEN = 30) [ Required, SqlColumnNumber = 4 ];

Property HEIGHT As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 5 ];

Property WEIGHT As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 6 ];

Property ALLERGICREACTION As %Library.String(MAXLEN = 30) [ SqlColumnNumber = 7, SqlFieldName = ALLERGIC_REACTION ];

Parameter USEEXTENTSET = 1;

/// DDL Primary Key Specification
Index PATIENTPKey4 On PATIENTID [ IdKey, PrimaryKey, Unique ];

Storage Default
{
<Data name="PatientDefaultData">
<Value name="1">
<Value>FIRSTNAME</Value>
</Value>
<Value name="2">
<Value>LASTNAME</Value>
</Value>
<Value name="3">
<Value>HEIGHT</Value>
</Value>
<Value name="4">
<Value>WEIGHT</Value>
</Value>
<Value name="5">
<Value>ALLERGICREACTION</Value>
</Value>
</Data>
<DataLocation>^poCN.DuIo.1</DataLocation>
<DefaultData>PatientDefaultData</DefaultData>
<ExtentLocation>^poCN.DuIo</ExtentLocation>
<IdFunction>sequence</IdFunction>
<IdLocation>^poCN.DuIo.1</IdLocation>
<Index name="PATIENTPKey4">
<Location>^poCN.DuIo.1</Location>
</Index>
<IndexLocation>^poCN.DuIo.I</IndexLocation>
<StreamLocation>^poCN.DuIo.S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
