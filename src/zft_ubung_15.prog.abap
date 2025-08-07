*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_15
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_15.


*Erstellen Sie ein Container-ALV für die Tabelle SFLIGHT.
*Der Benutzer soll ein Eingabefeld zur Verfügung haben, in das er einen Spaltennamen eingeben kann. Zusätzlich sollen drei Schaltflächen vorhanden sein, die jeweils einen Farbnamen darstellen.
*Wenn der Benutzer einen Spaltennamen eingibt und anschließend auf eine der Schaltflächen klickt, soll die entsprechende Spalte im ALV in der ausgewählten Farbe hervorgehoben werden.


DATA: gt_sflight   TYPE TABLE OF sflight,
      gs_sflight   TYPE sflight,
      gt_fcat      TYPE lvc_t_fcat,
      gs_fcat      TYPE lvc_s_fcat,
      gs_layout    TYPE lvc_s_layo,
      gv_field     TYPE string,
      go_container TYPE REF TO cl_gui_custom_container,
      go_alv       TYPE REF TO cl_gui_alv_grid.


START-OF-SELECTION.

  CALL SCREEN 0200.

MODULE status_0200 OUTPUT.
  SET PF-STATUS 'PF_STATUS_15'.
*  SET TITLEBAR 'xxx'.

  PERFORM alv.
ENDMODULE.

MODULE user_command_0200 INPUT.

  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.
    WHEN 'RED'.

      LOOP AT gt_fcat INTO gs_fcat.

        CLEAR: gs_fcat-emphasize.

        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize.

      ENDLOOP.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_l = gv_field.

      IF sy-subrc IS INITIAL.
        gs_fcat-emphasize = 'C610'.
        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname =  gs_fcat-fieldname.
      ENDIF.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_m = gv_field.

      IF sy-subrc IS INITIAL.
        gs_fcat-emphasize = 'C610'.
        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname =  gs_fcat-fieldname.
      ENDIF.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_s = gv_field.

      IF sy-subrc IS INITIAL.
        gs_fcat-emphasize = 'C610'.
        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname =  gs_fcat-fieldname.
      ENDIF.

    WHEN 'YELLOW'.

      LOOP AT gt_fcat INTO gs_fcat.

        CLEAR: gs_fcat-emphasize.

        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize.

      ENDLOOP.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_l = gv_field.

      IF sy-subrc IS INITIAL.
        gs_fcat-emphasize = 'C310'.
        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname =  gs_fcat-fieldname.
      ENDIF.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_m = gv_field.

      IF sy-subrc IS INITIAL.
        gs_fcat-emphasize = 'C310'.
        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname =  gs_fcat-fieldname.
      ENDIF.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_s = gv_field.

      IF sy-subrc IS INITIAL.
        gs_fcat-emphasize = 'C310'.
        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname =  gs_fcat-fieldname.
      ENDIF.

    WHEN 'GREEN'.

      LOOP AT gt_fcat INTO gs_fcat.

        CLEAR: gs_fcat-emphasize.

        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize.

      ENDLOOP.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_l = gv_field.

      IF sy-subrc IS INITIAL.
        gs_fcat-emphasize = 'C511'.
        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname =  gs_fcat-fieldname.
      ENDIF.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_m = gv_field.

      IF sy-subrc IS INITIAL.
        gs_fcat-emphasize = 'C511'.
        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname =  gs_fcat-fieldname.
      ENDIF.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY scrtext_s = gv_field.

      IF sy-subrc IS INITIAL.
        gs_fcat-emphasize = 'C511'.
        MODIFY gt_fcat FROM gs_fcat TRANSPORTING emphasize WHERE fieldname =  gs_fcat-fieldname.
      ENDIF.

*  	WHEN OTHERS.
  ENDCASE.

ENDMODULE.

FORM alv.

  IF gt_sflight IS INITIAL.
    SELECT * FROM sflight
      INTO TABLE gt_sflight.
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
    BREAK-POINT .
  ENDIF.


  gs_layout-zebra           = abap_true.
  gs_layout-cwidth_opt      = abap_true.
  gs_layout-sel_mode        = 'A'.


  IF go_alv IS NOT BOUND.

    CREATE OBJECT go_container
      EXPORTING
        container_name              = 'C_ALV'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
      BREAK-POINT .
    ENDIF.

    CREATE OBJECT go_alv
      EXPORTING
        i_parent          = go_container
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.
    IF sy-subrc <> 0.
      BREAK-POINT .
    ENDIF.

    go_alv->set_table_for_first_display(
      EXPORTING
        is_layout                     =  gs_layout
      CHANGING
        it_outtab                     =  gt_sflight
        it_fieldcatalog               =  gt_fcat
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).
    IF sy-subrc <> 0.
      BREAK-POINT .
    ENDIF.

  ELSE.

    go_alv->set_frontend_fieldcatalog( it_fieldcatalog = gt_fcat ).
    go_alv->set_frontend_layout( is_layout = gs_layout ).

    go_alv->refresh_table_display(
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2 ).
    IF sy-subrc <> 0.
      BREAK-POINT .
    ENDIF.
  ENDIF.

ENDFORM.
