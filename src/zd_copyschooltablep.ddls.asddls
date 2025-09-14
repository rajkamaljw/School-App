@EndUserText.label: 'Copy School Table'
define abstract entity ZD_CopySchoolTableP
{
  @EndUserText.label: 'New School ID'
  @UI.defaultValue: #( 'ELEMENT_OF_REFERENCED_ENTITY: Schoolid' )
  Schoolid : ZSCHOOLID;
}
