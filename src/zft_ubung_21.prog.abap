*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_21
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_21.

PARAMETERS: p_name TYPE c LENGTH 20.
PARAMETERS: p_nachn TYPE c LENGTH 20.
PARAMETERS: p_datum TYPE datum.

DATA: gt_table TYPE TABLE OF zft_personal_01,
      gs_str   TYPE zft_personal_01,
      gv_jahr  TYPE n LENGTH 4,
      gv_monat TYPE n LENGTH 2,
      gv_tag   TYPE c LENGTH 1.


START-OF-SELECTION.


DELETE FROM ZFT_PERSONAL_01.


  gs_str-name         = p_name.
  gs_str-nachname     = p_nachn.
  gs_str-geburtsdatum = p_datum.


  CALL FUNCTION 'NUMBER_GET_NEXT'
    EXPORTING
      nr_range_nr             = '01'           "snro objesindeki ilk siradaki aralik
      object                  = 'ZFT_SNRO_1'   "snro objesini sayiyi üretmek icin kullandim
    IMPORTING
      number                  = gs_str-id
    EXCEPTIONS
      interval_not_found      = 1
      number_range_not_intern = 2
      object_not_found        = 3
      quantity_is_0           = 4
      quantity_is_not_1       = 5
      interval_overflow       = 6
      buffer_overflow         = 7
      OTHERS                  = 8.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.

  gv_jahr   = p_datum+0(4).
  gv_monat  = p_datum+4(2).
  gv_tag   = p_datum+6(2).

  gs_str-g_jahr = gv_jahr.

  CASE gv_monat.
    WHEN '01'.
      gs_str-g_monat = 'JANUARY'.
    WHEN '02'.
      gs_str-g_monat = 'FEBRUARY'.
    WHEN '03'.
      gs_str-g_monat = 'MÄRZ'.
    WHEN '04'.
      gs_str-g_monat = 'APRIL'.
    WHEN '05'.
      gs_str-g_monat = 'MAI'.
    WHEN '06'.
      gs_str-g_monat = 'JUNI'.
    WHEN '07'.
      gs_str-g_monat = 'JULI'.
    WHEN '08'.
      gs_str-g_monat = 'AUGUST'.
    WHEN '09'.
      gs_str-g_monat = 'SEPTEMBER'.
    WHEN '10'.
      gs_str-g_monat = 'OCTOBER'.
    WHEN '11'.
      gs_str-g_monat = 'NOVEMBER'.
    WHEN '12'.
      gs_str-g_monat = 'DEZEMBER'.
  ENDCASE.

  CALL FUNCTION 'DATE_COMPUTE_DAY'
    EXPORTING
      date = p_datum
    IMPORTING
      day  = gv_tag.




  CASE gv_tag.
    WHEN '1'.
      gs_str-g_tag = 'MONTAG'.
    WHEN '2'.
      gs_str-g_tag = 'DIENSTAG'.
    WHEN '3'.
      gs_str-g_tag = 'MITTWOCH'.
    WHEN '4'.
      gs_str-g_tag = 'DONNERSTAG'.
    WHEN '5'.
      gs_str-g_tag = 'FREITAG'.
    WHEN '6'.
      gs_str-g_tag = 'SAMSTAG'.
    WHEN '7'.
      gs_str-g_tag = 'SONNTAG'.

  ENDCASE.


  INSERT zft_personal_01 FROM gs_str.
