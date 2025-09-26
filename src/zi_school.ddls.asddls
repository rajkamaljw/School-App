@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'School Interface View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_School
  as select from zschool
  composition [0..*] of ZI_teacher as _teacher
  association [0..1] to ZI_Board_VH as _Board on $projection.Board = _Board.Board 

{
  key schoolid   as Schoolid,
      schoolname as Schoolname,
      board      as Board,
      location   as Location,
      city       as City,
      principal  as Principal,
       @Semantics.user.createdBy: true
      created_by      as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at      as CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      last_changed_by as LastChangedBy,
      //the persistent field last_changed_at plays a special role as a field ETag.
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at as LastChangedAt,
      _teacher, // Make association public
      _Board

}
