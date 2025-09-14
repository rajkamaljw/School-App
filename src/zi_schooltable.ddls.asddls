@EndUserText.label: 'School Table'
@AccessControl.authorizationCheck: #NOT_ALLOWED
@Metadata.allowExtensions: true
define view entity ZI_SchoolTable
  as select from zschool
  association to parent ZI_SchoolTable_S as _SchoolTableAll on $projection.SingletonID = _SchoolTableAll.SingletonID
{
  key schoolid as Schoolid,
  schoolname as Schoolname,
  board as Board,
  location as Location,
  city as City,
  principal as Principal,
  @Consumption.hidden: true
  1 as SingletonID,
  _SchoolTableAll
}
