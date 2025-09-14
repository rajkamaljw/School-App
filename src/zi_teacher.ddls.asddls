@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Teacher Interface view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_teacher as select from zteacher
association to parent ZI_School as _school
    on $projection.Schoolid = _school.Schoolid
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
    _school // Make association public
}
