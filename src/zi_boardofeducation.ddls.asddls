@EndUserText.label: 'Board of Education'
@AccessControl.authorizationCheck: #NOT_ALLOWED
@Metadata.allowExtensions: true
define view entity ZI_BoardOfEducation
  as select from ZDT_BOARD
  association to parent ZI_BoardOfEducation_S as _BoardOfEducationAll on $projection.SingletonID = _BoardOfEducationAll.SingletonID
{
  key BOARD as Board,
  @Consumption.hidden: true
  1 as SingletonID,
  _BoardOfEducationAll
}
