*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_43
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_43.


PARAMETERS: p_scarr  RADIOBUTTON GROUP abc,
            p_spfli  RADIOBUTTON GROUP abc,
            p_sflght RADIOBUTTON GROUP abc.

DATA: gt_scarr   TYPE TABLE OF scarr,
      gt_spfli   TYPE TABLE OF spfli,
      gt_sflight TYPE TABLE OF sflight,
      gv_name    TYPE tabname.

DATA: gs_layout TYPE lvc_s_layo.
DATA: gt_fieldcat TYPE lvc_t_fcat.

FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE.

START-OF-SELECTION.

  IF p_scarr = abap_true.

    ASSIGN gt_scarr TO <fs_table>.

    gv_name = 'Scarr'.

  ELSEIF p_spfli = abap_true.

    ASSIGN gt_spfli TO <fs_table>.

    gv_name = 'Spfli'.

  ELSEIF p_sflght = abap_true.

    ASSIGN gt_sflight TO <fs_table>.

    gv_name = 'Sflight'.

  ENDIF.


  PERFORM get_data USING gv_name.
  PERFORM field_cat.
  PERFORM layout.
  PERFORM alv.

*  BREAK-POINT.
*----------------------------------------------------------------------*
FORM get_data  USING    p_gv_name
                        .
  SELECT * FROM (p_gv_name)
    INTO TABLE <fs_table>.


ENDFORM.

*----------------------------------------------------------------------*
FORM field_cat.


  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = gv_name
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.


ENDFORM.

FORM layout.


  gs_layout-zebra                 = abap_true.
  gs_layout-col_opt               = abap_true.

ENDFORM.

FORM alv.

  FIELD-SYMBOLS: <fs_std>   TYPE STANDARD TABLE.

  ASSIGN <fs_table> to <fs_std>.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
   EXPORTING
     I_CALLBACK_PROGRAM                = sy-repid
     IS_LAYOUT_LVC                     = gs_layout
     IT_FIELDCAT_LVC                   = gt_fieldcat
    TABLES
      t_outtab                         = <fs_std>
   EXCEPTIONS
     PROGRAM_ERROR                     = 1
     OTHERS   = 2 .
  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.


ENDFORM.
