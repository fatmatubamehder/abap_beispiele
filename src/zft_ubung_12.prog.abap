*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_12
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_12.

*In dieser Übung haben wir die vom Benutzer gewünschte Datenbanktabelle als ALV ausgegeben.
*Dabei haben wir die Methode mit einer lokalen Klasse verwendet.
*
*Wir haben Instance-Public- und Instance-Protected-Methoden eingesetzt und mit dem Constructor die Daten für den Algorithmus vorbereitet.



CLASS lcl_data_alv DEFINITION.

  PUBLIC SECTION.

    DATA: mt_scarr TYPE zft_tt_scarr.
    DATA: mt_spfli TYPE zft_tt_spfli.
    DATA: mt_sflight TYPE zft_tt_sflight.
    DATA: mt_fcat TYPE slis_t_fieldcat_alv.
    DATA: ms_layout TYPE slis_layout_alv.




    METHODS: constructor IMPORTING iv_scarr   TYPE char1
                                   iv_spfli   TYPE char1
                                   iv_sflight TYPE char1.


    METHODS: get_fcat IMPORTING iv_tabname TYPE char30.

    METHODS: get_layout.

    METHODS: alv_scarr.

    METHODS: alv_spfli.

    METHODS: alv_sflight.


ENDCLASS.

CLASS lcl_data_alv IMPLEMENTATION.

  METHOD constructor.

    IF iv_scarr = abap_true.

      SELECT * FROM scarr
        INTO TABLE mt_scarr.

    ELSEIF iv_spfli = abap_true.

      SELECT * FROM spfli
        INTO TABLE mt_spfli.

    ELSEIF iv_sflight = abap_true.

      SELECT * FROM sflight
        INTO TABLE mt_sflight.

    ENDIF.

  ENDMETHOD.

  METHOD get_fcat.

    CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = iv_tabname
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = mt_fcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ENDMETHOD.

  METHOD get_layout.

    ms_layout-zebra               = abap_true.
    ms_layout-colwidth_optimize   = abap_true.
    ms_layout-box_fieldname       = 'A'.

  ENDMETHOD.

  METHOD alv_scarr.


    get_fcat( iv_tabname = 'Scarr' ).

    get_layout( ).

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        i_callback_program = sy-repid
        is_layout          = ms_layout
        it_fieldcat        = mt_fcat
      TABLES
        t_outtab           = mt_scarr
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ENDMETHOD.

  METHOD alv_spfli.


    get_fcat( iv_tabname = 'Spfli' ).

    get_layout( ).

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        i_callback_program = sy-repid
        is_layout          = ms_layout
        it_fieldcat        = mt_fcat
      TABLES
        t_outtab           = mt_spfli
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ENDMETHOD.

  METHOD alv_sflight.


    get_fcat( iv_tabname = 'Sflight' ).

    get_layout( ).

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        i_callback_program = sy-repid
        is_layout          = ms_layout
        it_fieldcat        = mt_fcat
      TABLES
        t_outtab           = mt_sflight
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ENDMETHOD.


ENDCLASS.


PARAMETERS: p_scarr RADIOBUTTON GROUP abc.
PARAMETERS: p_spfli RADIOBUTTON GROUP abc.
PARAMETERS: p_sflght RADIOBUTTON GROUP abc.


DATA: gt_scarr TYPE TABLE OF zmc_tt_scarr.
DATA: gt_spfli TYPE TABLE OF zmc_tt_spfli.
DATA: gt_sflight TYPE TABLE OF zmc_tt_sflight.
DATA: go_obj TYPE REF TO lcl_data_alv.

START-OF-SELECTION.

  CREATE OBJECT go_obj
    EXPORTING
      iv_scarr   = p_scarr
      iv_spfli   = p_spfli
      iv_sflight = p_sflght.

  IF p_scarr = abap_true.

    go_obj->alv_scarr( ).

  ELSEIF p_spfli = abap_true.

    go_obj->alv_spfli( ).

  ELSEIF p_sflght = abap_true.

    go_obj->alv_sflight( ).

  ENDIF.
