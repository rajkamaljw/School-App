CLASS lhc_ZI_School DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR ZI_School RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR ZI_School RESULT result.
    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE ZI_School.

    METHODS earlynumbering_cba_Teacher FOR NUMBERING
      IMPORTING entities FOR CREATE ZI_School\_Teacher.

ENDCLASS.

CLASS lhc_ZI_School IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.
    DATA(lt_entities) = entities.

    DELETE lt_entities WHERE Schoolid IS NOT INITIAL.
    TRY.
        cl_numberrange_runtime=>number_get( EXPORTING nr_range_nr       = '01'
                                                      object            = '/DMO/TRV_M'
                                                      quantity          = CONV #( lines( lt_entities ) )
                                            IMPORTING number            = DATA(lv_latest_num)
                                            " TODO: variable is assigned but never used (ABAP cleaner)
                                                      returncode        = DATA(lv_code)
                                                      returned_quantity = DATA(lv_qty) ).
      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges INTO DATA(lo_error).

        LOOP AT lt_entities INTO DATA(ls_entities).
          APPEND VALUE #( %cid = ls_entities-%cid
                          %key = ls_entities-%key  )
                 TO failed-zi_school.
          APPEND VALUE #( %cid = ls_entities-%cid
                          %key = ls_entities-%key
                          %msg = lo_error )
                 TO reported-zi_school.

        ENDLOOP.
        EXIT.
    ENDTRY.
    ASSERT lv_qty = lines( lt_entities ).
*    DATA: lt_travel_tech_m TYPE TABLE FOR MAPPED EARLY yi_travel_tech_m,
*          ls_travel_tech_m LIKE LINE OF lt_travel_tech_m.
    DATA(lv_curr_num) = lv_latest_num - lv_qty.

    LOOP AT lt_entities INTO ls_entities.

      lv_curr_num = lv_curr_num + 1.
*      ls_travel_tech_m = VALUE #( %cid =  ls_entities-%cid
*                                  Schoolid = lv_curr_num
*       ) .
*      APPEND ls_travel_tech_m TO mapped-yi_travel_tech_m.

      APPEND VALUE #( %cid     = ls_entities-%cid
                      Schoolid = lv_curr_num  )
             TO mapped-zi_school.
    ENDLOOP.
  ENDMETHOD.

  METHOD earlynumbering_cba_Teacher.
    DATA lv_max_teacher TYPE /dmo/booking_id.

    READ ENTITIES OF zi_school IN LOCAL MODE
         ENTITY zi_school BY \_teacher
         FROM CORRESPONDING #( entities )
         LINK DATA(lt_link_data).

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_group_entity>)
         GROUP BY <ls_group_entity>-Schoolid.

      lv_max_teacher = REDUCE #( INIT lv_max = CONV /dmo/booking_id( '0' )
                                 FOR ls_link IN lt_link_data USING KEY entity
                                      WHERE ( source-Schoolid = <ls_group_entity>-Schoolid )
                                 NEXT  lv_max = COND /dmo/booking_id( WHEN lv_max < ls_link-target-Teacherid
                                                                      THEN ls_link-target-Teacherid
                                                                      ELSE lv_max ) ).
      lv_max_teacher = REDUCE #( INIT lv_max = lv_max_teacher
                                  FOR ls_entity IN entities USING KEY entity
                                      WHERE ( Schoolid = <ls_group_entity>-Schoolid )
                                    FOR ls_teacher IN ls_entity-%target
                                    NEXT lv_max = COND /dmo/booking_id( WHEN lv_max < ls_teacher-Teacherid
                                                                        THEN ls_teacher-Teacherid
                                                                        ELSE lv_max ) ).

      LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_entities>)
           USING KEY entity
           WHERE Schoolid = <ls_group_entity>-Schoolid.

        LOOP AT <ls_entities>-%target ASSIGNING FIELD-SYMBOL(<ls_teacher>).
          APPEND CORRESPONDING #( <ls_teacher> ) TO mapped-zi_teacher
                 ASSIGNING FIELD-SYMBOL(<ls_new_map_book>).
          IF <ls_teacher>-Teacherid IS INITIAL.
            lv_max_teacher += 1.

            <ls_new_map_book>-Teacherid = lv_max_teacher.
          ENDIF.

        ENDLOOP.

      ENDLOOP.

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
