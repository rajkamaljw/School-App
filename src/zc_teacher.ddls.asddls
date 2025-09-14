@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Teacher Consumption View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_Teacher 
as projection on ZI_teacher
{
    key Schoolid,
    key Teacherid,
    TeacherName,
    Dob,
    Gender,
    Subject,
    Isclassteacher,
    Phone,
    Qualification,
    /* Associations */
    _school: redirected to parent zc_school
}
