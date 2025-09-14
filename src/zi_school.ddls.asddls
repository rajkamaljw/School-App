@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'School Interface View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_School
  as select from zschool
  composition [0..*] of ZI_teacher as _teacher

{
  key schoolid   as Schoolid,
      schoolname as Schoolname,
      board      as Board,
      location   as Location,
      city       as City,
      principal  as Principal,
      _teacher // Make association public

}
