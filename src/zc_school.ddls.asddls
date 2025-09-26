@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'School Projection View'
@Metadata.ignorePropagatedAnnotations: false
@Metadata.allowExtensions: true
define root view entity ZC_School 
provider contract transactional_query
as projection on ZI_School
{
    key Schoolid,
    Schoolname,
    Board,
    Location,
    City,
    Principal,
     CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
    /* Associations */
    _teacher : redirected to composition child ZC_Teacher,
    _Board
}
