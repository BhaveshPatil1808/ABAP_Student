CLASS lhc_ZCDS_STUDENT_001 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zcds_student_001 RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zcds_student_001 RESULT result.

    METHODS calculateAge FOR MODIFY
      IMPORTING keys FOR ACTION zcds_student_001~calculateAge RESULT result.

    METHODS validateName FOR VALIDATE ON SAVE
      IMPORTING keys FOR zcds_student_001~validateName.


ENDCLASS.

CLASS lhc_ZCDS_STUDENT_001 IMPLEMENTATION.

  METHOD get_instance_features.
  result = VALUE #(
    FOR key IN keys
    (
      %tky = key-%tky
      %features-%action-calculateAge = if_abap_behv=>fc-o-enabled
    )
  ).
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD calculateAge.
   DATA: lv_today TYPE d,
        lv_age   TYPE i.

  lv_today = cl_abap_context_info=>get_system_date( ).

  READ ENTITIES OF zcds_student_001 IN LOCAL MODE
    ENTITY zcds_student_001
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_student).

  MODIFY ENTITIES OF zcds_student_001 IN LOCAL MODE
    ENTITY zcds_student_001
    UPDATE
      FIELDS ( Age )
      WITH VALUE #(
        FOR ls_student IN lt_student
        (
          %tky = ls_student-%tky
          Age =
            COND i(
              WHEN ls_student-dob IS INITIAL
              THEN 0
              ELSE lv_today+0(4) - ls_student-dob+0(4)
            )
        )
      )
    FAILED failed
    REPORTED reported.

  READ ENTITIES OF zcds_student_001 IN LOCAL MODE
    ENTITY zcds_student_001
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_result).

  result = VALUE #(
    FOR ls_result IN lt_result
    (
      %tky   = ls_result-%tky
      %param = ls_result
    )
  ).

  ENDMETHOD.

  METHOD validateName.

  READ ENTITIES OF zcds_student_001 IN LOCAL MODE
    ENTITY zcds_student_001
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_student).

  LOOP AT lt_student INTO DATA(ls_student).

    IF ls_student-name IS INITIAL.

      APPEND VALUE #(
        %tky = ls_student-%tky
        %msg = new_message_with_text(
                  severity = if_abap_behv_message=>severity-error
                  text     = 'Please Enter Name'
               )
      ) TO reported-zcds_student_001.

    ENDIF.

  ENDLOOP.
  ENDMETHOD.



ENDCLASS.
