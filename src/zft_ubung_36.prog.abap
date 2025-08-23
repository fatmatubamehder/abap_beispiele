*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFT_UBUNG_36.


*Erstellen Sie einen neuen Bericht und erfassen Sie vom Benutzer eine CARRID.
*Stellen Sie sicher, dass dieser Parameter im Bericht als Dropdown angezeigt werden kann.
*Definieren Sie außerdem auf dem Bildschirm für jede Spalte Ihrer eigenen SCARR-Tabelle (z. B. ZCM_SCARR) einen Parameter.
*Wenn der Benutzer eine CARRID ausgewählt und anschließend die Schaltfläche „Ausführen“ gedrückt hat, sollen die unten befindlichen
*Felder mit den entsprechenden Werten gefüllt werden.
*Wenn der Benutzer die unten befindlichen Felder selbst ausfüllt und anschließend die Schaltfläche „Ausführen“ drückt, soll in Ihrer
*eigenen SCARR-Tabelle ein neuer Datensatz angelegt werden.
*Der CARRID-Wert des neu angelegten Datensatzes soll zusätzlich in die Dropdown-Liste des CARRID-Parameters aufgenommen werden.



SELECTION-SCREEN BEGIN OF BLOCK A1 WITH FRAME TITLE TEXT-001.

   SELECTION-SCREEN BEGIN OF LINE.


    SELECTION-SCREEN COMMENT 1(6) TEXT-007.
    SELECTION-SCREEN POSITION 9.

    PARAMETERS: p_carrid TYPE c LENGTH 3 as LISTBOX VISIBLE LENGTH 5.

    SELECTION-SCREEN PUSHBUTTON 20(30) bt1 USER-COMMAND run.
    SELECTION-SCREEN PUSHBUTTON 55(30) bt2 USER-COMMAND add.

   SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK a1.


SELECTION-SCREEN BEGIN OF BLOCK A2 WITH FRAME TITLE TEXT-002.

  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 1(6) TEXT-003.
    SELECTION-SCREEN POSITION 9.

    PARAMETERS: p_cid_2 TYPE c LENGTH 3 VISIBLE LENGTH 5.

   SELECTION-SCREEN COMMENT 18(10) TEXT-004.
   SELECTION-SCREEN POSITION 29.
*
    PARAMETERS: p_carr TYPE S_CARRNAME VISIBLE LENGTH 20.
*
   SELECTION-SCREEN COMMENT 52(10) TEXT-005.
   SELECTION-SCREEN POSITION 63.
*
    PARAMETERS: p_curr TYPE S_CURRCODE VISIBLE LENGTH 6.
*
   SELECTION-SCREEN COMMENT 72(5) TEXT-006.
   SELECTION-SCREEN POSITION 79.
*
    PARAMETERS: p_url TYPE S_CARRURL VISIBLE LENGTH 20.
*
  SELECTION-SCREEN END OF LINE.


SELECTION-SCREEN END OF BLOCK a2.




data: gt_values TYPE vrm_values.
data: gs_value TYPE vrm_value.
data: gt_carrid TYPE TABLE OF s_carr_id.
data: gs_carrid TYPE s_carr_id.
data: gt_scarr TYPE TABLE OF ZFT_SCARR_2.
data: gs_scarr TYPE ZFT_SCARR_2.



INITIALIZATION.

select carrid from ZFT_SCARR_2
  into table gt_carrid.

  LOOP AT gt_carrid into gs_carrid.

      gs_value-key  = gs_carrid.
      gs_value-text = gs_carrid.

      APPEND gs_value to gt_values.

  ENDLOOP.


  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id                    = 'P_CARRID'
      values                = gt_values
   EXCEPTIONS
     ID_ILLEGAL_NAME       = 1
     OTHERS                = 2 .
  IF sy-subrc is NOT INITIAL.
    BREAK-POINT.
  ENDIF.

clear:gt_values.

CALL FUNCTION 'ICON_CREATE'
  EXPORTING
   name                        = icon_checked
   TEXT                        = 'RUN'
   INFO                        = 'Execute'
 IMPORTING
   RESULT                      = bt1
 EXCEPTIONS
   ICON_NOT_FOUND              = 1
   OUTPUTFIELD_TOO_SHORT       = 2
   OTHERS                      = 3 .
IF sy-subrc is NOT INITIAL.
  BREAK-POINT.
ENDIF.


CALL FUNCTION 'ICON_CREATE'
  EXPORTING
   name                        = icon_create
   TEXT                        = 'ADD'
   INFO                        = 'Fügt neue Data hinzu'
 IMPORTING
   RESULT                      = bt2
 EXCEPTIONS
   ICON_NOT_FOUND              = 1
   OUTPUTFIELD_TOO_SHORT       = 2
   OTHERS                      = 3 .
IF sy-subrc is NOT INITIAL.
  BREAK-POINT.
ENDIF.



at SELECTION-SCREEN.

  CASE sy-ucomm.
    WHEN 'RUN'.

      select single * from ZFT_SCARR_2
        into gs_scarr where carrid = p_carrid.


      p_cid_2 = gs_scarr-carrid.
      p_carr  = gs_scarr-carrname.
      p_curr  = gs_scarr-currcode.
      p_url   = gs_scarr-url.

      clear: gs_scarr.

    WHEN 'ADD'.

      gs_scarr-carrid   = p_cid_2.
      gs_scarr-carrname = p_carr.
      gs_scarr-currcode = p_curr.
      gs_scarr-url      = p_url .

      modify ZFT_SCARR_2 from gs_scarr.

  ENDCASE.







*  BREAK-POINT.
