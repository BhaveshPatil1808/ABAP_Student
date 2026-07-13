@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PV STUDENT'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZCDS_PV_STUDENT_001
 as projection on ZCDS_STUDENT_001 as STUDENT
{
    @EndUserText.label: 'Student ID'
    key Studentid,
    
    @EndUserText.label: 'Student Name'
    Name,
    
    @EndUserText.label: 'Student Address'
    Address,
    
    @EndUserText.label: 'Date of Birth'
    dob,
    
    @EndUserText.label: 'Age'
    Age
    
    
}
