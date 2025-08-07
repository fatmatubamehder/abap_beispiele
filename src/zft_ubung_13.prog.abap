*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_13
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_13.


*Nehmen Sie vom Benutzer einen Currcode entgegen. Holen Sie für die zu diesem Currcode passenden Carrids
* aus der Tabelle SCARR die Bookid- und Customid-Daten aus der Tabelle SBOOK mit FOR ALL ENTRIES.
* Implementieren Sie dies durch die Definition einer lokalen Klasse. Zeigen Sie die ermittelte Ergebnistabelle mit ALV an.


CLASS lcl_get_data_selected DEFINITION.

  PUBLIC SECTION.

    DATA: mt_scarr TYPE zft_tt_scarr.
    DATA: mt_sbook TYPE TABLE OF zft_s_sbook_vers.



    METHODS: get_data_scarr IMPORTING iv_currcode TYPE s_currcode.

    METHODS: get_data_sbook.

    METHODS: display_alv.

ENDCLASS.

CLASS lcl_get_data_selected IMPLEMENTATION.

  METHOD get_data_scarr.

    SELECT * FROM scarr
      INTO TABLE mt_scarr
      WHERE currcode = iv_currcode.

  ENDMETHOD.

  METHOD get_data_sbook.

    IF mt_scarr IS NOT INITIAL.

      SELECT * FROM sbook
        INTO CORRESPONDING FIELDS OF TABLE mt_sbook UP TO 250 ROWS
        FOR ALL ENTRIES IN mt_scarr
        WHERE carrid = mt_scarr-carrid.

    ENDIF.

  ENDMETHOD.

  METHOD display_alv.

    DATA: lt_fcat TYPE slis_t_fieldcat_alv.
    DATA: ls_layout TYPE slis_layout_alv.

    CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'ZFT_S_SBOOK_VERS'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = lt_fcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

    ls_layout-zebra             = abap_true.
    ls_layout-colwidth_optimize = abap_true.
    ls_layout-box_fieldname     = 'A'.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        i_callback_program = sy-repid
        is_layout          = ls_layout
        it_fieldcat        = lt_fcat
      TABLES
        t_outtab           = mt_sbook
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ENDMETHOD.

ENDCLASS.


PARAMETERS: p_curcd TYPE zft_de_currcode.

DATA: gt_scarr TYPE TABLE OF zft_tt_scarr.
DATA: gt_sbook TYPE TABLE OF zft_tt_sbook.
DATA: go_obj TYPE REF TO lcl_get_data_selected.

START-OF-SELECTION.

  CREATE OBJECT go_obj.

  go_obj->get_data_scarr( iv_currcode = p_curcd ).

  go_obj->get_data_sbook( ).

  go_obj->display_alv( ).
