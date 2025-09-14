@EndUserText.label: 'Copy Teachers'
define abstract entity ZD_CopyTeachersP
{
  @EndUserText.label: 'New School ID'
  @UI.defaultValue: #( 'ELEMENT_OF_REFERENCED_ENTITY: Schoolid' )
  Schoolid : ZSCHOOLID;
  @EndUserText.label: 'New Teacher ID'
  @UI.defaultValue: #( 'ELEMENT_OF_REFERENCED_ENTITY: Teacherid' )
  Teacherid : ZTEACHERID;
}
