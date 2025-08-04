*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_17
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_17.

*Erstellen Sie ein Container-ALV, in dem die Tabellen SPFLI und SFLIGHT nebeneinander angezeigt werden.
*Zwischen den beiden ALVs soll sich ein Eingabefeld befinden, in das ein Wert vom Typ CARRID eingegeben werden kann.
*
*Direkt unter diesem Eingabefeld soll sich ein Button befinden.
*Wenn der Benutzer einen beliebigen CARRID eingibt und auf den Button klickt, sollen in beiden ALVs nur die Zeilen angezeigt werden, die zu diesem CARRID gehören. Alle anderen Zeilen sollen ausgeblendet werden.
*
*Unter dem ersten Button soll ein zweiter Button eingefügt werden.
*Wenn auf diesen zweiten Button geklickt wird, sollen beide ALVs in ihren ursprünglichen Zustand zurückgesetzt werden, d.h. alle Daten sollen wieder angezeigt werden.


DATA: gt_spfli        TYPE TABLE OF spfli,
      gs_spfli        TYPE spfli,
      gt_sflight      TYPE TABLE OF sflight,
      gs_sflight      TYPE sflight,
      gt_fcat_spfli   TYPE lvc_t_fcat,
      gt_fcat_sflight TYPE lvc_t_fcat,
      gs_fcat         TYPE lvc_s_fcat,
      gs_layout       TYPE lvc_s_layo,
      go_cont_1       TYPE REF TO cl_gui_custom_container,
      go_cont_2       TYPE REF TO cl_gui_custom_container,
      go_alv_1        TYPE REF TO cl_gui_alv_grid,
      go_alv_2        TYPE REF TO cl_gui_alv_grid.

DATA: gv_carrid TYPE s_carr_id.


START-OF-SELECTION.

  CALL SCREEN 0100.

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'PF_STATUS_17'.
*  SET TITLEBAR 'xxx'.

  PERFORM alv_spfli.
  PERFORM alv_sflight.



ENDMODULE.

MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.
    WHEN 'SHOW'.

      DELETE gt_spfli WHERE carrid NE gv_carrid.

      IF gt_spfli IS INITIAL.

        MESSAGE 'Es gibt keine Information mit dem eingegebenen CARRID auf der Tabelle SPFLI (auf der linken Seite)' TYPE 'S' DISPLAY LIKE 'E'.

      ENDIF.
      DELETE gt_sflight WHERE carrid NE gv_carrid.

      IF gt_sflight IS INITIAL.

        MESSAGE 'Es gibt keine Information mit dem eingegebenen CARRID auf der Tabelle SFLIGHT (auf der rechten Seite)' TYPE 'S' DISPLAY LIKE 'E'.

      ENDIF.

    WHEN 'RESET'.

      CLEAR: gt_spfli.
      CLEAR:  gt_sflight.

*  	WHEN OTHERS.
  ENDCASE.

ENDMODULE.

FORM alv_spfli.



  IF gt_spfli IS INITIAL.
    SELECT * FROM spfli
      INTO TABLE gt_spfli.
  ENDIF.


  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SPFLI'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat_spfli
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
        container_name              = 'C_SPFLI'
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
        it_outtab                     =   gt_spfli
        it_fieldcatalog               =   gt_fcat_spfli

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

FORM alv_sflight.

  IF gt_sflight IS INITIAL.
    SELECT * FROM sflight
      INTO TABLE gt_sflight.
  ENDIF.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SFLIGHT'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat_sflight
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
        container_name              = 'C_SFLIGHT'
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
        it_outtab                     =   gt_sflight
        it_fieldcatalog               =   gt_fcat_sflight

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
