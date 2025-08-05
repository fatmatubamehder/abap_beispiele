*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_18
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_18.

TYPES: BEGIN OF gty_str.
    INCLUDE STRUCTURE sflight.
TYPES: trf TYPE c LENGTH 4.
TYPES: END OF gty_str.


DATA: gt_sflight   TYPE TABLE OF gty_str,
      gs_sflight   TYPE gty_str,
      gt_fcat      TYPE lvc_t_fcat,
      gs_fcat      TYPE lvc_s_fcat,
      gs_layout    TYPE lvc_s_layo,
      go_container TYPE REF TO cl_gui_custom_container,
      go_alv       TYPE REF TO cl_gui_alv_grid.


START-OF-SELECTION.

  CALL SCREEN 0100.
*&---------------------------------------------------------------------*

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'PF_STATUS_18'.
*  SET TITLEBAR 'xxx'.

  PERFORM alv.
ENDMODULE.

MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.
    WHEN 'PRICE'.

      LOOP AT gt_sflight INTO gs_sflight.

        IF gs_sflight-price < 500.

          gs_sflight-trf  = '@08@'.

        ELSEIF gs_sflight-price >= 500 AND gs_sflight-price < 750.

          gs_sflight-trf  = '@09@'.

        ELSEIF gs_sflight-price >= 750.

          gs_sflight-trf  = '@0A@'.

        ENDIF.

        MODIFY gt_sflight FROM gs_sflight INDEX sy-tabix.

      ENDLOOP.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY fieldname = 'TRF'.

      IF sy-subrc IS INITIAL.

        gs_fcat-col_pos      = 5.
        gs_fcat-scrtext_m    = 'Price Trafic Lights'.

        MODIFY gt_fcat FROM gs_fcat INDEX sy-tabix.

      ELSE.

        gs_fcat-fieldname    =  'TRF'.
        gs_fcat-col_pos      = 5.
        gs_fcat-scrtext_m    = 'Price Trafic Lights'.

        APPEND gs_fcat TO gt_fcat.
        CLEAR: gs_fcat.

      ENDIF.

    WHEN 'SEATSMAX'.

      LOOP AT gt_sflight INTO gs_sflight.

        IF gs_sflight-seatsmax < 150.
          gs_sflight-trf  = '@08@'.

        ELSEIF gs_sflight-seatsmax >= 150 AND gs_sflight-seatsmax < 300.

          gs_sflight-trf  = '@09@'.

        ELSEIF gs_sflight-seatsmax >= 300.

          gs_sflight-trf  = '@0A@'.

        ENDIF.

        MODIFY gt_sflight FROM gs_sflight INDEX sy-tabix.

      ENDLOOP.

      READ TABLE gt_fcat INTO gs_fcat WITH KEY fieldname = 'TRF'.

      IF sy-subrc IS INITIAL.

        gs_fcat-col_pos      = 8.
        gs_fcat-scrtext_m    = 'Price Trafic Lights'.
        MODIFY gt_fcat FROM gs_fcat INDEX sy-tabix.

      ELSE.

        gs_fcat-fieldname    =  'TRF'.
        gs_fcat-col_pos      = 8.
        gs_fcat-scrtext_m    = 'Price Trafic Lights'.

        APPEND gs_fcat TO gt_fcat.
        CLEAR: gs_fcat.

      ENDIF.

  ENDCASE.

ENDMODULE.

FORM alv.

  IF gt_sflight IS INITIAL.

    SELECT * FROM sflight
      INTO CORRESPONDING FIELDS OF TABLE gt_sflight.

  ENDIF.

  IF gt_fcat IS INITIAL.

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

  ENDIF.

  IF gs_layout IS INITIAL.

    gs_layout-zebra            = abap_true.
    gs_layout-cwidth_opt       = abap_true.
    gs_layout-sel_mode         = 'A'.

  ENDIF.

  IF go_alv IS INITIAL.

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
      BREAK-POINT.
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
      BREAK-POINT.
    ENDIF.


    go_alv->set_table_for_first_display(
  EXPORTING
    is_layout                     =    gs_layout
  CHANGING
    it_outtab                     =    gt_sflight
    it_fieldcatalog               =    gt_fcat
EXCEPTIONS
  invalid_parameter_combination = 1
  program_error                 = 2
  too_many_lines                = 3
  OTHERS                        = 4 ).
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ELSE.

    go_alv->set_frontend_fieldcatalog( it_fieldcatalog = gt_fcat ).
    go_alv->set_frontend_layout( is_layout = gs_layout ).

    go_alv->refresh_table_display(
   EXCEPTIONS
     finished       = 1
     OTHERS         = 2 ).
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ENDIF.

ENDFORM.
