*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_19
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_19.


*Ziel:
*Auf dem Call-Screen (Dynpro) sollen zwei Container erstellt werden, um ausgewählte Zeilen von links nach rechts oder von rechts nach links zu verschieben und zu löschen.

*Methode:
*Auf dem Call-Screen werden zwei Container erstellt. Der linke Container wird mit Daten gefüllt, der rechte ist zunächst leer. 
*Die im linken Container ausgewählten Zeilen werden beim Betätigen eines Buttons nach rechts verschoben und aus dem linken Container entfernt. 
*Genauso werden ausgewählte Zeilen vom rechten Container nach links verschoben und im rechten Container nicht mehr angezeigt. 
*Zusätzlich können markierte Zeilen in beiden Tabellen gelöscht werden, jedoch nicht aus der Datenbank, sondern nur aus den internen Tabellen.



DATA: gt_sflight_1 TYPE TABLE OF sflight,
      gs_sflight_1 TYPE sflight,
      gt_sflight_2 TYPE TABLE OF sflight,
      gs_sflight_2 TYPE sflight,
      gt_fcat      TYPE lvc_t_fcat,
      gs_fcat      TYPE lvc_s_fcat,
      gs_layout    TYPE lvc_s_layo,
      go_cont_1    TYPE REF TO cl_gui_custom_container,
      go_cont_2    TYPE REF TO cl_gui_custom_container,
      go_alv_1     TYPE REF TO cl_gui_alv_grid,
      go_alv_2     TYPE REF TO cl_gui_alv_grid.



START-OF-SELECTION.

  CALL SCREEN 0200.

MODULE status_0200 OUTPUT.
  SET PF-STATUS 'PF_STATUS_19'.
*  SET TITLEBAR 'xxx'.

  PERFORM alv_sflight_1.

*  IF gt_sflight_2 IS NOT INITIAL.
*    PERFORM alv_sflight_2.
*  ELSEIF gt_sflight_2 IS INITIAL.
*    perform fcat.
*  ENDIF.

  IF gt_sflight_2 IS NOT INITIAL.
    PERFORM select_data.
    PERFORM alv.
  ELSEIF gt_sflight_2 IS INITIAL.
    PERFORM alv.
  ENDIF.


ENDMODULE.

MODULE user_command_0200 INPUT.

  DATA: ls_selected_rows TYPE lvc_s_roid.
  DATA: ls_selected_rows_2 TYPE lvc_s_roid.
  DATA: lt_selected_rows TYPE lvc_t_roid.
  DATA: lt_selected_rows_2 TYPE lvc_t_roid.
  DATA: lt_sflight_1 TYPE TABLE OF sflight.
  DATA: lt_sflight_2 TYPE TABLE OF sflight.




  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.
    WHEN 'RIGHT'.

      lt_sflight_1 = gt_sflight_1.

      go_alv_1->get_selected_rows(
        IMPORTING
*        et_index_rows =
          et_row_no     =   lt_selected_rows ).

      LOOP AT lt_selected_rows INTO ls_selected_rows.

        READ TABLE gt_sflight_1 INTO gs_sflight_1 INDEX ls_selected_rows-row_id.

        IF sy-subrc IS INITIAL.

          APPEND gs_sflight_1 TO gt_sflight_2.

          DELETE lt_sflight_1 WHERE carrid = gs_sflight_1-carrid AND
                                    connid = gs_sflight_1-connid AND
                                    fldate = gs_sflight_1-fldate.

        ENDIF.

      ENDLOOP.


      gt_sflight_1 = lt_sflight_1.

      CLEAR: ls_selected_rows.
      CLEAR: gs_sflight_1.

      SORT gt_sflight_2.



    WHEN 'LEFT'.

      lt_sflight_2 = gt_sflight_2.

      go_alv_2->get_selected_rows(
        IMPORTING
*        et_index_rows =
          et_row_no     =   lt_selected_rows ).

      LOOP AT lt_selected_rows INTO ls_selected_rows.

        READ TABLE gt_sflight_2 INTO gs_sflight_2 INDEX ls_selected_rows-row_id.

        IF sy-subrc IS INITIAL.

          APPEND gs_sflight_2 TO gt_sflight_1.

          DELETE lt_sflight_2 WHERE carrid = gs_sflight_2-carrid AND
                                    connid = gs_sflight_2-connid AND
                                    fldate = gs_sflight_2-fldate.

        ENDIF.

      ENDLOOP.


      gt_sflight_2 = lt_sflight_2.

      CLEAR: ls_selected_rows.
      CLEAR: gs_sflight_2.

      SORT gt_sflight_1.

    WHEN 'DELETE'.

      lt_sflight_1 = gt_sflight_1.

      go_alv_1->get_selected_rows(
    IMPORTING
*        et_index_rows =
      et_row_no     =   lt_selected_rows ).

      IF lt_selected_rows IS NOT INITIAL.

        LOOP AT lt_selected_rows INTO ls_selected_rows.

          READ TABLE gt_sflight_1 INTO gs_sflight_1 INDEX ls_selected_rows-row_id.

          IF sy-subrc IS INITIAL.

            DELETE lt_sflight_1 WHERE carrid = gs_sflight_1-carrid AND
                                      connid = gs_sflight_1-connid AND
                                      fldate = gs_sflight_1-fldate.

          ENDIF.


        ENDLOOP.

      ENDIF.

      gt_sflight_1 = lt_sflight_1.



      lt_sflight_2 = gt_sflight_2.

      go_alv_2->get_selected_rows(
    IMPORTING
*        et_index_rows =
      et_row_no     =   lt_selected_rows_2 ).

      IF lt_selected_rows_2 IS NOT INITIAL.

        LOOP AT lt_selected_rows_2 INTO ls_selected_rows_2.

          READ TABLE gt_sflight_2 INTO gs_sflight_2 INDEX ls_selected_rows_2-row_id.

          IF sy-subrc IS INITIAL.

            DELETE lt_sflight_2 WHERE carrid = gs_sflight_2-carrid AND
                                      connid = gs_sflight_2-connid AND
                                      fldate = gs_sflight_2-fldate.

          ENDIF.

        ENDLOOP.

      ENDIF.

      gt_sflight_2 = lt_sflight_2.

