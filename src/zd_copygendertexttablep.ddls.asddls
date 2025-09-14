@EndUserText.label: 'Copy Gender Text Table'
define abstract entity ZD_CopyGenderTextTableP
{
  @EndUserText.label: 'New Gender'
  @UI.defaultValue: #( 'ELEMENT_OF_REFERENCED_ENTITY: Gender' )
  Gender : ZGENDER;
}
