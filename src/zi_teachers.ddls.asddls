@EndUserText.label: 'Teachers'
@AccessControl.authorizationCheck: #NOT_ALLOWED
@Metadata.allowExtensions: true
define view entity ZI_Teachers
  as select from zteacher
  association to parent ZI_Teachers_S as _TeachersAll on $projection.SingletonID = _TeachersAll.SingletonID
{
  key schoolid as Schoolid,
  key teacherid as Teacherid,
  teacher_name as TeacherName,
  dob as Dob,
  gender as Gender,
  subject as Subject,
  isclassteacher as Isclassteacher,
  phone as Phone,
  qualification as Qualification,
  @Consumption.hidden: true
  1 as SingletonID,
  _TeachersAll
}
