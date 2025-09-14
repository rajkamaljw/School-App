@EndUserText.label: 'Gender Text Table'
@AccessControl.authorizationCheck: #NOT_ALLOWED
@Metadata.allowExtensions: true
define view entity ZI_GenderTextTable
  as select from zdt_gender
  association to parent ZI_GenderTextTable_S as _GenderTextTableAll on $projection.SingletonID = _GenderTextTableAll.SingletonID
{
  key gender as Gender,
  text as Text_000,
  @Consumption.hidden: true
  1 as SingletonID,
  _GenderTextTableAll
}
