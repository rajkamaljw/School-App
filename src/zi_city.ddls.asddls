@EndUserText.label: 'City'
@AccessControl.authorizationCheck: #NOT_ALLOWED
@Metadata.allowExtensions: true
define view entity ZI_City
  as select from zdt_city
  association to parent ZI_City_S as _CityAll on $projection.SingletonID = _CityAll.SingletonID
{
  key city as City,
  @Consumption.hidden: true
  1 as SingletonID,
  _CityAll
}
