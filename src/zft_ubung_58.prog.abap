*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_58
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_58.

TYPES: BEGIN OF gty_str,
         id    TYPE c LENGTH 11,
         name  TYPE c LENGTH 20,
         nname TYPE c LENGTH 20,
         bank  TYPE string,
       END OF gty_str.

TYPES: BEGIN OF gty_bank,
         bank TYPE string,
       END OF gty_bank.

TYPES: BEGIN OF gty_static,
         id    TYPE c LENGTH 11,
         name  TYPE c LENGTH 20,
         nname TYPE c LENGTH 20,
       END OF gty_static.

DATA: gt_table   TYPE TABLE OF gty_str,
      gt_bank    TYPE TABLE OF gty_bank,
      gt_static  TYPE TABLE OF gty_static,
      gt_fcat    TYPE lvc_t_fcat,
      gv_pointer TYPE REF TO data.

FIELD-SYMBOLS: <fs_table> TYPE STANDARD TABLE.

START-OF-SELECTION.


  "Füll die Data aus.

  APPEND INITIAL LINE TO gt_table ASSIGNING FIELD-SYMBOL(<gs_str>).
  <gs_str>-id     = '87102345093'.
  <gs_str>-name   = 'Mehmet'.
  <gs_str>-nname  = 'Öztürk'.
  <gs_str>-bank   = 'Is Bankasi'.


  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-id     = '87102345093'.
  <gs_str>-name   = 'Mehmet'.
  <gs_str>-nname  = 'Öztürk'.
  <gs_str>-bank   = 'Ziraat Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-id     = '87102345093'.
  <gs_str>-name   = 'Mehmet'.
  <gs_str>-nname  = 'Öztürk'.
  <gs_str>-bank   = 'Akbank'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-id     = '34502712093'.
  <gs_str>-name   = 'Ali'.
  <gs_str>-nname  = 'Öztürk'.
  <gs_str>-bank   = 'Turkiye Ziraat Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-id     = '87102712879'.
  <gs_str>-name   = 'Ayse'.
  <gs_str>-nname  = 'Öztürk'.
  <gs_str>-bank   = 'Garanti Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-id      = '87102712879'.
  <gs_str>-name    = 'Ayse'.
  <gs_str>-nname   = 'Öztürk'.
  <gs_str>-bank    = 'Is Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-id     = '65421712093'.
  <gs_str>-name   = 'Ahmet'.
  <gs_str>-nname  = 'Öztürk'.
  <gs_str>-bank   = 'Vakif Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-id     = '65421712093'.
  <gs_str>-name   = 'Ahmet'.
  <gs_str>-nname  = 'Öztürk'.
  <gs_str>-bank   = 'ING Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-id     = '98765712093'.
  <gs_str>-name   = 'Veli'.
  <gs_str>-nname  = 'Öztürk'.
  <gs_str>-bank   = 'ING Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-id      = '98765712093'.
  <gs_str>-name    = 'Veli'.
  <gs_str>-nname   = 'Öztürk'.
  <gs_str>-bank    = 'Garanti Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-id     = '10982712093'.
  <gs_str>-name   = 'Serdar'.
  <gs_str>-nname  = 'Öztürk'.
  <gs_str>-bank   = 'Ziraat Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-id      = '10982712093'.
  <gs_str>-name    = 'Serdar'.
  <gs_str>-nname   = 'Öztürk'.
  <gs_str>-bank    = 'ING Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-id     = '39789712193'.
  <gs_str>-name   = 'Nese'.
  <gs_str>-nname  = 'Öztürk'.
  <gs_str>-bank   = 'Is Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-id      = '39789712093'.
  <gs_str>-name    = 'Meryem'.
  <gs_str>-nname   = 'Öztürk'.
  <gs_str>-bank    = 'Garanti Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-id      = '39789712093'.
  <gs_str>-name    = 'Meryem'.
  <gs_str>-nname   = 'Öztürk'.
  <gs_str>-bank    = 'Fiba Bankasi'.

  APPEND INITIAL LINE TO gt_table ASSIGNING <gs_str>.
  <gs_str>-id      = '39789712088'.
  <gs_str>-name    = 'Fatma'.
  <gs_str>-nname   = 'Öztürk'.
  <gs_str>-bank    = 'Sparkasse_Bank'.



  "Ziehe die Bank- und Personendaten aus der Tabelle

  LOOP AT gt_table INTO DATA(gs_table).
    APPEND INITIAL LINE TO gt_bank ASSIGNING FIELD-SYMBOL(<gs_bank>).
    <gs_bank>-bank = gs_table-bank.

    APPEND INITIAL LINE TO gt_static ASSIGNING FIELD-SYMBOL(<gs_static>).
    <gs_static>-id      = gs_table-id.
    <gs_static>-name    = gs_table-name.
    <gs_static>-nname   = gs_table-nname.

  ENDLOOP.


  "Delete die wiederholten Daten

  SORT gt_bank.
  DELETE ADJACENT DUPLICATES FROM gt_bank.

  SORT gt_static.
  DELETE ADJACENT DUPLICATES FROM gt_static.


  "Erstelle die fieldcatalog

  APPEND INITIAL LINE TO gt_fcat ASSIGNING FIELD-SYMBOL(<gs_fcat>).
  <gs_fcat>-fieldname = 'ID'.
  <gs_fcat>-scrtext_m = 'ID Nummer'.
  <gs_fcat>-inttype   = 'C'.
  <gs_fcat>-intlen    = '11'.


  APPEND INITIAL LINE TO gt_fcat ASSIGNING <gs_fcat>.
  <gs_fcat>-fieldname = 'NAME'.
  <gs_fcat>-scrtext_m = 'Name'.
  <gs_fcat>-inttype   = 'C'.
  <gs_fcat>-intlen    = '20'.

  APPEND INITIAL LINE TO gt_fcat ASSIGNING <gs_fcat>.
  <gs_fcat>-fieldname = 'NACHNAME'.
  <gs_fcat>-scrtext_m = 'Nachname'.
  <gs_fcat>-inttype   = 'C'.
  <gs_fcat>-intlen    = '20'.


  LOOP AT gt_bank ASSIGNING <gs_bank>.

    APPEND INITIAL LINE TO gt_fcat ASSIGNING <gs_fcat>.

    <gs_fcat>-scrtext_m = <gs_bank>-bank.

    TRANSLATE <gs_bank>-bank TO UPPER CASE.
    TRANSLATE <gs_bank>-bank USING ' _'.

    <gs_fcat>-fieldname = <gs_bank>-bank.
    <gs_fcat>-inttype   = 'C'.
    <gs_fcat>-intlen    = '20'.

  ENDLOOP.

  "Erstelle die dynamic Tabelle durch gv_pointer

  cl_alv_table_create=>create_dynamic_table(
    EXPORTING
      it_fieldcatalog           =  gt_fcat
    IMPORTING
      ep_table                  =  gv_pointer
    EXCEPTIONS
      generate_subpool_dir_full = 1
      OTHERS                    = 2 ).
  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.


  ASSIGN gv_pointer->* TO <fs_table>.

  LOOP AT gt_static ASSIGNING <gs_static>.

    APPEND INITIAL LINE TO <fs_table> ASSIGNING FIELD-SYMBOL(<fs_str>).

    ASSIGN COMPONENT 'ID' OF STRUCTURE <fs_str> TO FIELD-SYMBOL(<fs_field>).
    IF sy-subrc IS INITIAL.
      <fs_field> = <gs_static>-id.
    ENDIF.

    ASSIGN COMPONENT 'NAME' OF STRUCTURE <fs_str> TO <fs_field>.
    IF sy-subrc IS INITIAL.
      <fs_field> = <gs_static>-name.
    ENDIF.

    ASSIGN COMPONENT 'NACHNAME' OF STRUCTURE <fs_str> TO <fs_field>.
    IF sy-subrc IS INITIAL.
      <fs_field> = <gs_static>-nname.
    ENDIF.

    LOOP AT gt_table INTO gs_table WHERE id = <gs_static>-id.

      TRANSLATE gs_table-bank USING ' _'.

      ASSIGN COMPONENT gs_table-bank OF STRUCTURE <fs_str> TO <fs_field>.
      IF sy-subrc IS INITIAL.
        <fs_field> = abap_true.
      ENDIF.

    ENDLOOP.


  ENDLOOP.


  "layout für ALV

  DATA(gs_layout) = VALUE lvc_s_layo( zebra = abap_true
                                      cwidth_opt = abap_true
                                      sel_mode   = 'A' ).


  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program = sy-repid
      is_layout_lvc      = gs_layout
      it_fieldcat_lvc    = gt_fcat
    TABLES
      t_outtab           = <fs_table>
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.



  BREAK-POINT.
