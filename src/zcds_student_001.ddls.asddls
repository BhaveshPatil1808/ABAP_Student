@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS FOR STUDENT'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZCDS_STUDENT_001 as select from zstudent_001
{
    key studentid as Studentid,
    name as Name,
    address as Address,
    dob as dob,
    
    age as Age
}
