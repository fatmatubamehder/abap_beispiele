*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_48
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_48.


"append initial line to komutu ile field catalogu kendimiz olusturmak icin. Kendi tanimladigim bir tablo tipinin ALV'sini gösterirken.



TYPES: BEGIN OF gty_str,
         box       TYPE c LENGTH 1,
         carrid    TYPE c LENGTH 3,
         connid    TYPE c LENGTH 4,
         fldate    TYPE datum,
         price     TYPE p DECIMALS 2,
         currency  TYPE c LENGTH 3,
         planetype TYPE c LENGTH 10,
       END OF gty_str.

DATA: gt_table  TYPE TABLE OF gty_str,
      gt_fcat   TYPE slis_t_fieldcat_alv,
      gs_layout TYPE slis_layout_alv.

START-OF-SELECTION.


  SELECT * FROM sflight
    INTO CORRESPONDING FIELDS OF TABLE gt_table.

  APPEND INITIAL LINE TO gt_fcat ASSIGNING FIELD-SYMBOL(<gs_fcat>).

  <gs_fcat>-fieldname = 'CARRID'.
  <gs_fcat>-seltext_m = 'Airline Code'.
  <gs_fcat>-key       =  abap_true.
  <gs_fcat>-just       = 'C'.

  APPEND INITIAL LINE TO gt_fcat ASSIGNING <gs_fcat>.

  <gs_fcat>-fieldname = 'CONNID'.
  <gs_fcat>-seltext_m = 'Connection Number'.
  <gs_fcat>-key       =  abap_true.
  <gs_fcat>-just       = 'C'.

  APPEND INITIAL LINE TO gt_fcat ASSIGNING <gs_fcat>.

  <gs_fcat>-fieldname = 'FLDATE'.
  <gs_fcat>-seltext_m = 'Flight Date'.
  <gs_fcat>-key       =  abap_true.
  <gs_fcat>-just       = 'C'.


  APPEND INITIAL LINE TO gt_fcat ASSIGNING <gs_fcat>.

  <gs_fcat>-fieldname = 'PRICE'.
  <gs_fcat>-seltext_m = 'Airfare'.


  APPEND INITIAL LINE TO gt_fcat ASSIGNING <gs_fcat>.

  <gs_fcat>-fieldname = 'CURRENCY'.
  <gs_fcat>-seltext_m = 'Local Currency'.
  <gs_fcat>-just       = 'C'.

  APPEND INITIAL LINE TO gt_fcat ASSIGNING <gs_fcat>.

  <gs_fcat>-fieldname = 'PLANETYPE'.
  <gs_fcat>-seltext_m = 'Aircraft Type'.

  gs_layout-zebra                = abap_true.
  gs_layout-colwidth_optimize    = abap_true.
  gs_layout-box_fieldname        = 'BOX'.


  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      is_layout          = gs_layout
      it_fieldcat        = gt_fcat
    TABLES
      t_outtab           = gt_table
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc IS NOT INITIAL.
    MESSAGE 'AlV olustururken sorun olustu' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
