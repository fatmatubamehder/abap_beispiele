*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_16
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_16.


*Erstellen Sie ein ALV-Grid in einem Custom Control Container basierend auf der Tabelle SFLIGHT. Die folgende Funktionalität soll implementiert werden:
*
*Fügen Sie ein Eingabefeld ein, in das der Benutzer eine Zahl eingeben kann.
*
*Fügen Sie zwei Radiobuttons ein mit den Beschriftungen:
*
*„GRÖSSER ALS“
*
*„KLEINER ALS“
*
*Fügen Sie einen Button mit der Bezeichnung „EINFÄRBEN“ hinzu.
*
*Wenn der Benutzer:
*
*eine Zahl eingibt,
*
*einen der Radiobuttons auswählt
*
*und anschließend auf „EINFÄRBEN“ klickt,
*dann soll das ALV-Grid ausgewertet werden.
*
*Alle Zellen in der Spalte SEATSOCC (Anzahl der verkauften Sitze), die den gewählten Vergleich (größer oder kleiner als die eingegebene Zahl) erfüllen, sollen automatisch in Rot eingefärbt werden.


TYPES: BEGIN OF gty_str.
    INCLUDE STRUCTURE sflight.
TYPES: cell_color TYPE lvc_t_scol.
TYPES: END OF gty_str.

DATA: gv_number  TYPE i,
      gv_smaller TYPE c LENGTH 1,
      gv_bigger  TYPE c LENGTH 1.


DATA: gt_sflight   TYPE TABLE OF gty_str,
      gs_sflight   TYPE gty_str,
      gt_fcat      TYPE lvc_t_fcat,
      gs_fcat      TYPE lvc_s_fcat,
      gs_layout    TYPE lvc_s_layo,
      go_container TYPE REF TO cl_gui_custom_container,
      go_alv       TYPE REF TO cl_gui_alv_grid.


START-OF-SELECTION.

  CALL SCREEN 0300.

MODULE status_0300 OUTPUT.
  SET PF-STATUS 'PF_STATUS_16'.
*  SET TITLEBAR 'xxx'.

  PERFORM alv.
ENDMODULE.


MODULE user_command_0300 INPUT.

  DATA: ls_cell_color TYPE lvc_s_scol.

  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.
    WHEN 'COLOR'.

      IF gv_bigger = abap_true.

        LOOP AT gt_sflight INTO gs_sflight.

          CLEAR: gs_sflight-cell_color.

          modify gt_sflight from gs_sflight.

        ENDLOOP.

        LOOP AT gt_sflight INTO gs_sflight WHERE seatsocc > gv_number.

          ls_cell_color-fname         = 'SEATSOCC'.
          ls_cell_color-color-col     = '6'.
          ls_cell_color-color-int     = '1'.
          ls_cell_color-color-inv     = '0'.

          APPEND ls_cell_color TO gs_sflight-cell_color.

          MODIFY gt_sflight FROM gs_sflight TRANSPORTING cell_color WHERE carrid = gs_sflight-carrid AND
                                                                          connid = gs_sflight-connid AND
                                                                          fldate = gs_sflight-fldate.

        ENDLOOP.

      ELSE.

        LOOP AT gt_sflight INTO gs_sflight.

          CLEAR: gs_sflight-cell_color.
          modify gt_sflight from gs_sflight.

        ENDLOOP.

        LOOP AT gt_sflight INTO gs_sflight WHERE seatsocc <= gv_number.

          ls_cell_color-fname         = 'SEATSOCC'.
          ls_cell_color-color-col     = '6'.
          ls_cell_color-color-int     = '1'.
          ls_cell_color-color-inv     = '0'.

          APPEND ls_cell_color TO gs_sflight-cell_color.

          MODIFY gt_sflight FROM gs_sflight TRANSPORTING cell_color WHERE carrid = gs_sflight-carrid AND
                                                                          connid = gs_sflight-connid AND
                                                                          fldate = gs_sflight-fldate.
        ENDLOOP.

      ENDIF.

*  	WHEN OTHERS.
  ENDCASE.

ENDMODULE.

FORM alv.

  IF gt_sflight IS INITIAL.
    SELECT * FROM sflight
      INTO CORRESPONDING FIELDS OF TABLE gt_sflight.
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
  gs_layout-ctab_fname      = 'CELL_COLOR'.


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