*	WHEN OTHERS.
  ENDCASE.
ENDMODULE.

FORM alv_sflight_1.

  IF gt_sflight_1 IS INITIAL.
    SELECT * FROM sflight
      INTO TABLE gt_sflight_1.
  ENDIF.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SFLIGHT'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.


  gs_layout-zebra             = abap_true.
  gs_layout-cwidth_opt        = abap_true.
  gs_layout-sel_mode          = 'A'.


  IF go_alv_1 IS NOT BOUND.

    CREATE OBJECT go_cont_1
      EXPORTING
        container_name              = 'C_ALV_1'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.


    CREATE OBJECT go_alv_1
      EXPORTING
        i_parent          = go_cont_1
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.


    go_alv_1->set_table_for_first_display(
      EXPORTING
        is_layout                     =   gs_layout
      CHANGING
        it_outtab                     =   gt_sflight_1
        it_fieldcatalog               =   gt_fcat

      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ELSE.
    go_alv_1->refresh_table_display(

    EXCEPTIONS
      finished       = 1
      OTHERS         = 2 ).
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ENDIF.



ENDFORM.

FORM alv_sflight_2.

  IF gt_sflight_2 IS INITIAL.
    SELECT * FROM sflight
      INTO TABLE gt_sflight_2.
  ENDIF.


  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SFLIGHT'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.


  gs_layout-zebra             = abap_true.
  gs_layout-cwidth_opt        = abap_true.
  gs_layout-sel_mode          = 'A'.


  IF go_alv_2 IS NOT BOUND.

    CREATE OBJECT go_cont_2
      EXPORTING
        container_name              = 'C_ALV_2'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.


    CREATE OBJECT go_alv_2
      EXPORTING
        i_parent          = go_cont_2
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.


    go_alv_2->set_table_for_first_display(
      EXPORTING
        is_layout                     =   gs_layout
      CHANGING
        it_outtab                     =   gt_sflight_2
        it_fieldcatalog               =   gt_fcat

      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ELSE.

    go_alv_2->refresh_table_display(

    EXCEPTIONS
      finished       = 1
      OTHERS         = 2 ).
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ENDIF.

ENDFORM.


FORM select_data.

  IF gt_sflight_2 IS INITIAL.
    SELECT * FROM sflight
      INTO TABLE gt_sflight_2.
  ENDIF.

ENDFORM.

FORM alv.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SFLIGHT'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.


  gs_layout-zebra             = abap_true.
  gs_layout-cwidth_opt        = abap_true.
  gs_layout-sel_mode          = 'A'.


  IF go_alv_2 IS NOT BOUND.

    CREATE OBJECT go_cont_2
      EXPORTING
        container_name              = 'C_ALV_2'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.


    CREATE OBJECT go_alv_2
      EXPORTING
        i_parent          = go_cont_2
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.


    go_alv_2->set_table_for_first_display(
      EXPORTING
        is_layout                     =   gs_layout
      CHANGING
        it_outtab                     =   gt_sflight_2
        it_fieldcatalog               =   gt_fcat

      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ELSE.

    go_alv_2->refresh_table_display(

    EXCEPTIONS
      finished       = 1
      OTHERS         = 2 ).
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ENDIF.



ENDFORM.
